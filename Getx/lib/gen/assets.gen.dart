/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/art1.jpeg
  AssetGenImage get art1 => const AssetGenImage('assets/images/art1.jpeg');

  /// File path: assets/images/art2.jpeg
  AssetGenImage get art2 => const AssetGenImage('assets/images/art2.jpeg');

  /// File path: assets/images/art3.jpeg
  AssetGenImage get art3 => const AssetGenImage('assets/images/art3.jpeg');

  /// File path: assets/images/background_login.png
  AssetGenImage get backgroundLogin =>
      const AssetGenImage('assets/images/background_login.png');

  /// File path: assets/images/bobby.png
  AssetGenImage get bobby => const AssetGenImage('assets/images/bobby.png');

  /// File path: assets/images/food1.jpeg
  AssetGenImage get food1 => const AssetGenImage('assets/images/food1.jpeg');

  /// File path: assets/images/food2.jpeg
  AssetGenImage get food2 => const AssetGenImage('assets/images/food2.jpeg');

  /// File path: assets/images/food3.jpeg
  AssetGenImage get food3 => const AssetGenImage('assets/images/food3.jpeg');

  /// File path: assets/images/view1.jpeg
  AssetGenImage get view1 => const AssetGenImage('assets/images/view1.jpeg');

  /// File path: assets/images/view2.jpeg
  AssetGenImage get view2 => const AssetGenImage('assets/images/view2.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [
        art1,
        art2,
        art3,
        backgroundLogin,
        bobby,
        food1,
        food2,
        food3,
        view1,
        view2
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/icon_calendar.svg
  String get iconCalendar => 'assets/svgs/icon_calendar.svg';

  /// File path: assets/svgs/icon_email.svg
  String get iconEmail => 'assets/svgs/icon_email.svg';

  /// File path: assets/svgs/icon_password.svg
  String get iconPassword => 'assets/svgs/icon_password.svg';

  /// List of all assets
  List<String> get values => [iconCalendar, iconEmail, iconPassword];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
