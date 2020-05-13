import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Jitisi {

  factory Jitisi() => _instance;
  @visibleForTesting
  Jitisi.private(MethodChannel channel) : _channel = channel;

  static final Jitisi _instance = Jitisi.private(
      const MethodChannel('jitisi'));

  final MethodChannel _channel;


  void configure(){
    _channel.invokeMethod<void>('configure');
  }


  void startMeeting(String meetingId){
    _channel.invokeMethod(
        'startMeeting',{"meetingId":meetingId}
    );
  }
}
