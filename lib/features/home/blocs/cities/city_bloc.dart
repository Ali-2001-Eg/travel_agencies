import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agencies/core/bloc/blocs.dart';
import 'package:travel_agencies/features/home/home.dart';

import '../../../../core/enum/status.dart';
import '../../../../core/http/failure.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CitySate> {
  final CityDataSource _cityDataSource;
  CityBloc(this._cityDataSource) : super(const CitySate()) {
    on<GetCitiesEvent>(onCityEvent);
    on<SelectCityEvent>(onSelectCityEvent);
  }
  void onCityEvent(CityEvent event, Emitter<CitySate> emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _cityDataSource.getCities();
    result.fold(
        (failure) => emit(state.copyWith(
            status: Status.failure,
            failure: failure,
            errorMessage: failure.message)),
        (data) => emit(state.copyWith(status: Status.success, items: data)));
  }

  void onSelectCityEvent(SelectCityEvent event, Emitter<CitySate> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }
}
