import 'package:flutter/material.dart';

class CCSwitch extends StatefulWidget {
  const CCSwitch({required this.onChanged, required this.selected, Key? key})
      : super(key: key);

  final Function onChanged;

  final bool selected;

  @override
  State<CCSwitch> createState() => _CCSwitchState();
}

class _CCSwitchState extends State<CCSwitch> {
  late bool _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _selected,
      onChanged: (bool value) {
        setState(() {
          _selected = value;
        });
        widget.onChanged(value);
      },
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
