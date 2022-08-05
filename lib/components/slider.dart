import 'package:flutter/material.dart';

class CCSlider extends StatefulWidget {
  const CCSlider({Key? key}) : super(key: key);

  @override
  State<CCSlider> createState() => _CCSliderState();
}

class _CCSliderState extends State<CCSlider> {
  double _weightValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: Transform(
        alignment: FractionalOffset.center,
        // Rotate sliders by 90 degrees
        transform: Matrix4.identity()..rotateZ(-90 * 3.1415927 / 180),
        child: SizedBox(
          width: 225,
          child: Slider(
            min: 0,
            max: 1,
            value: _weightValue,
            onChanged: (double value) {
              setState(() {
                _weightValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}