package co.potatoproject.dt2w.rosemary

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class OnBootCompleteReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        val sIntent = Intent(context, DT2WServiceRosemary::class.java)
        context.startServiceAsUser(sIntent, UserHandle.CURRENT)
    }
} 
