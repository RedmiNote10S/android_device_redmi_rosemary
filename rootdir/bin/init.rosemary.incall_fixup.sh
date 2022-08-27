#!/system/bin/sh
LOG_TAG="MTKInCallDirtyFix"

log() {
    /system/bin/log -p D -t "${LOG_TAG}" $*
}

if [[ ! -f "/system/bin/tinymix" ]]
then
    /system/bin/log -p F -t "${LOG_TAG}" "Tinymix not found!"
fi

# Kanged from https://github.com/PotatoDevices/device_xiaomi_begonia/commit/64cc8c7f341ed0f2f5be0803e221ec86e27852d3
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 1; done
log "Started!"
sleep 10


# channel current volume (to find all params use "tinymix" command)
chcurrent=$(/system/bin/tinymix "ADDA_DL_GAIN" --v)
# used gain = chcurrent + our offset < max value by tinymix "ADDA_DL_GAIN"
chused=65535
# choose your min variant FIXME: maybe need rewrite script for using our min variant
#chmin=99
# start value need less than $callmin
callcurrentold=0

# write logs
log "Hardware Current Gain: $chcurrent"
log "Hardware Used Gain: $chused"

while true
do
# check call status
  callstatus=$(/system/bin/tinymix "Speech_SCP_CALL_STATE" --v)

  if [ "$callstatus" = 1 ]
    then
    # check call min volume in decimal FIXME: write HEX to DEX in one line
    callmin=$(/system/bin/service call audio 17 i32 0 | /system/bin/awk -F ' ' '{print $3}' | sed 's/0*//')
    callmin=$(echo "$((16#$callmin))")
    # check call max volume in decimal FIXME: write HEX to DEX in one line
    callmax=$(/system/bin/service call audio 18 i32 0 | /system/bin/awk -F ' ' '{print $3}' | sed 's/0*//')
    callmax=$(echo "$((16#$callmax))")
    # calculate interval for using via parabolic function
    interval=$(/system/bin/expr $chused / $callmax / $callmax)

    # enable deep buffer for fix crackling
    /system/bin/tinymix "deep_buffer_irq_cnt" 2048
    /system/bin/tinymix "deep_buffer_scenario" 1

	while [ "$callstatus" = 1 ]
	do
      # check choosen volume level FIXME: write HEX to DEX in one line
      callcurrent=$(/system/bin/service call audio 16 i32 0 | /system/bin/awk -F ' ' '{print $3}' | sed 's/0*//')
      callcurrent=$(echo "$((16#$callcurrent))")

      if [ "$callcurrentold" != "$callcurrent" ]
	    then
          # calculate and write the new channel volume via parabolic function & rewrite max Db for small speaker
          newchvol=$(/system/bin/expr $callcurrent \* $callcurrent \* $interval)
          /system/bin/tinymix "ADDA_DL_GAIN" $newchvol
	        /system/bin/tinymix "Handset_PGA_GAIN" 8Db
          log "Hardware In-Call Volume: $newchvol"
          callcurrentold=$callcurrent
      fi
      # Aims to fix the mic bug after speaker mode
      # Todo: Properly detect speaker mode
      if [ "$(/system/bin/tinymix "ADC_L_Mux" -v)" = "Idle" ]
      then
        log "Fixing mic"
        /system/bin/tinymix "PCM_2_PB_CH4 DL1_CH1" 0
        /system/bin/tinymix "PCM_2_PB_CH5 DL1_CH2" 0
        /system/bin/tinymix "Handset Volume" 0
        /system/bin/tinymix "LineoutR Volume" 31
        /system/bin/tinymix "Handset_PGA_GAIN" 8Db
        /system/bin/tinymix "Mic_Type_Mux_0" "DCC"
        /system/bin/tinymix "Mic_Type_Mux_2" "DCC"
        /system/bin/tinymix "SPK_AMP_MODE" "SPEAKER_MODE"
        /system/bin/tinymix "ADC_L_Mux" "Left Preamplifier"
        /system/bin/tinymix "ADC_R_Mux" "Right Preamplifier"
        /system/bin/tinymix "PGA_L_Mux" "AIN0"
        /system/bin/tinymix "PGA_R_Mux" "AIN2"
      fi
	  callstatus=$(/system/bin/tinymix "Speech_SCP_CALL_STATE" --v)
	  done
    # Restore $callcurrentold and chcurrent
    /system/bin/tinymix "ADDA_DL_GAIN" $chcurrent
    callcurrentold=0
  fi
sleep 2
done
