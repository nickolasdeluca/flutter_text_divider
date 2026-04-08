import 'package:flutter/material.dart';

/// A widget that displays a [text] label centred between two dividing lines.
///
/// Supports both [Axis.horizontal] (default) and [Axis.vertical] orientations.
/// Line colour and thickness fall back to [DividerThemeData] / [ThemeData];
/// text style falls back to [TextTheme.bodyMedium].
///
/// #### Horizontal (default)
/// ```dart
/// const TextDivider(text: 'or')
/// ```
///
/// #### Vertical
/// The widget must be inside a parent that provides a bounded height.
/// ```dart
/// SizedBox(
///   height: 200,
///   child: TextDivider(text: 'or', axis: Axis.vertical),
/// )
/// ```
class TextDivider extends StatelessWidget {
  /// Creates a [TextDivider] widget.
  const TextDivider({
    super.key,
    required this.text,
    this.axis = .horizontal,
    this.textStyle,
    this.color,
    this.thickness = 1.0,
    this.gap = 8.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.height = 16.0,
    this.width = 16.0,
    this.fallbackLineLength = 40.0,
  }) : assert(thickness > 0, 'thickness must be greater than 0'),
       assert(gap >= 0, 'gap must be non-negative'),
       assert(indent >= 0, 'indent must be non-negative'),
       assert(endIndent >= 0, 'endIndent must be non-negative'),
       assert(height == null || height >= 0, 'height must be non-negative'),
       assert(width == null || width >= 0, 'width must be non-negative'),
       assert(
         fallbackLineLength > 0,
         'fallbackLineLength must be greater than 0',
       );

  /// The label displayed in the centre of the divider.
  final String text;

  /// The axis along which the divider lines are drawn.
  ///
  /// Defaults to [Axis.horizontal].
  ///
  /// When set to [Axis.vertical] the widget must be placed inside a parent
  /// that provides a bounded height (e.g. [SizedBox] or [Expanded]).
  final Axis axis;

  /// Style applied to [text].
  ///
  /// Defaults to [TextTheme.bodyMedium] from the ambient [Theme].
  final TextStyle? textStyle;

  /// Colour of the dividing lines.
  ///
  /// Defaults to [DividerThemeData.color], then [ThemeData.dividerColor].
  final Color? color;

  /// Thickness of the dividing lines in logical pixels.
  ///
  /// Must be greater than `0`. Defaults to `1.0`.
  final double thickness;

  /// Space between [text] and each dividing line, in logical pixels.
  ///
  /// Defaults to `8.0`.
  final double gap;

  /// Empty space at the leading edge of the divider.
  ///
  /// For [Axis.horizontal] this is the left indent; for [Axis.vertical] it
  /// is the top indent. Defaults to `0.0`.
  final double indent;

  /// Empty space at the trailing edge of the divider.
  ///
  /// For [Axis.horizontal] this is the right indent; for [Axis.vertical] it
  /// is the bottom indent. Defaults to `0.0`.
  final double endIndent;

  /// The total vertical extent of a horizontal divider.
  ///
  /// When [axis] is [Axis.horizontal] and this is non-null, the widget is
  /// wrapped in a [SizedBox] with the given [height] and the content is
  /// vertically centred, mirroring [Divider.height].
  ///
  /// Has no effect when [axis] is [Axis.vertical].
  ///
  /// Must be greater than `0` when non-null. Defaults to `16.0`.
  final double? height;

  /// The total horizontal extent of a vertical divider.
  ///
  /// When [axis] is [Axis.vertical] and this is non-null, the widget is
  /// wrapped in a [SizedBox] with the given [width] and the content is
  /// horizontally centred, mirroring [VerticalDivider.width].
  ///
  /// Has no effect when [axis] is [Axis.horizontal].
  ///
  /// Must be greater than `0` when non-null. Defaults to `16.0`.
  final double? width;

  /// The fixed line length used when the divider is placed inside a parent
  /// with unbounded constraints (e.g. a [ListView] or preview host).
  ///
  /// Only applies when the widget cannot expand to fill available space.
  /// Must be greater than `0`. Defaults to `40.0`.
  final double fallbackLineLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerTheme = DividerTheme.of(context);

    final effectiveColor = color ?? dividerTheme.color ?? theme.dividerColor;
    final effectiveTextStyle =
        textStyle ?? theme.textTheme.bodyMedium ?? const TextStyle();

    switch (axis) {
      case .horizontal:
        return SizedBox(
          height: height,
          child: _HorizontalTextDivider(
            text: text,
            textStyle: effectiveTextStyle,
            color: effectiveColor,
            thickness: thickness,
            gap: gap,
            indent: indent,
            endIndent: endIndent,
            fallbackLineLength: fallbackLineLength,
          ),
        );
      case .vertical:
        return SizedBox(
          width: width,
          child: _VerticalTextDivider(
            text: text,
            textStyle: effectiveTextStyle,
            color: effectiveColor,
            thickness: thickness,
            gap: gap,
            indent: indent,
            endIndent: endIndent,
            fallbackLineLength: fallbackLineLength,
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

class _HorizontalTextDivider extends StatelessWidget {
  const _HorizontalTextDivider({
    required this.text,
    required this.textStyle,
    required this.color,
    required this.thickness,
    required this.gap,
    required this.indent,
    required this.endIndent,
    required this.fallbackLineLength,
  });

  final String text;
  final TextStyle textStyle;
  final Color color;
  final double thickness;
  final double gap;
  final double indent;
  final double endIndent;
  final double fallbackLineLength;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bounded = constraints.maxWidth != double.infinity;

        Widget line({double? lineIndent, double? lineEndIndent}) {
          final divider = Divider(
            color: color,
            thickness: thickness,
            indent: lineIndent,
            endIndent: lineEndIndent,
          );
          return bounded
              ? Expanded(child: divider)
              : SizedBox(width: fallbackLineLength, child: divider);
        }

        return Row(
          mainAxisSize: bounded ? .max : .min,
          children: [
            line(lineIndent: indent),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gap),
              child: Text(text, style: textStyle),
            ),
            line(lineEndIndent: endIndent),
          ],
        );
      },
    );
  }
}

class _VerticalTextDivider extends StatelessWidget {
  const _VerticalTextDivider({
    required this.text,
    required this.textStyle,
    required this.color,
    required this.thickness,
    required this.gap,
    required this.indent,
    required this.endIndent,
    required this.fallbackLineLength,
  });

  final String text;
  final TextStyle textStyle;
  final Color color;
  final double thickness;
  final double gap;
  final double indent;
  final double endIndent;
  final double fallbackLineLength;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bounded = constraints.maxHeight != double.infinity;

        Widget line({double? lineIndent, double? lineEndIndent}) {
          final divider = VerticalDivider(
            color: color,
            thickness: thickness,
            indent: lineIndent,
            endIndent: lineEndIndent,
          );
          return bounded
              ? Expanded(child: divider)
              : SizedBox(height: fallbackLineLength, child: divider);
        }

        return Column(
          mainAxisSize: bounded ? .max : .min,
          children: [
            line(lineIndent: indent),
            Padding(
              padding: EdgeInsets.symmetric(vertical: gap),
              child: Text(text, style: textStyle, textAlign: .center),
            ),
            line(lineEndIndent: endIndent),
          ],
        );
      },
    );
  }
}
