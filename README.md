### Features

- Support Android, IOS.
- By using this plugin you can perform a phone call, USSD call or send text sms directly from your app.


### Getting started

####  Install
add this in your pubspec.yaml
`ussd_phone_call_sms: ^leatest_version`

#### How to use it
- TO make phone call or USSD request
** check phone call permission **
```
     // to make phone call
     await UssdPhoneCallSms().phoneCall(phoneNumber: '+8801xxxxxxxxx');
     
     // to make USSD call
     await UssdPhoneCallSms().phoneCall(phoneNumber: '*121#');
     
```


- TO text SMS
** check text sms permission **
```
     // to send a single SMS
     await UssdPhoneCallSms().textMultiSMS(recipients: '+8801xxxxxxxxxx', smsBody: 'Hello World!');
     
     // to send a group SMS
     await UssdPhoneCallSms().textMultiSMS(recipientsList: ['+8801xxxxxxxxxx', '+8801xxxxxxxxxx'], smsBody: 'Hello group!');
     
```

### End