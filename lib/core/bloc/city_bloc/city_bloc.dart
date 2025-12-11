part of '../blocs.dart';

class CityBloc extends EnumBloc<EgyptianCity> {
  CityBloc()
      : super(
          EgyptianCity.values,
          initial: EgyptianCity.luxor,
        );

  void changeCity(EgyptianCity city) {
    add(SelectEnumValue(city));
  }
}
