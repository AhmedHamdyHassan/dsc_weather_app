import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF202020),
        body: Container(
            child: Column(
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
            SpinKitRing(
              color: Color(0xFFC63E37),
              size: 50,
            )
          ],
        ),),);
  }
}
