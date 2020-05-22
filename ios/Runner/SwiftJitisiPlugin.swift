import Flutter;
import UIKit
import JitsiMeet

public class SwiftJitisiPlugin: NSObject, FlutterPlugin, JitsiMeetViewDelegate {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "jitisi", binaryMessenger: registrar.messenger())
    let instance = SwiftJitisiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
    
                if (call.method == "configure") {

                }else if (call.method == "getPlatformVersion") {
                    //result.success("Android ${android.os.Build.VERSION.RELEASE}")
                    
                } else if (call.method == "startMeeting") {
                    if let args = call.arguments as? Dictionary<String,String>{
                        let met = (args["meetingId"])!
                        startMeeting(meeting: met)
                    }
                    
                } else {
                    //result.notImplemented()
                }


  }

    
    func startMeeting(meeting:String) {
    
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
             let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                 builder.welcomePageEnabled = false
                 builder.room = meeting
             }
                     
             // setup view controller
             let vc = UIViewController()
             vc.modalPresentationStyle = .fullScreen
             vc.view = jitsiMeetView
             
             // join room and display jitsi-call
             jitsiMeetView.join(options)
         vc.present(vc, animated: true, completion: nil)
             
    }

}
