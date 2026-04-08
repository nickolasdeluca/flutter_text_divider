import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_text_divider/flutter_text_divider.dart';

@Preview(name: 'Horizontal Divider Preview')
Widget horizontalDividerPreview() {
  return TextDivider(
    axis: Axis.horizontal,
    text: ' or',
    color: Colors.white,
    thickness: 2.0,
    gap: 12,
    indent: 16,
    endIndent: 16,
  );
}

@Preview(name: 'Vertical Divider Preview')
Widget verticalDividerPreview() {
  return TextDivider(
    axis: Axis.vertical,
    text: 'or',
    color: Colors.white,
    thickness: 2.0,
    gap: 12,
    indent: 16,
    endIndent: 16,
    width: 50,
  );
}
