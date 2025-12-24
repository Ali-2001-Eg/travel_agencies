import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'real_estate_state_event.dart';

class RealEstateBloc extends Bloc<RealEstateEvent, RealEstateState> {
  RealEstateBloc() : super(const RealEstateState()) {
    on<ChangeRealEstateCategoryEvent>(_onChangeCategory);
  }

  void _onChangeCategory(
      ChangeRealEstateCategoryEvent event, Emitter<RealEstateState> emit) {
    emit(state.copyWith(activeCategory: event.category));
  }
}
