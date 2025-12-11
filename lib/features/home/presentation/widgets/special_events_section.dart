part of '../../home.dart';

class SpecialEventsSection extends StatelessWidget {
  const SpecialEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final events = EventModel.getMockData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            LocalizedLabel(
              text: LocaleKeys.special_events,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            const Text('🎉', style: TextStyle(fontSize: 20)),
          ],
        ),

        Gaps.v18(),

        // Event cards - using first two events from mock data
        if (events.isNotEmpty)
          EventCardWidget(
            event: events[0],
            isFavorite: false,
            onToggleFavorite: () {},
            onBook: () {},
          ),

        if (events.length > 1) ...[
          Gaps.v16(),
          EventCardWidget(
            event: events[1],
            isFavorite: false,
            onToggleFavorite: () {},
            onBook: () {},
          ),
        ],
      ],
    );
  }
}
