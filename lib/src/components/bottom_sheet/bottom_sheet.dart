import 'package:flutter/material.dart';

Future<dynamic> showFMBS({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  BorderRadiusGeometry? borderRadius,
  Clip? clipBehavior,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  double? height,
  RouteSettings? routeSettings,
}) {
  return showModalBottomSheet(
    elevation: 0,
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    context: context,
    useRootNavigator: useRootNavigator,
    useSafeArea: true,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (context) {
      final mq = MediaQuery.of(context);
      var insetsHeight = 0.0;
      if (height != null) {
        final totalHeight = height + mq.viewInsets.bottom;
        insetsHeight =
            totalHeight >= (mq.size.height - mq.padding.top - mq.padding.bottom)
                ? (mq.size.height - mq.padding.top - mq.padding.bottom) - height
                : MediaQuery.of(context).viewInsets.bottom;
      }

      return SizedBox(
        height: height != null ? height + insetsHeight : null,
        child: ClipRRect(
          borderRadius:borderRadius?? const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Builder(builder: builder),
        ),
      );
    },
  );
}
