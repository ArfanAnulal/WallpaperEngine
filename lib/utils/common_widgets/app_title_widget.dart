import 'package:flutter/material.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? defaultStyle = Theme.of(context).appBarTheme.titleTextStyle;
    final TextStyle? secondHalfStyle = defaultStyle?.copyWith(color: Color(0xFF58d2db));

    return RichText(
      text: TextSpan(
        text: 'Wallpaper',
        style: secondHalfStyle,
        children: <TextSpan>[
          TextSpan(text: 'Engine', style: defaultStyle),
        ],
      ),
    );
  }
}