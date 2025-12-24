import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  HomeNavigationBloc() : super(const HomeNavigationState()) {
    on<ChangeTabEvent>(_onChangeTab);
    on<UpdateSearchQueryEvent>(_onUpdateSearchQuery);
    on<UpdateCategoryFilterEvent>(_onUpdateCategoryFilter);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<HomeNavigationState> emit) {
    emit(state.copyWith(activeTab: event.tab));
  }

  void _onUpdateSearchQuery(
      UpdateSearchQueryEvent event, Emitter<HomeNavigationState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onUpdateCategoryFilter(
      UpdateCategoryFilterEvent event, Emitter<HomeNavigationState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<HomeNavigationState> emit) {
    final favorites = List<int>.from(state.favoriteIds);
    if (favorites.contains(event.itemId)) {
      favorites.remove(event.itemId);
    } else {
      favorites.add(event.itemId);
    }
    emit(state.copyWith(favoriteIds: favorites));
  }
}
