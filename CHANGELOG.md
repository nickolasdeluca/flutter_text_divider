# Changelog

## 0.1.2

* Added missing documentation for TextDivider constructor.

## 0.1.1

* Added `height` parameter for horizontal dividers, mirroring `Divider.height`.
* Added `width` parameter for vertical dividers, mirroring `VerticalDivider.width`.
* Added `fallbackLineLength` parameter for controlling line length inside
  unbounded constraints.
* Horizontal divider now correctly fills parent width instead of using a
  fixed line length.

## 0.1.0

* Initial release.
* `TextDivider` widget: displays a text label centred between two dividing
  lines.
* Supports both `Axis.horizontal` (default) and `Axis.vertical` orientations.
* Integrates with Flutter's `ThemeData` and `DividerThemeData` for default
  colours and text styles.
* Configurable `text`, `textStyle`, `color`, `thickness`, `gap`, `indent`,
  and `endIndent` parameters.
