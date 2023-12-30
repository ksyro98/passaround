package io.thatcomeup.passaround

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import android.widget.Toast.LENGTH_SHORT
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.thatcomeup.passaround.channels.ShareChannel
import io.thatcomeup.passaround.channels.VersionChannel
import io.thatcomeup.passaround.share.ShareUtils


class MainActivity: FlutterActivity() {
    private val versionChannel = VersionChannel()
    private val shareChannel = ShareChannel()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        configureAllChannels(flutterEngine)
    }

    private fun configureAllChannels(flutterEngine: FlutterEngine) {
        versionChannel.configureChannel(flutterEngine)
        shareChannel.configureChannel(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        when (intent?.action) {
            Intent.ACTION_SEND -> {
                if(intent.type == "text/plain") {
                    ShareUtils(shareChannel).handleSentText(intent)
                } else if(intent.type?.startsWith("image/") == true) {
                    print("image")
                }
            }
        }
    }

}
