package io.thatcomeup.passaround.share

import android.content.Intent
import io.thatcomeup.passaround.channels.ShareChannel

class ShareUtils(private val shareChannel: ShareChannel) {
    fun handleSentText(intent: Intent) {
        intent.getStringExtra(Intent.EXTRA_TEXT)?.let {
            shareChannel.sendText(it)
        }
    }
}