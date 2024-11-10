package com.example.chat_app101

import android.app.PictureInPictureParams
import android.content.res.Configuration
import android.os.Build
import android.os.Bundle
import android.util.Rational
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Your existing initialization code, if any
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onUserLeaveHint() {
        super.onUserLeaveHint()
        enterPictureInPictureMode(getPipParams())
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun getPipParams(): PictureInPictureParams {
        val aspectRatio = Rational(16, 9) // Adjust as needed
        return PictureInPictureParams.Builder()
            .setAspectRatio(aspectRatio)
            .build()
    }

    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration?
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        if (isInPictureInPictureMode) {
            // Hide UI elements that are not needed in PiP mode
        } else {
            // Restore UI elements when exiting PiP mode
        }
    }
}
