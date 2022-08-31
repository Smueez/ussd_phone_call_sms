#import "UssdPhoneCallSmsPlugin.h"
#if __has_include(<ussd_phone_call_sms/ussd_phone_call_sms-Swift.h>)
#import <ussd_phone_call_sms/ussd_phone_call_sms-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ussd_phone_call_sms-Swift.h"
#endif

@implementation UssdPhoneCallSmsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUssdPhoneCallSmsPlugin registerWithRegistrar:registrar];
}
@end
