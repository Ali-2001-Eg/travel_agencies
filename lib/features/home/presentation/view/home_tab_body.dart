part of '../../home.dart';

class _HomeTabBody extends StatelessWidget {
  const _HomeTabBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
      builder: (context, state) {
        switch (state.activeTab) {
          case HomeTab.home:
            return _HomeTabView(state: state);
          case HomeTab.excursions:
            return _ExcursionsTabView(state: state);
          case HomeTab.events:
            return _EventsTabView(state: state);
          case HomeTab.services:
            return const _ServicesTabView();
          case HomeTab.bookings:
            return const BookingsScreen();
          case HomeTab.favorites:
            return _FavoritesTabView(state: state);
        }
      },
    );
  }
}
