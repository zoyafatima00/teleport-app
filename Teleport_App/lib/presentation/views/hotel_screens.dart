import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teleport_app/presentation/widgets/common/custom_icons.dart';
import 'package:teleport_app/presentation/widgets/search_bar.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/colors.dart';
import '../controllers/hotel_controller.dart';
import '../widgets/hotel_card.dart';

class HotelsScreen extends StatelessWidget {
  final HotelController controller = Get.put(HotelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(color: AppColors.blackColor),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      CustomIcon(
                        iconPath: AppIcons.backCircle,
                        size: 40,
                        onTap: () => Get.back(),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Hotels',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ],
              ),
            ),
            // Hotels List
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),

                child: Column(
                  children: [
                    // Search Bar
                    CustomSearchBar(
                      controller: controller.searchController,
                      onChanged: controller.searchHotels,
                      onClear: controller.clearSearch,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          );
                        }

                        if (controller.filteredHotels.isEmpty) {
                          return Center(
                            child: Text(
                              'No hotels found',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.all(20.r),
                          itemCount: controller.filteredHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = controller.filteredHotels[index];
                            return HotelCard(
                              hotel: hotel,
                              onFavoritePressed:
                                  () => controller.toggleFavorite(hotel.id),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation with Custom Icons
      bottomNavigationBar: Container(
        height: 80.h,
        color: Colors.white,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                AppIcons.home,
                'Home',
                controller.selectedBottomNavIndex.value == 0,
                () => controller.onBottomNavTap(0),
              ),
              _buildBottomNavItem(
                AppIcons.booking,
                'Bookings',
                controller.selectedBottomNavIndex.value == 1,
                () => controller.onBottomNavTap(1),
              ),
              _buildBottomNavItem(
                AppIcons.help,
                'Help',
                controller.selectedBottomNavIndex.value == 2,
                () => controller.onBottomNavTap(2),
              ),
              _buildBottomNavItem(
                AppIcons.profile,
                'Profile',
                controller.selectedBottomNavIndex.value == 3,
                () => controller.onBottomNavTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    String iconPath,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcon(
            iconPath: iconPath,
            size: 24,
            color:
                isSelected
                    ? AppColors.bottomNavActive
                    : AppColors.bottomNavInactive,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color:
                  isSelected
                      ? AppColors.bottomNavActive
                      : AppColors.bottomNavInactive,
            ),
          ),
        ],
      ),
    );
  }
}
