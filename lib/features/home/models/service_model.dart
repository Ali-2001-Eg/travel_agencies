part of '../home.dart';

class ServiceModel {
  final int id;
  final String name;
  final String description;
  final String icon;
  final bool available;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.available = true,
  });

  // Mock data
  static List<ServiceModel> getMockData() {
    return const [
      ServiceModel(
        id: 201,
        name: 'Healthcare',
        description: '24/7 Medical Support',
        icon: '🏥',
      ),
      ServiceModel(
        id: 202,
        name: 'Spa & Massage',
        description: 'Relaxation Services',
        icon: '💆',
      ),
      ServiceModel(
        id: 203,
        name: 'Doctor Consultation',
        description: 'Online & In-person',
        icon: '👨‍⚕️',
      ),
      ServiceModel(
        id: 204,
        name: 'Airport Transfer',
        description: 'Private Transportation',
        icon: '🚗',
      ),
      ServiceModel(
        id: 205,
        name: 'Personal Trainer',
        description: 'Fitness & Wellness',
        icon: '💪',
      ),
      ServiceModel(
        id: 206,
        name: 'Tour Guide',
        description: 'Private Tours',
        icon: '🗺️',
      ),
    ];
  }
}
