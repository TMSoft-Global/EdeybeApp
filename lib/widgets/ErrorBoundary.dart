import 'package:flutter/material.dart';

class ErrorBoundary extends StatelessWidget {
  final bool serverError;
  final bool canceled;
  final bool connectionError;
  final VoidCallback onRetry;
  final Widget child;

  const ErrorBoundary(
      {Key key,
      @required this.child,
      @required this.connectionError,
      @required this.canceled,
      @required this.serverError,
      @required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return connectionError || serverError || canceled
        ? Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (connectionError)
                    Column(
                      children: [
                        Image.asset('assets/images/internet_connection.png'),
                        Text('Please check your internet connection')
                      ],
                    ),
                  if (serverError || canceled)
                    Image.asset('assets/images/unknown_error.png'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: onRetry, child: Text('Retry')),
                  )
                ],
              ),
            ),
          )
        : child;
  }
}
