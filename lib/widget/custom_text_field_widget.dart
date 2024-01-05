import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final Function(String) onChange;
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onPressedSuffixIcon;

  const CustomTextFieldWidget(
      {
        super.key,
        required this.onChange,
        required this.label,
        this.obscureText = false,
        this.controller,
        this.prefixIcon,
        this.suffixIcon,
        this.onPressedSuffixIcon
      });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {

  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  @override
  void initState() {
    visible.value = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder<bool>(
        valueListenable: visible,
      builder: (_, isVisible, __) {
            return TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            label: Text(widget.label),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade900, width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      visible.value = !isVisible;
                    },
                  )
                : widget.suffixIcon != null
                ? IconButton(
              icon: Icon(widget.suffixIcon),
              onPressed: widget.onPressedSuffixIcon,
            )
                : null),
        onChanged: widget.onChange,
        obscureText: isVisible,
      );
    });
  }
}
