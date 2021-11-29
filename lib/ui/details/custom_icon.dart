import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String value;
  final IconData icon;
  final Color color;

  const CustomIcon(
      {Key key,
      @required this.value,
      @required this.icon,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 5),
        Text(value),
      ],
    );
  }
}
