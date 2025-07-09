/* import 'dart:async';
import 'package:flutter/material.dart';

class TiemRSetting {
void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (startTimerC < 1) {
            timer.cancel();
          } else {
            
            startTimerC = startTimerC - 1;  
            
            
          }
        },
      ),
    );
  }

}
Timer timer;
int startTimerC = 30; */