part of '../../home.dart';

class ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color buttonColor;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Service icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: buttonColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),

          Gaps.v16(),

          // Service title
          LocalizedLabel(
            text: title == 'Healthcare'
                ? LocaleKeys.healthcare
                : LocaleKeys.spa_massage,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),

          Gaps.v8(),

          // Service subtitle
          LocalizedLabel(
            text: title == 'Healthcare'
                ? LocaleKeys.medical_support
                : LocaleKeys.relaxation_services,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),

          Gaps.v20(),

          // Request service button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Request service logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: LocalizedLabel(
                text: LocaleKeys.request_service,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
