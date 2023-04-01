import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ussd_phone_call_sms/ussd_phone_call_sms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ussdPhoneCallSmsPlugin = UssdPhoneCallSms();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> phoneCall() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      await _ussdPhoneCallSmsPlugin.phoneCall(phoneNumber: '+8801XXXXXXXXXXXX') ?? 'Unknown platform version'; // phone number
    } catch(e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: phoneCall,
            child: const Text('Phone Call'),
          ),
        ),
      ),
    );
  }
}
