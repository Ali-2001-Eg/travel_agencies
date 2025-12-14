part of '../../home.dart';

class _EventsTabView extends StatelessWidget {
  final HomeNavigationState state;

  const _EventsTabView({required this.state});

  @override
  Widget build(BuildContext context) {
    final events = EventModel.getMockData()
        .where((e) =>
            state.searchQuery.isEmpty ||
            e.name.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsive(1, 2),
        childAspectRatio: context.responsive(1.4, 0.8),
        crossAxisSpacing: context.responsive(0.0, 16.0),
        mainAxisSpacing: 16,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCardWidget(
          event: event,
          isFavorite: state.favoriteIds.contains(event.id),
          onToggleFavorite: () {
            context.read<HomeNavigationBloc>().add(ToggleFavoriteEvent(event.id));
          },
          onBook: () => _showBookingSheet(context, event, true),
        );
      },
    );
  }
}
