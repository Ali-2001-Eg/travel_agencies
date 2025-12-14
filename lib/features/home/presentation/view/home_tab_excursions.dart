part of '../../home.dart';

class _ExcursionsTabView extends StatelessWidget {
  final HomeNavigationState state;

  const _ExcursionsTabView({required this.state});

  @override
  Widget build(BuildContext context) {
    final excursions = ExcursionModel.getMockData()
        .where((e) =>
            (state.selectedCategory == ExcursionCategory.all ||
                e.category == state.selectedCategory) &&
            (state.searchQuery.isEmpty ||
                e.name.toLowerCase().contains(state.searchQuery.toLowerCase())))
        .toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: ExcursionCategory.values.map((cat) {
                final isSelected = state.selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(_getCategoryLabel(cat)),
                    onSelected: (selected) {
                      context
                          .read<HomeNavigationBloc>()
                          .add(UpdateCategoryFilterEvent(cat));
                    },
                    selectedColor: const Color(0xFF14B8A6),
                    labelStyle: TextStyle(
                      fontSize: AppTextTheme.getResponsiveFontSize(20).sp,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.responsive(1, 2),
              childAspectRatio: context.responsive(1.3, 0.8),
              crossAxisSpacing: context.responsive(0.0, 16.0),
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final excursion = excursions[index];
                return ExcursionCard(
                  excursion: excursion,
                  isFavorite: state.favoriteIds.contains(excursion.id),
                  onToggleFavorite: () {
                    context
                        .read<HomeNavigationBloc>()
                        .add(ToggleFavoriteEvent(excursion.id));
                  },
                  onBook: () => _showBookingSheet(context, excursion, false),
                );
              },
              childCount: excursions.length,
            ),
          ),
        ),
      ],
    );
  }
}
