import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Row(
        children: [
          // Search Bar Container
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Search a Destinations, Hotels, etc',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DM Sans 36pt',
                  ),

                  suffixIcon: CustomIcon(iconPath: AppIcons.search, size: 32),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          GestureDetector(
            onTap: onFilterTap,
            child: Center(
              child: CustomIcon(iconPath: AppIcons.filter, size: 36),
            ),
          ),
        ],
      ),
    );
  }
}
