part of 'home_navigation_bloc.dart';

abstract class HomeNavigationEvent extends Equatable {
  const HomeNavigationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTabEvent extends HomeNavigationEvent {
  final HomeTab tab;

  const ChangeTabEvent(this.tab);

  @override
  List<Object?> get props => [tab];
}

class UpdateSearchQueryEvent extends HomeNavigationEvent {
  final String query;

  const UpdateSearchQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateCategoryFilterEvent extends HomeNavigationEvent {
  final ExcursionCategory category;

  const UpdateCategoryFilterEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class ToggleFavoriteEvent extends HomeNavigationEvent {
  final int itemId;

  const ToggleFavoriteEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
