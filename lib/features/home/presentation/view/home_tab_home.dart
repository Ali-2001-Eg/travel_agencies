part of '../../home.dart';

class _HomeTabView extends StatelessWidget {
  final HomeNavigationState state;

  const _HomeTabView({required this.state});

  @override
  Widget build(BuildContext context) {
    final excursions = ExcursionModel.getMockData();
    final services = ServiceModel.getMockData();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.excursions.tr(),
                icon: Icons.explore,
                color: const Color(0xFF14B8A6),
                onTap: () => context
                    .read<HomeNavigationBloc>()
                    .add(const ChangeTabEvent(HomeTab.excursions)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.events.tr(),
                icon: Icons.event,
                color: const Color(0xFFF97316),
                onTap: () => context
                    .read<HomeNavigationBloc>()
                    .add(const ChangeTabEvent(HomeTab.events)),
              ),
            ),
          ],
        ),
        Gaps.v(12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.offers.tr(),
                icon: Icons.local_offer,
                color: const Color(0xFFEF4444), // Red
                onTap: () => context
                    .read<HomeNavigationBloc>()
                    .add(const ChangeTabEvent(HomeTab.offers)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.my_bookings.tr(),
                icon: Icons.notifications_active, // Icon from tab bar
                color: const Color(0xFF3B82F6), // Blue
                onTap: () => context
                    .read<HomeNavigationBloc>()
                    .add(const ChangeTabEvent(HomeTab.bookings)),
              ),
            ),
          ],
        ),
        Gaps.v(12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.services.tr(),
                icon: Icons.room_service,
                color: const Color(0xFFA855F7),
                onTap: () => context
                    .read<HomeNavigationBloc>()
                    .add(const ChangeTabEvent(HomeTab.services)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                label: LocaleKeys.scan_qr_code.tr(),
                icon: Icons.qr_code_scanner,
                color: const Color(0xFFEC4899),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: LocalizedLabel(
                          text: LocaleKeys.connect_with_representative),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.qr_code_scanner, size: 80),
                          Gaps.v(16),
                          LocalizedLabel(text: LocaleKeys.scan_qr_description),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: LocalizedLabel(text: LocaleKeys.close),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Gaps.v(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LocalizedLabel(
              text: LocaleKeys.trending_excursions,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () => context
                  .read<HomeNavigationBloc>()
                  .add(const ChangeTabEvent(HomeTab.excursions)),
              child: LocalizedLabel(
                text: LocaleKeys.view_all,
                style: AppTextTheme.bodyMedium
                    .copyWith(color: const Color(0xFF14B8A6)),
              ),
            ),
          ],
        ),
        Gaps.v(16),
        SizedBox(
          height: 380,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final excursion = excursions[index];
              return Container(
                width: context.responsive(300.0, 350.0),
                margin: const EdgeInsets.only(right: 16),
                child: ExcursionCard(
                  excursion: excursion,
                  isFavorite: state.favoriteIds.contains(excursion.id),
                  onToggleFavorite: () {
                    context
                        .read<HomeNavigationBloc>()
                        .add(ToggleFavoriteEvent(excursion.id));
                  },
                  onBook: () => _showBookingSheet(context, excursion, false),
                ),
              );
            },
          ),
        ),
        Gaps.v(24),
        LocalizedLabel(
          text: LocaleKeys.quick_services,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        Gaps.v(16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.responsive(3, 4),
            childAspectRatio: context.responsive(0.9, 1.1),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ServiceCardWidget(
              service: service,
              onRequest: () => _showServiceRequestSheet(context, service),
            );
          },
        ),
        Gaps.v(24),
      ],
    );
  }
}
