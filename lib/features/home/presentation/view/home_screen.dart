part of '../../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigationBloc(),
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? const Color(0xFF1A1A2E)
            : const Color(0xFFF5F7FA),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: const HomeHeader(),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
                  builder: (context, state) {
                    return TextField(
                      onChanged: (query) {
                        context
                            .read<HomeNavigationBloc>()
                            .add(UpdateSearchQueryEvent(query));
                      },
                      decoration: InputDecoration(
                        hintText: LocaleKeys.search_placeholder.tr(),
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: context.isDarkMode
                            ? const Color(0xFF2A2A3E)
                            : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      style: TextStyle(
                        color:
                            context.isDarkMode ? Colors.white : Colors.black87,
                      ),
                    );
                  },
                ),
              ),

              Gaps.v(16),

              // Tab Navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
                  builder: (context, state) {
                    return TabNavigationBar(
                      activeTab: state.activeTab,
                      onTabChanged: (tab) {
                        context
                            .read<HomeNavigationBloc>()
                            .add(ChangeTabEvent(tab));
                      },
                    );
                  },
                ),
              ),

              Gaps.v(16),

              // Tab Content
              Expanded(
                child: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
                  builder: (context, state) {
                    return _buildTabContent(context, state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, HomeNavigationState state) {
    switch (state.activeTab) {
      case HomeTab.home:
        return _buildHomeTab(context, state);
      case HomeTab.excursions:
        return _buildExcursionsTab(context, state);
      case HomeTab.events:
        return _buildEventsTab(context, state);
      case HomeTab.services:
        return _buildServicesTab(context, state);
      case HomeTab.favorites:
        return _buildFavoritesTab(context, state);
    }
  }

  Widget _buildHomeTab(BuildContext context, HomeNavigationState state) {
    final excursions = ExcursionModel.getMockData();
    final services = ServiceModel.getMockData();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  context,
                  LocaleKeys.excursions.tr(),
                  Icons.explore,
                  const Color(0xFF14B8A6),
                  () => context
                      .read<HomeNavigationBloc>()
                      .add(const ChangeTabEvent(HomeTab.excursions)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  context,
                  LocaleKeys.events.tr(),
                  Icons.event,
                  const Color(0xFFF97316),
                  () => context
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
                child: _buildQuickAction(
                  context,
                  LocaleKeys.services.tr(),
                  Icons.room_service,
                  const Color(0xFFA855F7),
                  () => context
                      .read<HomeNavigationBloc>()
                      .add(const ChangeTabEvent(HomeTab.services)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  context,
                  LocaleKeys.scan_qr_code.tr(),
                  Icons.qr_code_scanner,
                  const Color(0xFFEC4899),
                  () {
                    // Show QR scanner dialog
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
                            LocalizedLabel(
                                text: LocaleKeys.scan_qr_description),
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

          // Trending Excursions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocalizedLabel(
                text: LocaleKeys.trending_excursions,
                style: context.textTheme.titleLarge?.copyWith(
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
                  style: const TextStyle(color: Color(0xFF14B8A6)),
                ),
              ),
            ],
          ),
          Gaps.v(16),
          SizedBox(
            height: 380,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                final excursion = excursions[index];
                return Container(
                  width: 300,
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

          // Quick Services
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
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
      ),
    );
  }

  Widget _buildExcursionsTab(BuildContext context, HomeNavigationState state) {
    final excursions = ExcursionModel.getMockData()
        .where((e) =>
            (state.selectedCategory == ExcursionCategory.all ||
                e.category == state.selectedCategory) &&
            (state.searchQuery.isEmpty ||
                e.name.toLowerCase().contains(state.searchQuery.toLowerCase())))
        .toList();

    return Column(
      children: [
        // Category filters
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: ExcursionCategory.values.map((cat) {
              final isSelected = state.selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  selected: isSelected,
                  label: Text(_getCategoryLabel(cat)),
                  onSelected: (selected) {
                    context
                        .read<HomeNavigationBloc>()
                        .add(UpdateCategoryFilterEvent(cat));
                  },
                  selectedColor: const Color(0xFF14B8A6),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Gaps.v(16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.3,
              mainAxisSpacing: 16,
            ),
            itemCount: excursions.length,
            itemBuilder: (context, index) {
              final excursion = excursions[index];
              return ExcursionCard(
                excursion: excursion,
                isFavorite: state.favoriteIds.contains(excursion.id),
                onToggleFavorite: () {
                  context
                      .read<HomeNavigationBloc>()
                      .add(ToggleFavoriteEvent(excursion.id));
                },
                onBook: () => _showBookingSheet(context, excursion, false),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventsTab(BuildContext context, HomeNavigationState state) {
    final events = EventModel.getMockData()
        .where((e) =>
            state.searchQuery.isEmpty ||
            e.name.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.4,
        mainAxisSpacing: 16,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCardWidget(
          event: event,
          isFavorite: state.favoriteIds.contains(event.id),
          onToggleFavorite: () {
            context
                .read<HomeNavigationBloc>()
                .add(ToggleFavoriteEvent(event.id));
          },
          onBook: () => _showBookingSheet(context, event, true),
        );
      },
    );
  }

  Widget _buildServicesTab(BuildContext context, HomeNavigationState state) {
    final services = ServiceModel.getMockData();

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCardWidget(
          service: service,
          onRequest: () => _showServiceRequestSheet(context, service),
        );
      },
    );
  }

  Widget _buildFavoritesTab(BuildContext context, HomeNavigationState state) {
    if (state.favoriteIds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: context.isDarkMode ? Colors.white24 : Colors.black12,
            ),
            Gaps.v(16),
            LocalizedLabel(
              text: LocaleKeys.no_favorites_yet,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.isDarkMode ? Colors.white60 : Colors.black45,
              ),
            ),
            Gaps.v(8),
            LocalizedLabel(
              text: LocaleKeys.start_adding_favorites,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.isDarkMode ? Colors.white38 : Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final excursions = ExcursionModel.getMockData()
        .where((e) => state.favoriteIds.contains(e.id))
        .toList();
    final events = EventModel.getMockData()
        .where((e) => state.favoriteIds.contains(e.id))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (excursions.isNotEmpty) ...[
            LocalizedLabel(
              text: LocaleKeys.favorite_excursions,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Gaps.v(16),
            ...excursions.map((excursion) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ExcursionCard(
                    excursion: excursion,
                    isFavorite: true,
                    onToggleFavorite: () {
                      context
                          .read<HomeNavigationBloc>()
                          .add(ToggleFavoriteEvent(excursion.id));
                    },
                    onBook: () => _showBookingSheet(context, excursion, false),
                  ),
                )),
            Gaps.v(24),
          ],
          if (events.isNotEmpty) ...[
            LocalizedLabel(
              text: LocaleKeys.favorite_events,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Gaps.v(16),
            ...events.map((event) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: EventCardWidget(
                    event: event,
                    isFavorite: true,
                    onToggleFavorite: () {
                      context
                          .read<HomeNavigationBloc>()
                          .add(ToggleFavoriteEvent(event.id));
                    },
                    onBook: () => _showBookingSheet(context, event, true),
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
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
}
