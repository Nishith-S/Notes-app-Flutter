import 'package:flutter/cupertino.dart';

class MyCheckBox extends StatefulWidget {
  bool? value;
  void Function(bool?)? onChanged;

  MyCheckBox({
    super.key,
    this.value,
    this.onChanged,
  });

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CupertinoCheckbox(value: widget.value, onChanged: widget.onChanged);
  }
}
