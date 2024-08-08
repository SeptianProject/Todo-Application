import 'package:flutter/material.dart';

class QRadioButton extends StatefulWidget {
  final List<dynamic> items;
  final void Function(String?)? onChanged;
  final String? label;
  final String? Function(String?)? validator;
  const QRadioButton({
    super.key,
    this.label,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  State<QRadioButton> createState() => _QRadioButtonState();
}

class _QRadioButtonState extends State<QRadioButton> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.items[0]["value"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      List items = widget.items;
      return FormField<String>(
        validator: widget.validator,
        builder: (FormFieldState<String> field) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              errorText: field.errorText,
              border: InputBorder.none,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return RadioListTile<String>(
                    title: Text(item["label"]!),
                    value: item["value"],
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    });
              },
            ),
          );
        },
      );
    });
  }
}
