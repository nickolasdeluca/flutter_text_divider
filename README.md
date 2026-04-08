# text_divider

A Flutter package providing a `TextDivider` widget that displays a text label centred between two lines.

Supports both **horizontal** and **vertical** orientations and integrates with Flutter's `ThemeData` / `DividerThemeData` out of the box.

---

## Features

- Horizontal and vertical orientations via `axis: Axis.horizontal / Axis.vertical`
- Inherits line colour and thickness from `DividerThemeData` / `ThemeData`
- Inherits text style from `TextTheme.bodyMedium`
- Configurable gap, indent, endIndent, and custom colours / styles

---

## Usage

### Horizontal (default)

```dart
import 'package:text_divider/text_divider.dart';

// Minimal
const TextDivider(text: 'or')

// Customised
TextDivider(
  text: 'or',
  color: Colors.grey,
  thickness: 1.5,
  gap: 12,
  indent: 16,
  endIndent: 16,
  textStyle: const TextStyle(fontSize: 14, color: Colors.grey),
)
```

### Vertical

The widget must be placed inside a parent with a **bounded height** (e.g. a
`SizedBox`, `Expanded`, or a `Column` with constrained height).

```dart
SizedBox(
  height: 200,
  child: TextDivider(
    text: 'or',
    axis: Axis.vertical,
    color: Colors.grey,
    thickness: 1.5,
    gap: 12,
  ),
)
```

---

## Parameters

| Parameter   | Type         | Default           | Description                                                      |
|-------------|--------------|-------------------|------------------------------------------------------------------|
| `text`      | `String`     | **required**      | Label shown in the centre of the divider.                        |
| `axis`      | `Axis`       | `Axis.horizontal` | Orientation of the dividing lines.                               |
| `textStyle` | `TextStyle?` | `bodyMedium`      | Style applied to `text`.                                         |
| `color`     | `Color?`     | theme default     | Colour of the dividing lines.                                    |
| `thickness` | `double`     | `1.0`             | Thickness of each line. Must be > 0.                             |
| `gap`       | `double`     | `8.0`             | Space between the text and each line.                            |
| `indent`    | `double`     | `0.0`             | Leading space (left for horizontal, top for vertical).           |
| `endIndent` | `double`     | `0.0`             | Trailing space (right for horizontal, bottom for vertical).      |

---

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  text_divider: ^0.1.0
```

Then run:

```sh
flutter pub get
```
