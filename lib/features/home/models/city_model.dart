part of '../home.dart';

class CityModel extends Equatable {
  final String name;
  final int id;
  const CityModel({required this.name, required this.id});
  @override
  List<Object?> get props => [name, id];
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(name: json['name'] ?? "", id: json['id'] ?? 0);
  }
}
