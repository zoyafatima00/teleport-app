import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teleport_app/core/constants/app_icons.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';

import '../../core/constants/colors.dart';
import '../../data/models/hotel_model.dart';
import '../controllers/hotel_controller.dart';
import '../widgets/booking_bottom_sheet.dart';

class HotelDetailScreen extends StatelessWidget {
  final HotelModel hotel;
  final HotelController controller = Get.find<HotelController>();

  HotelDetailScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Image Carousel
                  PageView.builder(
                    itemCount: hotel.images.length,
                    onPageChanged: controller.updateImageIndex,
                    itemBuilder: (context, index) {
                      return Image.network(
                        hotel.images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.hotel, size: 50.sp),
                          );
                        },
                      );
                    },
                  ),
                  // Page Indicators
                  Positioned(
                    bottom: 20.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        hotel.images.length,
                        (index) => Obx(
                          () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width:
                                controller.currentImageIndex.value == index
                                    ? 20.w
                                    : 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color:
                                  controller.currentImageIndex.value == index
                                      ? AppColors.primary
                                      : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Row (Back, Title, Favorite)
                  Positioned(
                    top: 50.h, // Adjust based on status bar height
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: CustomIcon(
                                iconPath: AppIcons.backCircle,
                                size: 40,
                              ),
                            ),

                            SizedBox(width: 17),
                            Text(
                              'Book a Hotel',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'DM Sans 36pt',
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => controller.toggleFavorite(hotel.id),
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.circleBgColor.withOpacity(
                                0.32,
                              ), // Blur effect
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Obx(() {
                                final currentHotel = controller.getHotelById(
                                  hotel.id,
                                );
                                return Icon(
                                  currentHotel?.isFavorite == true
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.white,
                                  size: 20.sp, // Custom small size
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
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
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.ratingBg.withOpacity(0.53),
                            borderRadius: BorderRadius.circular(8.r),
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

                    SizedBox(height: 8.h),

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
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.h),

                        // Amenities
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
                                      SizedBox(width: 6.w),
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Facilities Grid
                    Row(
                      children: [
                        _buildFacilityItem(
                          AppIcons.bedroom,
                          hotel.facilities[0],
                        ),
                        SizedBox(width: 20.w),
                        _buildFacilityItem(
                          AppIcons.bathroom,
                          hotel.facilities[1],
                        ),
                        SizedBox(width: 20.w),
                        _buildFacilityItem(AppIcons.wifi, hotel.facilities[2]),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Location Section
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18.sp,
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
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'See More',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12.sp,
                                color: AppColors.blackColor.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 75.h), // Space for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar
      bottomSheet: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.r,
              offset: Offset(0, -2.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12.sp,
                    //color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${hotel.price} USD/ Per night',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    //color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () => showBookingBottomSheet(context, hotel),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.bookNowBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Book now',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityItem(String iconPath, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.facilitiesBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            CustomIcon(iconPath: iconPath, size: 22, color: AppColors.primary),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'DM Sans 36pt',
                fontSize: 12.sp,
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
}
