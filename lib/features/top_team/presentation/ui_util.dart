import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalMargin extends StatelessWidget {
  const VerticalMargin(this.height, {Key? key}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HorizontalMargin extends StatelessWidget {
  const HorizontalMargin(this.width, {Key? key}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

double screenWidth(BuildContext context, {double percent = 100.0}) =>
    MediaQuery.of(context).size.width * (percent / 100.0);
double screenHeight(BuildContext context, {double percent = 100.0}) =>
    MediaQuery.of(context).size.height * (percent / 100.0);
