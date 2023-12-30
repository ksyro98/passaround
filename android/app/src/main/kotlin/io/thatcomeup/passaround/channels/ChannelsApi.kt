package io.thatcomeup.passaround.channels

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

interface ChannelApi {
    fun getChanelName(): String

    fun configureChannel(flutterEngine: FlutterEngine)
}
