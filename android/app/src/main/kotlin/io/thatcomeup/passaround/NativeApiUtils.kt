package io.thatcomeup.passaround

import android.os.Build

class NativeApiUtils {
    fun getVersion(): HashMap<String, String> {
        return hashMapOf(
            Pair("platform", "Android"),
            Pair("version", Build.VERSION.SDK_INT.toString())
        )
    }
}