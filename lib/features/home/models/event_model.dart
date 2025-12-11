part of '../home.dart';

enum EventCategory { nightLife, christmas, newYear, cultural }

class EventModel {
  final int id;
  final String name;
  final String date;
  final String location;
  final double price;
  final String imageUrl;
  final EventCategory category;
  final String description;

  const EventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  // Mock data
  static List<EventModel> getMockData() {
    return [
      EventModel(
        id: 101,
        name: 'Christmas Beach Party',
        date: 'December 25, 2025',
        location: 'Sharm El Sheikh',
        price: 85,
        imageUrl:
            'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=800',
        category: EventCategory.christmas,
        description: 'Celebrate Christmas on the beach with music and food',
      ),
      EventModel(
        id: 102,
        name: 'New Year Gala Night',
        date: 'December 31, 2025',
        location: 'Hurghada',
        price: 120,
        imageUrl:
            'https://images.unsplash.com/photo-1467810563316-b5476525c0f9?w=800',
        category: EventCategory.newYear,
        description: 'Ring in the new year with a spectacular celebration',
      ),
      EventModel(
        id: 103,
        name: 'Night Club Experience',
        date: 'Every Friday & Saturday',
        location: 'Sharm El Sheikh',
        price: 50,
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800',
        category: EventCategory.nightLife,
        description: 'Premium nightclub experience with international DJs',
      ),
      EventModel(
        id: 104,
        name: 'Egyptian Cultural Night',
        date: 'Every Thursday',
        location: 'Luxor',
        price: 45,
        imageUrl:
            'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=800',
        category: EventCategory.cultural,
        description: 'Traditional Egyptian music, dance, and cuisine',
      ),
    ];
  }
}
