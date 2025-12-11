part of '../home.dart';

class ExcursionModel {
  final int id;
  final String name;
  final String location;
  final double price;
  final String imageUrl;
  final ExcursionCategory category;
  final String duration;
  final double rating;
  final String description;

  const ExcursionModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.duration,
    required this.rating,
    required this.description,
  });

  // Mock data
  static List<ExcursionModel> getMockData() {
    return [
      ExcursionModel(
        id: 1,
        name: 'Red Sea Snorkeling Adventure',
        location: 'Sharm El Sheikh',
        price: 45,
        imageUrl:
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        category: ExcursionCategory.snorkeling,
        duration: '4 hours',
        rating: 4.8,
        description:
            'Explore the beautiful coral reefs and colorful marine life',
      ),
      ExcursionModel(
        id: 2,
        name: 'Desert Safari Experience',
        location: 'Hurghada',
        price: 65,
        imageUrl:
            'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?w=800',
        category: ExcursionCategory.safari,
        duration: '6 hours',
        rating: 4.9,
        description:
            'Thrilling desert adventure with quad bikes and camel rides',
      ),
      ExcursionModel(
        id: 3,
        name: 'Professional Scuba Diving',
        location: 'Sharm El Sheikh',
        price: 95,
        imageUrl:
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
        category: ExcursionCategory.diving,
        duration: '5 hours',
        rating: 5.0,
        description: 'Deep sea diving experience with certified instructors',
      ),
      ExcursionModel(
        id: 4,
        name: 'Luxor Temple Tour',
        location: 'Luxor',
        price: 80,
        imageUrl:
            'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=800',
        category: ExcursionCategory.cultural,
        duration: '8 hours',
        rating: 4.9,
        description: 'Visit ancient Egyptian temples and monuments',
      ),
      ExcursionModel(
        id: 5,
        name: 'Bedouin Night Safari',
        location: 'Hurghada',
        price: 55,
        imageUrl:
            'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?w=800',
        category: ExcursionCategory.safari,
        duration: '7 hours',
        rating: 4.7,
        description: 'Experience Bedouin culture with dinner and stargazing',
      ),
      ExcursionModel(
        id: 6,
        name: 'Parasailing Adventure',
        location: 'Sharm El Sheikh',
        price: 70,
        imageUrl:
            'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800',
        category: ExcursionCategory.adventure,
        duration: '2 hours',
        rating: 4.6,
        description: 'Soar above the Red Sea with breathtaking views',
      ),
    ];
  }
}
