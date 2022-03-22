package com.example.great_places_app

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("RU_ru")
    MapKitFactory.setApiKey("e31a0a89-50dc-4d57-b2e5-76d43cb51133")
    super.configureFlutterEngine(flutterEngine)
  }

}
