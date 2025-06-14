import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleport_app/data/models/hotel_model.dart';
import 'package:teleport_app/data/models/review_model.dart';

class HotelController extends GetxController {
  // Observables
  final RxList<HotelModel> hotels = <HotelModel>[].obs;
  final RxList<HotelModel> filteredHotels = <HotelModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt selectedBottomNavIndex = 0.obs;
  final RxInt currentImageIndex = 0.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadHotels();
  }

  // Enhanced hardcoded data
  void loadHotels() {
    isLoading.value = true;

    Future.delayed(Duration(milliseconds: 500), () {
      List<HotelModel> hotelData = [
        HotelModel(
          id: 1,
          name: 'Pine Resort',
          location: 'Honolulu, Hawaii',
          rating: 4.4,
          price: 400,
          imageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
          amenities: ['Swimming Pool', 'Free WIFI', 'Bar'],
          facilities: ['3 Bedroom', '4 Bathroom', 'Free Wi-Fi'],
          description:
              'Experience luxury at its finest at Pine Resort, located in the heart of Honolulu, Hawaii. Our resort offers breathtaking ocean views, world-class amenities, and exceptional service.',
          images: [
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
            'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
          ],
        ),
        HotelModel(
          id: 2,
          name: 'Grand Plaza Hotel',
          location: 'New York, USA',
          rating: 4.4,
          price: 250,
          imageUrl:
              'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
          amenities: ['Swimming Pool', 'Free WIFI', 'Bar'],
          facilities: ['2 Bedroom', '3 Bathroom', 'Free Wi-Fi'],
          description:
              'Located in the heart of Manhattan, Grand Plaza Hotel offers modern luxury with stunning city views.',
          images: [
            'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
          ],
        ),
        HotelModel(
          id: 3,
          name: 'Ocean View Resort',
          location: 'Miami, Florida',
          rating: 4.4,
          price: 180,
          imageUrl:
              'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
          amenities: ['Swimming Pool', 'Free WIFI', 'Bar'],
          facilities: ['1 Bedroom', '2 Bathroom', 'Free Wi-Fi'],
          description:
              'Enjoy beachfront luxury at Ocean View Resort with direct access to Miami\'s pristine beaches.',
          images: [
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
            'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
          ],
        ),
      ];

      hotels.assignAll(hotelData);
      filteredHotels.assignAll(hotelData);
      isLoading.value = false;
    });
  }

  void searchHotels(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredHotels.assignAll(hotels);
    } else {
      filteredHotels.assignAll(
        hotels
            .where(
              (hotel) =>
                  hotel.name.toLowerCase().contains(query.toLowerCase()) ||
                  hotel.location.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    filteredHotels.assignAll(hotels);
  }

  void toggleFavorite(int hotelId) {
    final hotelIndex = hotels.indexWhere((h) => h.id == hotelId);
    final filteredIndex = filteredHotels.indexWhere((h) => h.id == hotelId);

    if (hotelIndex != -1) {
      hotels[hotelIndex] = hotels[hotelIndex].copyWith(
        isFavorite: !hotels[hotelIndex].isFavorite,
      );
    }
    if (filteredIndex != -1) {
      filteredHotels[filteredIndex] = filteredHotels[filteredIndex].copyWith(
        isFavorite: !filteredHotels[filteredIndex].isFavorite,
      );
    }
  }

  void onBottomNavTap(int index) {
    selectedBottomNavIndex.value = index;
  }

  void updateImageIndex(int index) {
    currentImageIndex.value = index;
  }

  // Get hotel by ID for detail screen
  HotelModel? getHotelById(int id) {
    try {
      return hotels.firstWhere((hotel) => hotel.id == id);
    } catch (e) {
      return null;
    }
  }

  //review

  // Reviews data
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxString selectedReviewFilter = 'All'.obs;
  final RxList<ReviewModel> filteredReviews = <ReviewModel>[].obs;

  void loadReviews() {
    List<ReviewModel> reviewData = [
      ReviewModel(
        id: 1,
        userName: 'Alan Watts',
        userImage:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        comment:
            'Absolutely loved my stay at Azure Palm Resort! The staff was super friendly and always available to help. My room had a stunning ocean view and was spotless when I arrived. The breakfast buffet was delicious and had a ton of variety. I especially enjoyed relaxing by the infinity pool in the evenings. I\'ll definitely be coming back!',
        rating: 5.0,
        date: DateTime(2024, 1, 20),
        initials: 'AW',
      ),
      ReviewModel(
        id: 2,
        userName: 'Alan Watts',
        userImage:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        comment:
            'Absolutely loved my stay at Azure Palm Resort! The staff was super friendly and always available to help.',
        rating: 5.0,
        date: DateTime(2024, 1, 20),
        initials: 'AW',
      ),
      ReviewModel(
        id: 3,
        userName: 'Sarah Johnson',
        userImage:
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
        comment:
            'Great location and beautiful rooms. The service was excellent and the amenities were top-notch. Would definitely recommend!',
        rating: 4.0,
        date: DateTime(2024, 1, 18),
        initials: 'SJ',
      ),
      ReviewModel(
        id: 4,
        userName: 'Mike Chen',
        userImage:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        comment:
            'Perfect vacation spot! Clean rooms, friendly staff, and amazing food. The pool area is fantastic.',
        rating: 5.0,
        date: DateTime(2024, 1, 15),
        initials: 'MC',
      ),
      ReviewModel(
        id: 5,
        userName: 'Emma Wilson',
        userImage:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        comment:
            'Good hotel overall. Room was clean and comfortable. Breakfast could be better but the location makes up for it.',
        rating: 4.0,
        date: DateTime(2024, 1, 12),
        initials: 'EW',
      ),
    ];

    reviews.assignAll(reviewData);
    filteredReviews.assignAll(reviewData); // ✅ ADD THIS LINE
  }

  void filterReviews(String filter) {
    selectedReviewFilter.value = filter;

    if (filter == 'All') {
      filteredReviews.assignAll(reviews);
    } else {
      int starRating = int.parse(filter.split(' ')[0]);

      filteredReviews.assignAll(
        reviews.where((review) => review.rating.toInt() == starRating).toList(),
      );
    }
  }
}
