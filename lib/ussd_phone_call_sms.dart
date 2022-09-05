import 'package:flutter/services.dart';

class UssdPhoneCallSms {

  final MethodChannel _androidChannel = const MethodChannel("ussd_phone_call_sms");

  phoneCall({required String phoneNumber})async {
    try {
      await _androidChannel.invokeMethod('phoneCall', <String, dynamic>{"phone_number": phoneNumber} );
    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> phoneCall method error: $e");
      print("Inside ussd_phone_call_sms -> phoneCall method stack: $s");
    }

  }

  textSMS({required String recipients, required String smsBody})async{
    try {
      await _androidChannel.invokeMethod('textSMS', <String, dynamic>{"phone_number": recipients, "sms_body": smsBody});

    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }

  }

  textMultiSMS({required List<String> recipientsList, required String smsBody})async{
    try {
      for(String recieverPhoneNumber in recipientsList){
        await _androidChannel.invokeMethod('textSMS', <String, dynamic>{"phone_number": recieverPhoneNumber, "sms_body": smsBody});
      }
    }
    catch(e, s){
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }

  }
}
