import 'package:flutter/material.dart';

class SwitchController extends ValueNotifier<bool> {
  SwitchController({bool value = false}) : super(value);

  void toggle([bool? state]) {
    value = state ?? !value;
    notifyListeners();
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
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
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
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
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
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
        width: 46,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: value
              ? widget.activeColor ?? Colors.black
              : const Color(0xff000000).withValues(alpha: 0.15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: 3,
              left: value ? 46 - 22 : 3,
              right: (value) ? 3 : 46 - 22,
              bottom: 3,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? Colors.white : Colors.grey,
                ),
                alignment: Alignment.center,
                child: value
                    ? Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 14,
                      )
                    : SizedBox(),
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
