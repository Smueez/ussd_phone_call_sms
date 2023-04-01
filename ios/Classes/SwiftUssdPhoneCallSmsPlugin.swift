import Flutter
import UIKit
import MessageUI
public class SwiftUssdPhoneCallSmsPlugin: NSObject, FlutterPlugin, MFMessageComposeViewControllerDelegate {
   var result: FlutterResult?
   var _arguments = [String: Any]()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ussd_phone_call_sms", binaryMessenger: registrar.messenger())
    let instance = SwiftUssdPhoneCallSmsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if(call.method == "phoneCall") {
           if let arguments = call.arguments as? [String: Any],
              let phoneNumber = arguments["phone_number"] as? String,
              let url = URL(string: "tel:" + phoneNumber),
              UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)

                } else {
                    UIApplication.shared.openURL(url)
                }
                
            } else {
               result(FlutterError(
                        code: "can_not_call",
                        message: "Cannot make a call on this device!",
                        details: "Cannot make a call on this device!"
                     )
               )
            }
       }

   else if (call.method == "textSMS") {
         _arguments = call.arguments as! [String : Any];
              #if targetEnvironment(simulator)
                result(FlutterError(
                    code: "message_not_sent",
                    message: "Cannot send message on this device!",
                    details: "Cannot send SMS and MMS on a Simulator. Test on a real device."
                  )
                )
              #else
                if (MFMessageComposeViewController.canSendText()) {
                  self.result = result
                  let controller = MFMessageComposeViewController()
                  controller.body = _arguments["sms_body"] as? String
                  controller.subject = "Test Message"
                  controller.recipients = _arguments["phone_number"] as? [String]
                  controller.messageComposeDelegate = self
                  UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                } else {
                  result(FlutterError(
                      code: "device_not_capable",
                      message: "The current device is not capable of sending text messages.",
                      details: "A device may be unable to send messages if it does not support messaging or if it is not currently configured to send messages. This only applies to the ability to send text messages via iMessage, SMS, and MMS."
                    )
                  )
                }
              #endif
    }

  }
  public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
      let map: [MessageComposeResult: String] = [
          MessageComposeResult.sent: "sent",
          MessageComposeResult.cancelled: "cancelled",
          MessageComposeResult.failed: "failed",
      ]
      if let callback = self.result {
          callback(map[result])
      }
      UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
