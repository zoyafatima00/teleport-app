class HotelModel {
  final int id;
  final String name;
  final String location;
  final double rating;
  final int price;
  final String imageUrl;
  final List<String> amenities;
  final bool isFavorite;
  final List<String> facilities;
  final String description;
  final List<String> images;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.amenities,
    this.isFavorite = false,
    required this.facilities,
    required this.description,
    required this.images,
  });

  HotelModel copyWith({bool? isFavorite}) {
    return HotelModel(
      id: id,
      name: name,
      location: location,
      rating: rating,
      price: price,
      imageUrl: imageUrl,
      amenities: amenities,
      isFavorite: isFavorite ?? this.isFavorite,
      facilities: facilities,
      description: description,
      images: images,
    );
  }
}
