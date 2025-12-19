part of 'home_navigation_bloc.dart';

enum HomeTab { home, excursions, events, services, bookings, favorites, offers }

enum ExcursionCategory { all, snorkeling, diving, safari, cultural, adventure }

class HomeNavigationState extends Equatable {
  final HomeTab activeTab;
  final String searchQuery;
  final ExcursionCategory selectedCategory;
  final List<int> favoriteIds;

  const HomeNavigationState({
    this.activeTab = HomeTab.home,
    this.searchQuery = '',
    this.selectedCategory = ExcursionCategory.all,
    this.favoriteIds = const [],
  });

  HomeNavigationState copyWith({
    HomeTab? activeTab,
    String? searchQuery,
    ExcursionCategory? selectedCategory,
    List<int>? favoriteIds,
  }) {
    return HomeNavigationState(
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props =>
      [activeTab, searchQuery, selectedCategory, favoriteIds];
}
