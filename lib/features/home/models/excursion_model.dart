part of '../home.dart';

class ExcursionModel {
  final int id;
  final String name;
  final String location;
  final double price;
  final String imageUrl;
  final List<ExcursionCategory> categories;
  final String duration;
  final double rating;
  final String description;

  const ExcursionModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.categories,
    required this.duration,
    required this.rating,
    required this.description,
  });

  ExcursionCategory get category =>
      categories.isNotEmpty ? categories.first : ExcursionCategory.all;

  // Mock data
  static List<ExcursionModel> getMockData() {
    return [
      ExcursionModel(
        id: 1,
        name: LocaleKeys.excursion_red_sea_name.tr(),
        location:
            'Sharm El Sheikh', // Location names typically stay as is or need separate keys
        price: 45,
        imageUrl:
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        categories: const [ExcursionCategory.snorkeling],
        duration: '4 ${LocaleKeys.hours.tr()}',
        rating: 4.8,
        description: LocaleKeys.excursion_red_sea_desc.tr(),
      ),
      ExcursionModel(
        id: 2,
        name: LocaleKeys.excursion_safari_name.tr(),
        location: 'Hurghada',
        price: 65,
        imageUrl:
            'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?w=800',
        categories: const [ExcursionCategory.safari],
        duration: '6 ${LocaleKeys.hours.tr()}',
        rating: 4.9,
        description: LocaleKeys.excursion_safari_desc.tr(),
      ),
      ExcursionModel(
        id: 3,
        name: LocaleKeys.excursion_scuba_name.tr(),
        location: 'Sharm El Sheikh',
        price: 95,
        imageUrl:
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
        categories: const [ExcursionCategory.diving],
        duration: '5 ${LocaleKeys.hours.tr()}',
        rating: 5.0,
        description: LocaleKeys.excursion_scuba_desc.tr(),
      ),
      ExcursionModel(
        id: 4,
        name: LocaleKeys.excursion_luxor_name.tr(),
        location: 'Luxor',
        price: 80,
        imageUrl:
            'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=800',
        categories: const [ExcursionCategory.cultural],
        duration: '8 ${LocaleKeys.hours.tr()}',
        rating: 4.9,
        description: LocaleKeys.excursion_luxor_desc.tr(),
      ),
      ExcursionModel(
        id: 5,
        name: LocaleKeys.excursion_bedouin_name.tr(),
        location: 'Hurghada',
        price: 55,
        imageUrl:
            'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?w=800',
        categories: const [ExcursionCategory.safari],
        duration: '7 ${LocaleKeys.hours.tr()}',
        rating: 4.7,
        description: LocaleKeys.excursion_bedouin_desc.tr(),
      ),
      ExcursionModel(
        id: 6,
        name: LocaleKeys.excursion_parasailing_name.tr(),
        location: 'Sharm El Sheikh',
        price: 70,
        imageUrl:
            'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800',
        categories: const [ExcursionCategory.adventure],
        duration: '2 ${LocaleKeys.hours.tr()}',
        rating: 4.6,
        description: LocaleKeys.excursion_parasailing_desc.tr(),
      ),
    ];
  }
}
