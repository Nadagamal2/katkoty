package com.katkoty.app

import android.app.AlarmManager
import android.app.PendingIntent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import kotlin.system.exitProcess


import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class MainActivity : FlutterActivity() {
    private val TAG = "MainActivity"
    private val CHANNEL = "restart_app"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.d(TAG, "configureFlutterEngine: restart called")
            exitProcess(0)
            result.success("ok")
        }
    }
}
