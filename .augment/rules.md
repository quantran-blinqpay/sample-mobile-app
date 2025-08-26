# Augment Rules for Flutter Project

## Runtime & Environment
- Target **Flutter 3.5.2** and **Dart 2.17.x**.
- Do **not** use any Flutter APIs, widgets, or features introduced **after 3.5.2**.
- Code must compile and run in Flutter 3.5.2 without modification.

## Widgets & UI
- Use **Material 2** components only.  
  - ✅ Use: `ElevatedButton`, `TextButton`, `OutlinedButton`  
  - ❌ Do not use: `FilledButton`, `SegmentedButton`, `WidgetStateProperty` (Material 3)
- Use `Theme.of(context)` for colors, typography, etc.
- Do not use Material 3 specific constructors or parameters.

## Language & SDK
- Dart **2.17.x** features only.  
  - ✅ Null-safety  
  - ✅ Enhanced enums  
  - ❌ Do not use records, patterns, sealed classes, or other Dart 3 features.

## Packages
- Use only dependencies compatible with Flutter 3.5.2.
- Always declare dependencies in `pubspec.yaml` with explicit versions.

## Code Style
- Follow Flutter best practices:
  - Keep widgets small and composable.
  - Use `const` constructors whenever possible.
  - Use `StatefulWidget` only if local state is required.
- Code must pass `flutter analyze` without warnings on Flutter 3.5.2.

## Testing
- Generate tests with `flutter_test` where possible.
- Ensure tests run successfully in Flutter 3.5.2.

---