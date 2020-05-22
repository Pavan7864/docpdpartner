 import UIKit
import Flutter
import JitsiMeet

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let registrar = self.window.rootViewController as! FlutterViewController;
    let channel = FlutterMethodChannel(name: "jitisi", binaryMessenger: registrar.binaryMessenger)
      channel.setMethodCallHandler({
         [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        
        if (call.method == "configure") {
                print("Config Sccuess...")
          }else if (call.method == "getPlatformVersion") {
              //result.success("Android ${android.os.Build.VERSION.RELEASE}")
              
          } else if (call.method == "startMeeting") {
              if let args = call.arguments as? Dictionary<String,String>{
                let meeting = args["meetingId"]! as String
                print("MeetingId"+meeting)
                 print("Start Meeting Sccuess...")
                print(meeting)
                
                let jitsiMeetView = JitsiMeetView()
                     let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                         builder.welcomePageEnabled = false
                         builder.room = meeting
                        builder.serverURL = URL.init(string: "https://meeting.docopd.com")
                     }
                             
//                let storybard = UIStoryboard(name: "Main", bundle: nil)
                let vc = UIViewController()
                     vc.modalPresentationStyle = .fullScreen
                     vc.view = jitsiMeetView
                     
                     // join room and display jitsi-call
                     jitsiMeetView.join(options)
                self?.window.rootViewController = vc
                self?.window.makeKeyAndVisible()
              }
              
          } else {
              //result.notImplemented()
          }
    
       })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    

    

}
