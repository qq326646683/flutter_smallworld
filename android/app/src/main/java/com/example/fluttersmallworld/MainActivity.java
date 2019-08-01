package com.example.fluttersmallworld;

import android.os.Bundle;
import android.view.WindowManager;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
//    if(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.HONEYCOMB) {
//      getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
//
//
//    } else {
//      getWindow().clearFlags(WindowManager.LayoutParams.FLAG_SECURE);
//    }
    GeneratedPluginRegistrant.registerWith(this);
  }
}
