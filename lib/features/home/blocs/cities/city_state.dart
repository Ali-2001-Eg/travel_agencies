part of 'city_bloc.dart';

class CitySate extends BaseState<CityModel> {
  final CityModel? selectedCity;
  const CitySate(
      {this.selectedCity,
      super.status,
      super.errorMessage,
      super.failure,
      super.data,
      super.items,
      super.metadata});

  @override
  List<Object?> get props =>
      [selectedCity, status, errorMessage, failure, data, items, metadata];
  @override
  CitySate copyWith({
    CityModel? selectedCity,
    Status? status,
    String? errorMessage,
    Failure? failure,
    CityModel? data,
    List<CityModel>? items,
    Map<String, dynamic>? metadata,
  }) {
    return CitySate(
      selectedCity: selectedCity ?? this.selectedCity,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      failure: failure ?? this.failure,
      data: data ?? this.data,
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
    );
  }
}
