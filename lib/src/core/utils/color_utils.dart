import 'package:designerwardrobe/src/core/constants/app_constants.dart';

class ColorUtils {
  static String? hexKeyFromLabelString(String input, {String delimiter = ','}) {
    final labels = input.split(delimiter).map((s) => s.trim().toLowerCase());
    for (final label in labels) {
      final entry = colourLabels.entries.firstWhere(
        (e) => e.value.toLowerCase() == label,
        orElse: () => const MapEntry('', ''),
      );
      if (entry.key.isNotEmpty) {
        return entry.key;
      }
    }
    return null;
  }
}
