package io.thatcomeup.passaround.share

import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Parcelable
import android.util.Log
import io.thatcomeup.passaround.channels.ShareChannel

class ShareUtils(private val shareChannel: ShareChannel) {
    fun handleSentText(intent: Intent) {
        intent.getStringExtra(Intent.EXTRA_TEXT)?.let {
            shareChannel.sendText(it)
        }
    }

    fun handleSentImage(intent: Intent, contentResolver: ContentResolver) {
        try {
            (intent.parcelable<Parcelable>(Intent.EXTRA_STREAM) as Uri).let {
                contentResolver.openInputStream(it)?.use { stream ->
                    val byteArray: ByteArray = stream.buffered().readBytes()
                    shareChannel.sendImage(byteArray)
                }
            }
        } catch (e: Error) {
            Log.e(ShareUtils::class.java.simpleName, e.message.toString())
        }
    }

    // code taken from https://stackoverflow.com/questions/73019160/the-getparcelableextra-method-is-deprecated
    private inline fun <reified T : Parcelable> Intent.parcelable(key: String): T? = when {
        Build.VERSION.SDK_INT >= 33 -> getParcelableExtra(key, T::class.java)
        else -> @Suppress("DEPRECATION") getParcelableExtra(key) as? T
    }
}