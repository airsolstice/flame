import 'dart:ui';
import 'package:flutter/material.dart' as material;

import 'position.dart';
import 'anchor.dart';

/// A Text Config contains all typographical information required to render texts; i.e., font size and color, family, etc.
///
/// It does not hold information regarding the position of the text to be render neither the text itself (the string).
/// To hold all those information, use the Text component.
class TextConfig {
  /// The font size to be used, in points.
  final double fontSize;

  /// The font color to be used.
  ///
  /// Dart's [Color] class is just a plain wrapper on top of ARGB color (0xFFrrggbb).
  /// For example,
  ///
  ///     const TextConfig config = TextConfig(color: const Color(0xFF00FF00)); // green
  ///
  /// You can also use your Palette class to access colors used in your game.
  final Color color;

  /// The font family to be used. You can use available by default fonts for your platform (like Arial), or you can add custom fonts.
  ///
  /// To add custom fonts, add the following code to your pubspec.yml file:
  ///
  ///     flutter:
  ///       fonts:
  ///         - family: 5x5
  ///           fonts:
  ///             - asset: assets/fonts/5x5_pixel.ttf
  /// In this example we are adding a font family that's being named '5x5' provided in the specified ttf file.
  /// You must provide the full path of the ttf file (from root); you should put it into your assets folder, and preferably inside a fonts folder.
  /// You don't need to add this together with the other assets on the flutter/assets bit.
  /// The name you choose for the font family can be any name (it's not inside the TTF file and the filename doesn't need to match).
  final String fontFamily;

  /// The [TextAlign] to be used when creating the [material.TextPainter].
  ///
  /// Beware: it's recommended to leave this with the default value of [TextAlign.left].
  /// Use the anchor parameter to [render] to specify a proper relative position.
  final TextAlign textAlign;

  /// The direction to render this text (left to right or right to left).
  ///
  /// Normally, leave this as is for most languages.
  /// For proper fonts of languages like Hebrew or Arabic, replace this with [TextDirection.rtl].
  final TextDirection textDirection;

  /// Creates a constant [TextConfig] with sensible defaults.
  ///
  /// Every parameter can be specified.
  const TextConfig({
    this.fontSize: 24.0,
    this.color: const Color(0xFF000000),
    this.fontFamily: 'Arial',
    this.textAlign: TextAlign.left,
    this.textDirection: TextDirection.ltr,
  });

  /// Renders a given [text] in a given position [p] using the provided [canvas] and [anchor].
  ///
  /// It creates a [material.TextPainter] instance using the [toTextPainter] method, and renders it in the given position, considering the [anchor] specified.
  /// For example, if [Anchor.center] is specified, it's going to be drawn centered around [p].
  ///
  /// Example usage:
  ///
  ///     const TextConfig config = TextConfig(fontSize: 48.0, fontFamily: 'Awesome Font', anchor: Anchor.rightBottom);
  ///     config.render(c, Offset(size.width - 10, size.height - 10);
  void render(Canvas canvas, String text, Position p,
      {Anchor anchor: Anchor.topLeft}) {
    material.TextPainter tp = toTextPainter(text);
    Position translatedPosition =
        anchor.translate(p, Position.fromSize(tp.size));
    tp.paint(canvas, translatedPosition.toOffset());
  }

  /// Returns a [material.TextPainter] that allows for text rendering and size measuring.
  ///
  /// A [material.TextPainter] has three important properties: paint, width and height (or size).
  ///
  /// Example usage:
  ///
  ///     const TextConfig config = TextConfig(fontSize: 48.0, fontFamily: 'Awesome Font');
  ///     final tp = config.toTextPainter('Score: $score');
  ///     tp.paint(c, Offset(size.width - p.width - 10, size.height - p.height - 10));
  ///
  /// However, you probably want to use the [render] method witch already renders for you considering the anchor.
  /// That way, you don't need to perform the math for yourself.
  material.TextPainter toTextPainter(String text) {
    material.TextStyle style = material.TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );
    material.TextSpan span = material.TextSpan(
      style: style,
      text: text,
    );
    material.TextPainter tp = material.TextPainter(
      text: span,
      textAlign: textAlign,
      textDirection: textDirection,
    );
    tp.layout();
    return tp;
  }

  /// Creates a new [TextConfig] changing only the [fontSize].
  ///
  /// This does not change the original (as it's immutable).
  TextConfig withFontSize(double fontSize) {
    return TextConfig(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }

  /// Creates a new [TextConfig] changing only the [color].
  ///
  /// This does not change the original (as it's immutable).
  TextConfig withColor(Color color) {
    return TextConfig(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }

  /// Creates a new [TextConfig] changing only the [fontFamily].
  ///
  /// This does not change the original (as it's immutable).
  TextConfig withFontFamily(String fontFamily) {
    return TextConfig(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }

  /// Creates a new [TextConfig] changing only the [textAlign].
  ///
  /// This does not change the original (as it's immutable).
  TextConfig withTextAlign(TextAlign textAlign) {
    return TextConfig(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }

  /// Creates a new [TextConfig] changing only the [textDirection].
  ///
  /// This does not change the original (as it's immutable).
  TextConfig withTextDirection(TextDirection textDirection) {
    return TextConfig(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
