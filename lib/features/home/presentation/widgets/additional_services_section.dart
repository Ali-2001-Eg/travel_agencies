part of '../../home.dart';

class AdditionalServicesSection extends StatelessWidget {
  const AdditionalServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            LocalizedLabel(
              text: LocaleKeys.additional_services,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            const Text('🏥', style: TextStyle(fontSize: 20)),
          ],
        ),

        Gaps.v18(),

        // Service cards
        const ServiceCard(
          icon: '🏥',
          title: 'Healthcare',
          subtitle: '24/7 Medical Support',
          buttonText: 'Request Service',
          buttonColor: Color(0xFF00BFA5),
        ),

        Gaps.v16(),

        const ServiceCard(
          icon: '🧘‍♀️',
          title: 'Spa & Massage',
          subtitle: 'Relaxation Services',
          buttonText: 'Request Service',
          buttonColor: Color(0xFF00BFA5),
        ),
      ],
    );
  }
}
