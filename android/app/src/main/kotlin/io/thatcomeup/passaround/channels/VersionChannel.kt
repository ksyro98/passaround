package io.thatcomeup.passaround.channels

import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class VersionChannel : ChannelApi {
    companion object {
        private const val VERSION_CHANNEL = "io.thatcomeup.passaround/version"
    }

    override fun getChanelName(): String {
        return VERSION_CHANNEL
    }

    override fun configureChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, getChanelName())
            .setMethodCallHandler { call, result ->
                if(call.method == "getVersion") {
                    handleGetVersion(result)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun handleGetVersion(result: MethodChannel.Result) {
        try {
            val version = getVersion()
            result.success(version)
        } catch (e: Exception) {
            result.error("CHANNEL_ERROR", "An error occurred on the Android side of native platform communication through channels.", e)
        }
    }

    private fun getVersion(): HashMap<String, String> {
        return hashMapOf(
            Pair("platform", "Android"),
            Pair("version", Build.VERSION.SDK_INT.toString())
        )
    }
}