package io.thatcomeup.passaround

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import android.widget.Toast.LENGTH_SHORT
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val VERSION_CHANNEL = "io.thatcomeup.passaround/version"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VERSION_CHANNEL)
            .setMethodCallHandler { call, result ->
                if(call.method == "getVersion") {
                    try {
                        val version = NativeApiUtils().getVersion()
                        result.success(version)
                    } catch (e: Exception) {
                        result.error("CHANNEL_ERROR", "An error occurred on the Android side of native platform communication through channels.", e)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        when (intent?.action) {
            Intent.ACTION_SEND -> {
                if(intent.type == "text/plain") {
                    handleSentText(intent)
                } else if(intent.type?.startsWith("image/") == true) {
                    print("image")
                }
            }
        }
    }

    private fun handleSentText(intent: Intent) {
        intent.getStringExtra(Intent.EXTRA_TEXT)?.let {
            Toast.makeText(context, it, LENGTH_SHORT).show()
        }
    }
}
