import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teleport_app/data/models/hotel_model.dart';
import 'package:teleport_app/presentation/views/hotel_dashboard.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/colors.dart';

class HotelCard extends StatelessWidget {
  final HotelModel hotel;
  final VoidCallback? onFavoritePressed;

  const HotelCard({Key? key, required this.hotel, this.onFavoritePressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HotelDetailScreen(hotel: hotel));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Container(
                    height: 200.h,
                    width: double.infinity,
                    child: Image.network(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.hotel, size: 50.sp),
                        );
                      },
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightMustardColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIcon(
                          iconPath: AppIcons.starCircle,
                          size: 18,
                          color: AppColors.rating,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          hotel.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: CustomIcon(
                    iconPath:
                        hotel.isFavorite
                            ? AppIcons.saveContainer
                            : AppIcons.saveContainer,
                    size: 36,
                    onTap: onFavoritePressed,
                  ),
                ),
                //  Price Badge
                Positioned(
                  bottom: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '\$${hotel.price}/Day',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Hotel Details
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.sp,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          hotel.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontFamily: 'DM Sans 36pt',
                          ),
                        ),
                      ),
                      SizedBox(width: 5.h),
                      Wrap(
                        spacing: 12.w,
                        children:
                            hotel.amenities.map((amenity) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Dot symbol
                                  Container(
                                    width: 5.w,
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.itemCircle,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  // Amenity text
                                  Text(
                                    amenity,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.textLight,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
