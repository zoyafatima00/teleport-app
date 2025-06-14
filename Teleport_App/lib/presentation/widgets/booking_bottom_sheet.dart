import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teleport_app/core/constants/app_icons.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';

import '../../core/constants/colors.dart';
import '../../data/models/hotel_model.dart';
import '../views/review_screen.dart';

class BookingBottomSheet extends StatelessWidget {
  final HotelModel hotel;

  const BookingBottomSheet({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 50.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hotel Name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.ratingBg.withOpacity(0.53),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIcon(
                                size: 18.sp,
                                iconPath: AppIcons.starCircle,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                hotel.rating.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // Location
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
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),

                        // Amenities with dots
                        Row(
                          children:
                              hotel.amenities.map((amenity) {
                                return Container(
                                  margin: EdgeInsets.only(right: 16.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Dot symbol
                                      Container(
                                        width: 4.w,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.textLight,
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
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Facilities Section
                    Text(
                      'Facilities',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Facilities Grid
                    Row(
                      children: [
                        _buildFacilityItem(Icons.bed, hotel.facilities[0]),
                        SizedBox(width: 12.w),
                        _buildFacilityItem(Icons.bathtub, hotel.facilities[1]),
                        SizedBox(width: 12.w),
                        _buildFacilityItem(Icons.wifi, hotel.facilities[2]),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Location Section
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 16.h),
                    // Map Placeholder
                    Image.asset(AppIcons.mapImage, fit: BoxFit.cover),

                    SizedBox(height: 14.h),

                    // Guest Reviews Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Guest Reviews',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Get.back(); // Close bottom sheet first
                            Get.to(
                              () => ReviewsScreen(hotel: hotel),
                            ); // Navigate to reviews
                          },
                          child: Row(
                            children: [
                              Text(
                                'See More',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Reviews Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overall Rating
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: AppColors.rating,
                                    size: 16.sp,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),

                        // Rating Breakdown
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              _buildRatingRow(5, 4.8),
                              SizedBox(height: 4.h),
                              _buildRatingRow(4, 4.8),
                              SizedBox(height: 4.h),
                              _buildRatingRow(3, 4.8),
                              SizedBox(height: 4.h),
                              _buildRatingRow(2, 4.8),
                              SizedBox(height: 4.h),
                              _buildRatingRow(1, 4.8),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityItem(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.facilitiesBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.sp, color: AppColors.primary),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(int stars, double rating) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.rating, size: 12.sp),
        SizedBox(width: 4.w),
        Text(
          stars.toString(),
          style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: rating / 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          rating.toString(),
          style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// Helper function to show the bottom sheet
void showBookingBottomSheet(BuildContext context, HotelModel hotel) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BookingBottomSheet(hotel: hotel),
  );
}
