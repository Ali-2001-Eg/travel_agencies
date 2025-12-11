part of '../../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? const Color(0xFF1A1A2E)
          : const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with app logo and controls
            SafeArea(child: const HomeHeader()),

            Gaps.v(24),

            // Main title and subtitle
            LocalizedLabel(
              text: LocaleKeys.discover_egypt,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),

            Gaps.v(8),

            LocalizedLabel(
              text: LocaleKeys.book_amazing_activities,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),

            Gaps.v(24),

            // Search section
            const HomeSearchSection(),

            Gaps.v(32),

            // Popular Activities
            const PopularActivitiesSection(),

            Gaps.v(32),

            // Special Events
            const SpecialEventsSection(),

            Gaps.v(32),

            // Additional Services
            const AdditionalServicesSection(),

            Gaps.v(24),
          ],
        ),
      ),
    );
  }
}
