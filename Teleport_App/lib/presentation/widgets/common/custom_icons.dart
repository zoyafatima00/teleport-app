import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIcon extends StatelessWidget {
  final String iconPath;
  final double? size;
  final Color? color;
  final VoidCallback? onTap;

  const CustomIcon({
    Key? key,
    required this.iconPath,
    this.size,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Image.asset(
      iconPath,
      width: size?.w ?? 24.w,
      height: size?.h ?? 24.h,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to material icon if asset not found
        return Icon(
          Icons.error,
          size: size?.sp ?? 24.sp,
          color: color ?? Colors.grey,
        );
      },
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: iconWidget);
    }

    return iconWidget;
  }
}
