import 'package:flutter/material.dart';

class FontWeightDemo extends StatelessWidget {
  const FontWeightDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildFittedText(FontWeight.w100),
        _buildFittedText(FontWeight.w200),
        _buildFittedText(FontWeight.w300),
        _buildFittedText(FontWeight.w400),
        _buildFittedText(FontWeight.w500),
        _buildFittedText(FontWeight.w600),
        _buildFittedText(FontWeight.w700),
        _buildFittedText(FontWeight.w800),
        _buildFittedText(FontWeight.w900),
      ],
    );
  }

  _buildFittedText(FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: Text(
          '焦虑时代 一方净土 Hello world',
          style: TextStyle(fontWeight: weight),
        ),
      ),
    );
  }
}
