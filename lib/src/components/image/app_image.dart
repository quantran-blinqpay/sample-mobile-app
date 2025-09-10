import 'package:cached_network_image/cached_network_image.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.httpHeaders,
    this.imageBuilder,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final Map<String, String>? httpHeaders;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        httpHeaders: httpHeaders,
        fit: fit ?? BoxFit.cover,
        placeholder: placeholder ??
            (context, url) => Center(
                  child: SvgPicture.asset(
                    Assets.svgs.icLogo,
                    width: 80,
                    height: 80,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).extension<AppColors>()!.veryLightGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
        errorWidget:
            errorWidget ?? (context, url, error) => const Icon(Icons.error),
      );
}
