part of 'real_estate_bloc.dart';

enum RealEstateCategory { shaleeh, studio, department, villa }

extension RealEstateCategoryExtension on RealEstateCategory {
  String get localizedName {
    switch (this) {
      case RealEstateCategory.shaleeh:
        return "shaleeh".tr();
      case RealEstateCategory.studio:
        return "studio".tr();
      case RealEstateCategory.department:
        return "department".tr();
      case RealEstateCategory.villa:
        return "villa".tr();
    }
  }
}

abstract class RealEstateEvent extends Equatable {
  const RealEstateEvent();

  @override
  List<Object?> get props => [];
}

class ChangeRealEstateCategoryEvent extends RealEstateEvent {
  final RealEstateCategory category;

  const ChangeRealEstateCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class RealEstateState extends Equatable {
  final RealEstateCategory activeCategory;
  final bool isLoading;

  const RealEstateState({
    this.activeCategory = RealEstateCategory.shaleeh,
    this.isLoading = false,
  });

  RealEstateState copyWith({
    RealEstateCategory? activeCategory,
    bool? isLoading,
  }) {
    return RealEstateState(
      activeCategory: activeCategory ?? this.activeCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [activeCategory, isLoading];
}
