package com.example.ussd_phone_call_sms;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.telephony.SmsManager;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** UssdPhoneCallSmsPlugin */
public class UssdPhoneCallSmsPlugin implements FlutterPlugin, MethodCallHandler  {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  String TAG = "ussd_phone_call_sms";

  private Context context;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ussd_phone_call_sms");
    channel.setMethodCallHandler(this);
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("phoneCall")) {
      try {
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
          // here to request the missing permissions, and then overriding
          //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
          //                                          int[] grantResults)
          // to handle the case where the user grants the permission. See the documentation
          // for ActivityCompat#requestPermissions for more details.

          Log.d(TAG, "onMethodCall: Permission not given. Try giving Phone Call permission");
          result.success("Failed");
        }
        else {
          Intent callIntent = new Intent(Intent.ACTION_CALL);
          callIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
          String number = call.argument("phone_number");

          if(number != null && number.charAt(0) == '*' && number.charAt(number.length() -1) == '#'){
            number = number.substring(0, number.length() -1) + Uri.encode("#");
          }

          callIntent.setData(Uri.parse("tel:" +number));

          context.startActivity(callIntent);

          result.success("Success");

        }


      }
      catch (Exception e){
        Log.d(TAG, "onMethodCall Phone Call: "+e.getMessage());
        result.success("Failed ");
      }

    }
    else if(call.method.equals("textSMS")){
      try {

        String number = call.argument("phone_number");
        String smsBody = call.argument("sms_body");
        SmsManager smsManager = SmsManager.getDefault();
        smsManager.sendTextMessage(number, null, smsBody, null, null);
        result.success("Success ");
      }
      catch (Exception e){
        Log.d(TAG, "onMethodCall Text SMS: "+e.getMessage());
        result.success("Failed ");
      }

    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

}
