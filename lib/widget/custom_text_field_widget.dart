import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final Function(String) onChange;
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onPressedSuffixIcon;
  final Function()? onPressedPrefixIcon;
  final int? minLines;
  final TextInputType keyboardType;
  final bool cursorEnd;

  const CustomTextFieldWidget(
      {
        super.key,
        required this.onChange,
        required this.label,
        this.obscureText = false,
        this.controller,
        this.prefixIcon,
        this.suffixIcon,
        this.onPressedSuffixIcon,
        this.onPressedPrefixIcon,
        this.minLines,
        this.keyboardType = TextInputType.text,
        this.cursorEnd = false
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

    if(widget.cursorEnd) {
      widget.controller?.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller?.text.length??0));
    }
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
            prefixIcon: IconButton(
                icon: Icon(widget.prefixIcon, color: Colors.grey.shade900),
                onPressed: widget.onPressedPrefixIcon
            ),
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
            ) : null),
            onChanged: widget.onChange,
            obscureText: isVisible,
            minLines: widget.minLines,
            maxLines: null,
            keyboardType: widget.keyboardType,
      );
    });
  }
}
