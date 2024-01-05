import 'package:flutter/material.dart';

class AutocompleteTextFieldWidget extends StatefulWidget {
  final Function(String) onChange;
  final String label;
  final String textInit;
  final TextEditingController? controller;
  final List<String> options;
  final IconData? prefixIcon;

  const AutocompleteTextFieldWidget({
    super.key,
    required this.onChange,
    required this.label,
    this.textInit = "",
    this.controller,
    required this.options,
    this.prefixIcon
  });

  @override
  State<AutocompleteTextFieldWidget> createState() => _AutocompleteTextFieldWidgetState();
}

class _AutocompleteTextFieldWidgetState extends State<AutocompleteTextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            widget.onChange(textEditingValue.text);
            if (textEditingValue.text == '') {
              return widget.options;
            }
            return widget.options.where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: widget.onChange,
          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
            textEditingController.text = widget.textInit;
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.prefixIcon),
                border: OutlineInputBorder(),
                labelText: widget.label,
              ),
            );
          },
        ),
      ],
    );
  }
}
