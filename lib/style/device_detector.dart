
import 'package:flutter/material.dart';

class DeviceDetector{
  static String deviceDetector(){
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone':'tablet';
  }
}