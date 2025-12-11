part of '../../home.dart';

class PopularActivitiesSection extends StatelessWidget {
  const PopularActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final excursions = ExcursionModel.getMockData();

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

        // Activity card - using first excursion from mock data
        if (excursions.isNotEmpty)
          ExcursionCard(
            excursion: excursions[0],
            isFavorite: false,
            onToggleFavorite: () {},
            onBook: () {},
          ),
      ],
    );
  }
}
