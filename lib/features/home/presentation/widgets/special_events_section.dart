part of '../../home.dart';

class SpecialEventsSection extends StatelessWidget {
  const SpecialEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
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

        // Event cards
        const EventCard(
          title: 'Christmas Beach Party',
          date: 'December 25, 2025',
          location: 'Sharm El Sheikh',
          imageGradient: [Color(0xFF8B0000), Color(0xFFDC143C)],
        ),

        Gaps.v16(),

        const EventCard(
          title: 'New Year Gala Dinner',
          date: 'December 31, 2025',
          location: 'Hurghada',
          imageGradient: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
        ),
      ],
    );
  }
}
