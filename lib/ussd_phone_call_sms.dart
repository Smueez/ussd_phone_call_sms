import 'package:flutter/services.dart';

class UssdPhoneCallSms {
  ///  calling the method channel from dart file.
  ///  the same exact name is used in android and in IOS version
  final MethodChannel _androidChannel =
      const MethodChannel("ussd_phone_call_sms");

  /// calling a function phoneCall
  /// for both IOS and android this function has been invoked
  /// only one parameter is phone number. this is the number where
  phoneCall({required String phoneNumber}) async {
    try {
      await _androidChannel.invokeMethod(
          'phoneCall', <String, dynamic>{"phone_number": phoneNumber});
    } catch (e, s) {
      print("Inside ussd_phone_call_sms -> phoneCall method error: $e");
      print("Inside ussd_phone_call_sms -> phoneCall method stack: $s");
    }
  }

  /// calling a function textSMS
  /// for both IOS and android this function has been invoked
  /// thee are now 2 parameters, phone number(recipients) and sms body
  /// recipients is the phone number where you will send the sms
  /// sms body is the text body of the sms
  textSMS({required String recipients, required String smsBody}) async {
    try {
      await _androidChannel.invokeMethod('textSMS',
          <String, dynamic>{"phone_number": recipients, "sms_body": smsBody});
    } catch (e, s) {
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }
  }

  /// calling a function textSMS
  /// for both IOS and android this function has been invoked
  /// thee are now 2 parameters, list of phone number(recipients) and sms body
  /// recipients is the list of phone numbers where you will send the sms
  /// sms body is the text body of the sms
  textMultiSMS(
      {required List<String> recipientsList, required String smsBody}) async {
    try {
      for (String recieverPhoneNumber in recipientsList) {
        await _androidChannel.invokeMethod('textSMS', <String, dynamic>{
          "phone_number": recieverPhoneNumber,
          "sms_body": smsBody
        });
      }
    } catch (e, s) {
      print("Inside ussd_phone_call_sms -> textSMS method error: $e");
      print("Inside ussd_phone_call_sms -> textSMS method stack: $s");
    }
  }
}
