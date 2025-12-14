part of '../../home.dart';

class _QuickActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.8)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            Gaps.v(8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void _showBookingSheet(BuildContext context, dynamic item, bool isEvent) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    builder: (context) => BookingSheet(item: item, isEvent: isEvent),
  );
}

void _showServiceRequestSheet(BuildContext context, ServiceModel service) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    builder: (context) => ServiceRequestSheet(service: service),
  );
}

String _getCategoryLabel(ExcursionCategory category) {
  switch (category) {
    case ExcursionCategory.all:
      return LocaleKeys.all.tr();
    case ExcursionCategory.snorkeling:
      return LocaleKeys.snorkeling.tr();
    case ExcursionCategory.diving:
      return LocaleKeys.diving.tr();
    case ExcursionCategory.safari:
      return LocaleKeys.safari.tr();
    case ExcursionCategory.cultural:
      return LocaleKeys.cultural.tr();
    case ExcursionCategory.adventure:
      return LocaleKeys.adventure.tr();
  }
}
