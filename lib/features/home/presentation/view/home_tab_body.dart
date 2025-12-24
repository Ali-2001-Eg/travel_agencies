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
          case HomeTab.realEstate:
            return const RealEstateTabView();
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
          case HomeTab.offers:
            return const _OffersTabView();
        }
      },
    );
  }
}
