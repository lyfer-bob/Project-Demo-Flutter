/*
 * Copyright (c) 2019-2022 Larry Aasen. All rights reserved.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:/main.dart';
import 'package:http/http.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(title: Text('Upgrader Example')),
          body: Center(child: Text('Checking...'))),
    );
  }
}
