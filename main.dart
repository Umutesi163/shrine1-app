// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
// ignore: unused_import
import 'app.dart'; // Make sure this file exists and contains your app's structure

void main() {
  runApp(const ShrineApp());
}

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine App',  // This is the title of your app
      theme: ThemeData(
        primarySwatch: Colors.blue,  // You can change the primary color theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ShrineHomePage(), // Default screen when app starts
    );
  }
}

class ShrineHomePage extends StatelessWidget {
  const ShrineHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shrine App Home'),
      ),
      body: const Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SomeWidget(),  // This widget can be replaced with your content
            ),
          ),
          // Other widgets go here
        ],
      ),
    );
  }
}

class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Welcome to the Shrine App!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
