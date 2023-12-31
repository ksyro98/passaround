package io.thatcomeup.passaround.channels

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class ShareChannel : ChannelApi {
    companion object {
        private const val SHARE_CHANNEL = "io.thatcomeup.passaround/share"
    }

    private var methodChannel: MethodChannel? = null

    override fun getChanelName(): String {
        return SHARE_CHANNEL
    }

    override fun configureChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, getChanelName())
    }

    fun sendText(text: String) {
        if(methodChannel != null) {
            methodChannel?.invokeMethod("onTextShared", text)
        }
    }

    fun sendImage(image: ByteArray) {
       if(methodChannel != null) {
           methodChannel?.invokeMethod("onImageShared", image)
       }
    }
}