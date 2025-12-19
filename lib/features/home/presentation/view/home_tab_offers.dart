part of '../../home.dart';

class _OffersTabView extends StatelessWidget {
  const _OffersTabView();

  @override
  Widget build(BuildContext context) {
    // Mocking offers as per user request: "2 excursions with discount"
    final offers = [
      ExcursionModel(
        id: 101,
        name: "Special Safari Offer",
        description: "Get 20% off on this amazing Safari adventure!",
        imageUrl:
            "https://images.unsplash.com/photo-1516426122078-c23e76319801?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
        price: 120.0, // Discounted price
        rating: 4.8,
        location: "Desert",
        duration: "5 hours",
        category: ExcursionCategory.safari,
      ),
      ExcursionModel(
        id: 102,
        name: "Diving Package Deal",
        description: "Book 2 dives and get a free underwater photo session!",
        imageUrl:
            "https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
        price: 250.0,
        rating: 4.9,
        location: "Red Sea",
        duration: "1 day",
        category: ExcursionCategory.diving,
      ),
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: offers.length,
      separatorBuilder: (context, index) => Gaps.v(16),
      itemBuilder: (context, index) {
        final offer = offers[index];
        return ExcursionCard(
          excursion: offer,
          isFavorite: false, // Defaulting to false for offers
          onToggleFavorite: () {
            // Logic to toggle favorite if needed
          },
          onBook: () => _showBookingSheet(context, offer, false),
        );
      },
    );
  }
}
