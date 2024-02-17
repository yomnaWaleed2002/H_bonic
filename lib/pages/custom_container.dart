import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    var startPoint = Offset(size.width * 0.5, 130);
    var endPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
        startPoint.dx, startPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
