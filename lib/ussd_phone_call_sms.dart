import'dart:io' show Platform;
import 'package:flutter/services.dart';

class UssdPhoneCallSms {

  final MethodChannel _androidChannel = const MethodChannel("ussd_phone_call_sms");

  phoneCall({required String phoneNumber})async {
    try {
      if(Platform.isAndroid){
        await _androidChannel.invokeMethod('phoneCall', <String, dynamic>{"phone_number": phoneNumber} );
      }
    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> phoneCall method error: $e");
      print("Inside ussd_phone_call_sms -> phoneCall method stack: $s");
    }

  }

  textSMS({required String recieverPhoneNumber, required String smsBody})async{
    try {
      if(Platform.isAndroid){
        await _androidChannel.invokeMethod('textSMS', <String, dynamic>{"phone_number": recieverPhoneNumber, "sms_body": smsBody});
      }

    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }

  }

  textMultiSMS({required List<String> recieverPhoneNumberList, required String smsBody})async{
    try {
      if(Platform.isAndroid){
        for(String recieverPhoneNumber in recieverPhoneNumberList){
          await _androidChannel.invokeMethod('textSMS', <String, dynamic>{"phone_number": recieverPhoneNumber, "sms_body": smsBody});
        }
      }
    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }

  }
}
