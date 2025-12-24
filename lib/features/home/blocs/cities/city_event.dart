part of 'city_bloc.dart';
abstract interface class CityEvent extends Equatable {
  const CityEvent();
}

class GetCitiesEvent extends CityEvent {
  const GetCitiesEvent();
  @override
  List<Object?> get props => [];
}

class SelectCityEvent extends CityEvent {
  final CityModel city;
  const SelectCityEvent({required this.city});
  @override
  List<Object?> get props => [city];
}
