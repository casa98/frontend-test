package com.casa98.frontendtest.fontend_test

import android.os.Bundle
import android.graphics.Color
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.statusBarColor = Color.TRANSPARENT;
    }
}