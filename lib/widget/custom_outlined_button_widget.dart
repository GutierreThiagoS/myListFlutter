
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final IconData? iconData;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                  text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(iconData)
            ],
          ),
        )
    );
  }
}
