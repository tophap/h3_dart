import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h3_ffi/h3_ffi.dart';

void main() {
  initializeH3(Platform.isIOS ? (String name) => DynamicLibrary.process() : null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('0x${geoToH3(
          GeoCoord.degrees(
            lat: 40.68942184369929,
            lon: -74.04443139990863,
          ),
          10,
        ).toRadixString(16).toUpperCase()}'),
      ),
    );
  }
}
