import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teleport_app/core/constants/app_icons.dart';
import 'package:teleport_app/data/models/review_model.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';

import '../../core/constants/colors.dart';
import '../../data/models/hotel_model.dart';
import '../controllers/hotel_controller.dart';

class ReviewsScreen extends StatelessWidget {
  final HotelModel hotel;
  final HotelController controller = Get.find<HotelController>();

  ReviewsScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load reviews when screen opens
    controller.loadReviews();

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20.r),
              color: AppColors.blackColor,
              child: Row(
                children: [
                  CustomIcon(
                    iconPath: AppIcons.backCircle,
                    size: 40,
                    onTap: () => Get.back(),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'DM Sans 36pt',
                    ),
                  ),
                ],
              ),
            ),

            // White content area with rounded top corners
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 5,
                  ),
                  child: Column(
                    children: [
                      // Rating Overview Section
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Overall Rating (4.8 with stars)
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.all(5.r),
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          color: AppColors.rating,
                                          size: 20.sp,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 20.w),

                            // Rating Breakdown
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  _buildRatingRow(5, 4.8),
                                  SizedBox(height: 8.h),
                                  _buildRatingRow(4, 4.8),
                                  SizedBox(height: 8.h),
                                  _buildRatingRow(3, 4.8),
                                  SizedBox(height: 8.h),
                                  _buildRatingRow(2, 4.8),
                                  SizedBox(height: 8.h),
                                  _buildRatingRow(1, 4.8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Filter Buttons (Scrollable)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildFilterButton('All'),
                              SizedBox(width: 12.w),
                              _buildFilterButton('5 Stars'),
                              SizedBox(width: 12.w),
                              _buildFilterButton('4 Stars'),
                              SizedBox(width: 12.w),
                              _buildFilterButton('3 Stars'),
                              SizedBox(width: 12.w),
                              _buildFilterButton('2 Stars'),
                              SizedBox(width: 12.w),
                              _buildFilterButton('1 Stars'),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Comments Section
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comments',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // Reviews List
                              Expanded(
                                child: Obx(
                                  () => ListView.builder(
                                    itemCount:
                                        controller.filteredReviews.length,
                                    itemBuilder: (context, index) {
                                      return _buildReviewCard(
                                        controller.filteredReviews[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(int stars, double rating) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.rating, size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          stars.toString(),
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: rating / 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          rating.toString(),
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String text) {
    return Obx(() {
      bool isSelected = controller.selectedReviewFilter.value == text;

      return GestureDetector(
        onTap: () {
          controller.filterReviews(text);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: isSelected ? Colors.white : Colors.grey,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: ClipOval(
              child: Image.network(
                review.userImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[400],
                    child: Center(
                      child: Text(
                        review.initials,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name and star rating
                Row(
                  children: [
                    Text(
                      review.userName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardBackground,
                            blurRadius: 4.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.rating,
                              size: 12.sp,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${review.rating.toInt()} Stars',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Date
                Text(
                  '${review.date.day} Jan ${review.date.year}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 8.h),

                // Review text with quotations
                Text(
                  '"${review.comment}"',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
