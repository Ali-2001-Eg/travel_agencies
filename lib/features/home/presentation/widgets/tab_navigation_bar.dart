part of '../../home.dart';

class TabNavigationBar extends StatelessWidget {
  final HomeTab activeTab;
  final Function(HomeTab) onTabChanged;

  const TabNavigationBar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: context.isDarkMode ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTabButton(
            context,
            HomeTab.home,
            Icons.home,
            LocaleKeys.home,
          ),
          _buildTabButton(
            context,
            HomeTab.excursions,
            Icons.explore,
            LocaleKeys.excursions,
          ),
          _buildTabButton(
            context,
            HomeTab.events,
            Icons.event,
            LocaleKeys.events,
          ),
          _buildTabButton(
            context,
            HomeTab.services,
            Icons.room_service,
            LocaleKeys.services,
          ),
          _buildTabButton(
            context,
            HomeTab.favorites,
            Icons.favorite,
            LocaleKeys.favorites,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    HomeTab tab,
    IconData icon,
    String labelKey,
  ) {
    final isActive = activeTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive
                    ? Colors.white
                    : (context.isDarkMode ? Colors.white60 : Colors.black54),
              ),
              const SizedBox(height: 4),
              LocalizedLabel(
                text: labelKey,
                style: TextStyle(
                  fontSize: 11,
                  color: isActive
                      ? Colors.white
                      : (context.isDarkMode ? Colors.white60 : Colors.black54),
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
