### Features

- Support Android, IOS.
- By using this plugin you can perform a phone call, USSD call or send text sms directly from your app.


### Getting started

####  Install
add this in your pubspec.yaml
`ussd_phone_call_sms: ^leatest_version`

#### How to use it
- TO make phone call or USSD request

```
     // check phone call permisison
     await UssdPhoneCallSms().phoneCall(phoneNumber: '+8801xxxxxxxxx');
     await UssdPhoneCallSms().phoneCall(phoneNumber: '*121#');
     
```


- TO text SMS

```
     // check text sms permisison
     await UssdPhoneCallSms().textMultiSMS(recipients: '+8801xxxxxxxxxx', smsBody: 'Hello World!');
     await UssdPhoneCallSms().textMultiSMS(recipientsList: ['+8801xxxxxxxxxx', '+8801xxxxxxxxxx'], smsBody: 'Hello group!'); // to send a group sms
     
```

### End