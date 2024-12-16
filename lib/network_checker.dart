library network_checker;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker extends StatefulWidget {
  final Widget child;
  final Widget? retryButton;
  final VoidCallback? onRetry;
  final Widget? retryUI;

  /// [retryUI] allows users to define their own UI for the retry screen.
  /// If null, a default retry screen with a message and button is shown.
  const NetworkChecker({
    super.key,
    required this.child,
    this.retryButton,
    this.onRetry,
    this.retryUI,
  });

  @override
  State<NetworkChecker> createState() => _NetworkCheckerState();
}

class _NetworkCheckerState extends State<NetworkChecker> {
  bool _isConnected = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startConnectionCheck();
  }

  void _startConnectionCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final isConnected = await InternetConnection().hasInternetAccess;
      if (isConnected != _isConnected) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return widget.child;
    } else {
      return widget.retryUI ??
          Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  widget.retryButton ??
                      ElevatedButton(
                        onPressed: () async {
                          final isConnected =
                              await InternetConnection().hasInternetAccess;
                          if (isConnected) {
                            setState(() {
                              _isConnected = true;
                            });
                            if (widget.onRetry != null) {
                              widget.onRetry!();
                            }
                          }
                        },
                        child: const Text('Retry'),
                      ),
                ],
              ),
            ),
          );
    }
  }
}
