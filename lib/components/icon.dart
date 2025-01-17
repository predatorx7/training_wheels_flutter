import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// An alternative to the [ImageIcon] which supports ignoring icon colors from the theme.
/// Right now there seems no way to ignore the [IconTheme]'s color applied in the [ImageIcon].
/// An icon that comes from an [ImageProvider], e.g. an [AssetImage].
/// The only difference between this and [ImageIcon] is [ignoreIconColor].
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [IconTheme], which provides ambient configuration for icons.
///  * [Icon], for icons based on glyphs from fonts instead of images.
///  * [Icons], a predefined font based set of icons from the material design library.
class IconImage extends StatelessWidget {
  /// Creates an image icon.
  ///
  /// The [size] and [color] default to the value given by the current [IconTheme].
  const IconImage(
    this.image, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.ignoreIconColor = true,
  });

  /// The image to display as the icon.
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final ImageProvider? image;

  final bool ignoreIconColor;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it defaults to
  /// 24.0.
  final double? size;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the current [IconTheme] color, if any. If there is
  /// no [IconTheme], then it defaults to not recolorizing the image.
  ///
  /// The image will be additionally adjusted by the opacity of the current
  /// [IconTheme], if any.
  final Color? color;

  /// Semantic label for the icon.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;

    if (image == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    Color? effectiveIconColor;

    if (!ignoreIconColor) {
      final double? iconOpacity = iconTheme.opacity;
      Color iconColor = color ?? iconTheme.color!;

      if (iconOpacity != null && iconOpacity != 1.0) {
        iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
      }
      effectiveIconColor = iconColor;
    }

    return Semantics(
      label: semanticLabel,
      child: Image(
        image: image!,
        width: iconSize,
        height: iconSize,
        color: effectiveIconColor,
        fit: BoxFit.scaleDown,
        excludeFromSemantics: true,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ImageProvider>('image', image,
        ifNull: '<empty>', showName: false));
    properties.add(DoubleProperty('size', size, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}

/// An alternative to the [ImageIcon] which supports ignoring icon colors from the theme.
/// Right now there seems no way to ignore the [IconTheme]'s color applied in the [ImageIcon].
/// An icon that comes from an [ImageProvider], e.g. an [AssetImage].
/// The only difference between this and [ImageIcon] is [ignoreIconColor].
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [IconTheme], which provides ambient configuration for icons.
///  * [Icon], for icons based on glyphs from fonts instead of images.
///  * [Icons], a predefined font based set of icons from the material design library.
class SvgIconImage extends StatelessWidget {
  /// Creates an image icon.
  ///
  /// The [size] and [color] default to the value given by the current [IconTheme].
  const SvgIconImage(
    this.image, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.ignoreIconColor = true,
  });

  /// The image to display as the icon.
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final String? image;

  final bool ignoreIconColor;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it defaults to
  /// 24.0.
  final double? size;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the current [IconTheme] color, if any. If there is
  /// no [IconTheme], then it defaults to not recolorizing the image.
  ///
  /// The image will be additionally adjusted by the opacity of the current
  /// [IconTheme], if any.
  final Color? color;

  /// Semantic label for the icon.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;

    if (image == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    Color? effectiveIconColor;

    if (!ignoreIconColor) {
      final double? iconOpacity = iconTheme.opacity;
      Color iconColor = color ?? iconTheme.color!;

      if (iconOpacity != null && iconOpacity != 1.0) {
        iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
      }
      effectiveIconColor = iconColor;
    }

    return Semantics(
      label: semanticLabel,
      child: SvgPicture.asset(
        image!,
        width: iconSize,
        height: iconSize,
        colorFilter: effectiveIconColor != null
            ? ColorFilter.mode(effectiveIconColor, BlendMode.srcIn)
            : null,
        fit: BoxFit.scaleDown,
        excludeFromSemantics: true,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('image', image,
        ifNull: '<empty>', showName: false));
    properties.add(DoubleProperty('size', size, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}
