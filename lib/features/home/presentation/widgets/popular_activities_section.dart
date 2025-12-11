part of '../../home.dart';

class PopularActivitiesSection extends StatelessWidget {
  const PopularActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            LocalizedLabel(
              text: LocaleKeys.popular_activities,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            const Text('⭐', style: TextStyle(fontSize: 20)),
          ],
        ),

        Gaps.v18(),

        // Activity card
        const ActivityCard(
          imageUrl:
              'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?w=400',
          title: 'Luxor Temple Tour',
          location: 'Luxor',
          duration: '8 hours',
          price: 55,
          rating: 5,
          category: 'Cultural',
        ),
      ],
    );
  }
}
