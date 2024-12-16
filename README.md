NetworkChecker is a Flutter widget that monitors the internet connection status and displays a customizable retry screen when no internet connection is available. It provides an easy way to ensure your app handles network outages gracefully.

# Features

* Monitors internet connection in real-time.
* Displays a default retry screen when the network is unavailable.
* Customizable retry button and retry screen UI.
* Built-in periodic connection checking.

## Installation

Add this to your package's pubspec.yaml file:

    yaml

    dependencies:
       network_checker: latest_version

Then, run:


    flutter pub get

## Usage

Wrap the NetworkChecker widget around your main app or any specific part of the widget tree you want to monitor for connectivity:

## Basic Usage

    import 'package:flutter/material.dart';
    import 'package:network_checker/network_checker.dart';

    void main() {
    runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {

    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
     return MaterialApp(
      home: NetworkChecker(
       child: Scaffold(
        appBar: AppBar(title: const Text('Network Checker Example')),
         body: const Center(child: Text('You are online!')),
           ),
         ),
        );
      }
     }


## Custom Retry Screen

For full customization, use the retryUI property to provide a custom retry screen:

    NetworkChecker(
      child: MyApp(),
      retryUI: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Connection', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => print('Retry!'),
            ),
          ],
        ),
      ),
    )

License
This project is licensed under the MIT License - see the LICENSE file for details.
Contributing
Contributions are welcome! Please feel free to submit a Pull Request.