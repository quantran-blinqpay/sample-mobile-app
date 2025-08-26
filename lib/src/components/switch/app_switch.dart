import 'package:designerwardrobe/src/components/switch/custom_switch.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({
    super.key,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.activeColor,
  });

  final bool? initialValue;
  final ValueChanged<bool>? onChanged;
  final SwitchController? controller;
  final Color? activeColor;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  late bool value;
  late SwitchController controller;
  late AnimationController _animationController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        SwitchController(value: widget.initialValue ?? false);
    value = controller.value;
    controller.addListener(_onChangeValue);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      value: value ? 1.0 : 0.0,
    );
  }

  void _onChangeValue() {
    setState(() {
      value = controller.value;
    });

    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    widget.onChanged?.call(value);
  }

  void _onTap() {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

    controller.toggle();
  }

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      controller.removeListener(_onChangeValue);
      controller = widget.controller ??
          SwitchController(value: widget.initialValue ?? false);
      value = controller.value;
      controller.addListener(_onChangeValue);
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onChangeValue);
    if (widget.controller == null) {
      controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: value
              ? widget.activeColor ?? Colors.black
              : const Color(0xff000000).withValues(alpha: 0.15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: 2,
              left: value ? 50 - 26 : 2,
              right: (value) ? 2 : 50 - 26,
              bottom: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                alignment: Alignment.center,
              ),
              onEnd: () {
                setState(() {
                  _isAnimating = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
