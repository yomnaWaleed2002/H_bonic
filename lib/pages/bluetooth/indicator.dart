import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  final double? percent;
  final Color? color;
  final String? _message;
  const PercentIndicator.connecting({super.key})
      : percent = null,
        _message = 'Connecting...',
        color = const Color(0xFF459ED1);
  const PercentIndicator.disconnected({super.key})
      : percent = 1.0,
        _message = 'Disconnected',
        color = Colors.purple;
  const PercentIndicator.error({super.key})
      : percent = 1.0,
        _message = 'Error',
        color = Colors.red;
  const PercentIndicator.connect({super.key})
      : percent = 1.0,
        _message = 'connect',
        color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 210,
          width: 210,
          child: CircularProgressIndicator(
            value: percent,
            color: color,
          ),
        ),
        SizedBox(
          height: 210,
          width: 210,
          child: Center(
            child: Text(
              _message != null
                  ? _message!
                  : '${((percent ?? 0) * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
