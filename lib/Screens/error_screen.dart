import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  ErrorScreen(this.errorMessage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF202020),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Image.asset(
                  'assets/images/Icon.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(
                Icons.error,
                color: Colors.orange,
              ),
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Color(0xFFC63E37)),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
