part of '../../home.dart';

class _FavoritesTabView extends StatelessWidget {
  final HomeNavigationState state;

  const _FavoritesTabView({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.favoriteIds.isEmpty) {
      return const _EmptyFavoritesView();
    }

    final excursions = ExcursionModel.getMockData()
        .where((e) => state.favoriteIds.contains(e.id))
        .toList();
    final events = EventModel.getMockData()
        .where((e) => state.favoriteIds.contains(e.id))
        .toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (excursions.isNotEmpty) ...[
                LocalizedLabel(
                  text: LocaleKeys.favorite_excursions,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                Gaps.v(16),
              ],
            ]),
          ),
        ),
        if (excursions.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.responsive(1, 2),
                childAspectRatio: context.responsive(1.3, 1.5),
                crossAxisSpacing: context.responsive(0.0, 16.0),
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final excursion = excursions[index];
                  return ExcursionCard(
                    excursion: excursion,
                    isFavorite: true,
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
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (excursions.isNotEmpty) Gaps.v(24),
              if (events.isNotEmpty) ...[
                LocalizedLabel(
                  text: LocaleKeys.favorite_events,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                Gaps.v(16),
              ],
            ]),
          ),
        ),
        if (events.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.responsive(1, 2),
                childAspectRatio: context.responsive(1.4, 1.6),
                crossAxisSpacing: context.responsive(0.0, 16.0),
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final event = events[index];
                  return EventCardWidget(
                    event: event,
                    isFavorite: true,
                    onToggleFavorite: () {
                      context
                          .read<HomeNavigationBloc>()
                          .add(ToggleFavoriteEvent(event.id));
                    },
                    onBook: () => _showBookingSheet(context, event, true),
                  );
                },
                childCount: events.length,
              ),
            ),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: context.isDarkMode ? Colors.white24 : Colors.black12,
          ),
          Gaps.v(16),
          LocalizedLabel(
            text: LocaleKeys.no_favorites_yet,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.isDarkMode ? Colors.white60 : Colors.black45,
            ),
          ),
          Gaps.v(8),
          LocalizedLabel(
            text: LocaleKeys.start_adding_favorites,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white38 : Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
