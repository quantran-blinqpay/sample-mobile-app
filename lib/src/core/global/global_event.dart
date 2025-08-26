import 'dart:async';

import 'package:flutter/material.dart';

class GlobalEvent {

  GlobalEvent._privateConstructor();

  static final GlobalEvent instance = GlobalEvent._privateConstructor();

  // ignore: close_sinks
  var refreshThemeEvent = StreamController<ThemeMode>.broadcast();

}