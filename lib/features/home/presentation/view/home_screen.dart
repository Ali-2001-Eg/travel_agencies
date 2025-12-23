part of '../../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeNavigationBloc(),
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _homeBackgroundColor(context),
      body: SafeArea(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: HomeHeader(),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _HomeSearchField(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  isDarkMode: context.isDarkMode,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _HomeTabBar(),
                  ),
                ),
              ),
            ];
          },
          body: const _HomeTabBody(),
        ),
      ),
    );
  }
}

class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        context.read<HomeNavigationBloc>().add(UpdateSearchQueryEvent(query));
      },
      decoration: InputDecoration(
        hintText: LocaleKeys.search_placeholder.tr(),
        hintStyle: AppTextTheme.headlineMedium.copyWith(
          color: Colors.grey,
        ),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      style: AppTextTheme.headlineMedium.copyWith(
        color: context.isDarkMode ? Colors.white : Colors.black87,
      ),
    );
  }
}

class _HomeTabBar extends StatelessWidget {
  const _HomeTabBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
      // buildWhen: (previous, current) => previous.activeTab != current.activeTab,
      builder: (context, state) {
        return TabNavigationBar(
          activeTab: state.activeTab,
          onTabChanged: (tab) {
            context.read<HomeNavigationBloc>().add(ChangeTabEvent(tab));
          },
        );
      },
    );
  }
}

Color _homeBackgroundColor(BuildContext context) {
  return context.isDarkMode ? const Color(0xFF1A1A2E) : const Color(0xFFF5F7FA);
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final bool isDarkMode;

  _StickyTabBarDelegate({
    required this.child,
    required this.isDarkMode,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: _homeBackgroundColor(context),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  double get maxExtent => 76;

  @override
  double get minExtent => 76;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is! _StickyTabBarDelegate) return true;
    return oldDelegate.child != child || oldDelegate.isDarkMode != isDarkMode;
  }
}
