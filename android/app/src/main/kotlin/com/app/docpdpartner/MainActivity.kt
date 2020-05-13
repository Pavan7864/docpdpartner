package com.app.docpdpartner

import android.os.Bundle
import android.os.Handler
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jitsi.meet.sdk.JitsiMeet
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import java.net.MalformedURLException
import java.net.URL


class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "jitisi").setMethodCallHandler { call, result -> // here is the error
            if (call.method == "configure") {
                init();
                result.success(null)
            }else if (call.method == "getPlatformVersion") {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            } else if (call.method == "startMeeting") {
                callStart(call.argument<String>("meetingId")!!)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)



    }




    fun init(){

    }


    fun callStart(meetingId:String){
        Thread {
            try {
                var serverURL = try {
                    URL("https://meeting.docopd.com")
                } catch (e: MalformedURLException) {
                    e.printStackTrace()
                    throw RuntimeException("Invalid server URL!")
                }
                val defaultOptions = JitsiMeetConferenceOptions.Builder()
                        .setServerURL(serverURL)
                        .setWelcomePageEnabled(false)
                        .build()
                JitsiMeet.setDefaultConferenceOptions(defaultOptions)

                if (meetingId.length > 0) {

                    val options: JitsiMeetConferenceOptions = JitsiMeetConferenceOptions.Builder()
                            .setRoom(meetingId)
                            .build()
                    JitsiMeetActivity.launch(this, options)
                }
            }catch(e:Exception){
                Log.d("CAll",e.toString());
            }
        }.start()
    }

}
