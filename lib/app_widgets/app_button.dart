import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  /// UI
  final double? height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle? textStyle;

  /// States
  final bool isLoading;
  final bool isEnabled;

  /// Optional icon
  final IconData? icon;
  final double iconSpacing;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.borderRadius = 16,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.iconSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = !isEnabled || isLoading;

    return SizedBox(
      height: height ?? 54.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? backgroundColor.withValues(alpha: 0.5)
              : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final textWidget = Text(
      text,
      style:
          textStyle ??
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
    );

    if (icon == null) return textWidget;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: textColor, size: 18.sp),
        SizedBox(width: iconSpacing.w),
        textWidget,
      ],
    );
  }
}
