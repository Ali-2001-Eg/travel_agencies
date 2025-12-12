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
    return [
      ServiceModel(
        id: 201,
        name: LocaleKeys.service_healthcare_name.tr(),
        description: LocaleKeys.service_healthcare_desc.tr(),
        icon: '🏥',
      ),
      ServiceModel(
        id: 202,
        name: LocaleKeys.service_spa_name.tr(),
        description: LocaleKeys.service_spa_desc.tr(),
        icon: '💆',
      ),
      ServiceModel(
        id: 203,
        name: LocaleKeys.service_doctor_name.tr(),
        description: LocaleKeys.service_doctor_desc.tr(),
        icon: '👨‍⚕️',
      ),
      ServiceModel(
        id: 204,
        name: LocaleKeys.service_transfer_name.tr(),
        description: LocaleKeys.service_transfer_desc.tr(),
        icon: '🚗',
      ),
      ServiceModel(
        id: 205,
        name: LocaleKeys.service_trainer_name.tr(),
        description: LocaleKeys.service_trainer_desc.tr(),
        icon: '💪',
      ),
      ServiceModel(
        id: 206,
        name: LocaleKeys.service_guide_name.tr(),
        description: LocaleKeys.service_guide_desc.tr(),
        icon: '🗺️',
      ),
    ];
  }
}
