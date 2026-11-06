import 'package:flutter/material.dart';

/// Micro-interacción estilo iOS: compresión elástica sutil al presionar o hacer hover.
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final double scaleDown;
  final Duration duration;
  final bool enabled;

  const PressableScale({
    super.key,
    required this.child,
    this.onPressed,
    this.onTap,
    this.scaleDown = 0.965,
    this.duration = const Duration(milliseconds: 130),
    this.enabled = true,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _isPressed = false;
  bool _isHovered = false;

  VoidCallback? get _action => widget.onTap ?? widget.onPressed;

  void _handleTapDown(TapDownDetails _) {
    if (!widget.enabled || _action == null) return;
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    if (!widget.enabled || _action == null) return;
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (!widget.enabled || _action == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final double targetScale = !widget.enabled
        ? 1.0
        : _isPressed
            ? widget.scaleDown
            : _isHovered
                ? 1.015
                : 1.0;

    return MouseRegion(
      onEnter: (_) {
        if (widget.enabled && _action != null) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (widget.enabled) {
          setState(() => _isHovered = false);
        }
      },
      cursor: widget.enabled && _action != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.enabled ? _action : null,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: targetScale,
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
