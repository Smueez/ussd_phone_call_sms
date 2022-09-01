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

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** UssdPhoneCallSmsPlugin */
public class UssdPhoneCallSmsPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware  {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  String TAG = "ussd_phone_call_sms";
  private Activity activity;
  private Context context;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ussd_phone_call_sms");
    channel.setMethodCallHandler(this);
  }

//  @RequiresApi(api = Build.VERSION_CODES.M)

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
//          context.requestPermissions(new String[]{Manifest.permission.CALL_PHONE}, 1)
//          ;
          Log.d(TAG, "onMethodCall: decline");
        }
        else {
          Log.d(TAG, "onMethodCall: accepted");
        }

        Intent callIntent = new Intent(Intent.ACTION_CALL);
        callIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        String number = call.argument("phone_number");
        Log.d(TAG, "onMethodCall: number "+number);
        if(number != null && number.charAt(0) == '*' && number.charAt(number.length() -1) == '#'){
          number = number.substring(0, number.length() -1) + Uri.encode("#");
        }
        Log.d(TAG, "onMethodCall: 0");
        callIntent.setData(Uri.parse("tel:" +number));
        Log.d(TAG, "onMethodCall: 4");
//        activity.startActivity(callIntent);
        context.startActivity(callIntent);
//        startActivity(callIntent);
        Log.d(TAG, "onMethodCall: 2");
        result.success("Success ");
      }
      catch (Exception e){
        Log.d(TAG, "onMethodCall Phone Call: "+e.getMessage());
        result.success("Failed ");
      }

    }
    else if(call.method.equals("textSMS")){
      try {
//        if (ContextCompat.checkSelfPermission(getApplicationContext(),
//                Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED) {
//          requestPermissions(new String[]{Manifest.permission.SEND_SMS}, 1);
//        }
//        else {
//
//        }
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

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {

  }
}
