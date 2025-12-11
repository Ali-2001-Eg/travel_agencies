part of '../../home.dart';

class AdditionalServicesSection extends StatelessWidget {
  const AdditionalServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ServiceModel.getMockData();

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

        // Service cards - using first two services from mock data
        if (services.isNotEmpty)
          ServiceCardWidget(
            service: services[0],
            onRequest: () {},
          ),

        if (services.length > 1) ...[
          Gaps.v16(),
          ServiceCardWidget(
            service: services[1],
            onRequest: () {},
          ),
        ],
      ],
    );
  }
}
