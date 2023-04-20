package com.example.yandex_mapexample
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("uz_Cyrl_UZ");
        MapKitFactory.setApiKey("1634dca9-bc30-4b33-a13c-cf7b8d9e9865")
        super.configureFlutterEngine(flutterEngine)
    }
}
