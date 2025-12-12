part of '../../home.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) {
        if (state is BookingsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF14B8A6),
            ),
          );
        }

        if (state is BookingsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: context.isDarkMode ? Colors.white60 : Colors.black45,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          );
        }

        final upcomingBookings =
            state is BookingsLoaded ? state.upcomingBookings : <BookingModel>[];

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LocalizedLabel(
                              text: LocaleKeys.my_bookings,
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${upcomingBookings.length} ${LocaleKeys.upcoming_bookings.tr().toLowerCase()}',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.isDarkMode
                                    ? Colors.white60
                                    : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        if (upcomingBookings.isNotEmpty)
                          BookingReminderBadge(
                            count: upcomingBookings.length,
                            onTap: () {},
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bookings List
            if (upcomingBookings.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 80,
                        color: context.isDarkMode
                            ? Colors.white24
                            : Colors.black87,
                      ),
                      const SizedBox(height: 16),
                      LocalizedLabel(
                        text: LocaleKeys.no_upcoming_bookings,
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.isDarkMode
                              ? Colors.white38
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final booking = upcomingBookings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UpcomingBookingsCard(
                          booking: booking,
                          onCancel: () {
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                backgroundColor: context.isDarkMode
                                    ? const Color(0xFF2A2A3E)
                                    : Colors.white,
                                title: LocalizedLabel(
                                  text: LocaleKeys.cancel_booking,
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                content: Text(
                                  'Are you sure you want to cancel this booking?',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: LocalizedLabel(
                                      text: LocaleKeys.cancel,
                                      style: TextStyle(
                                        color: context.isDarkMode
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<BookingsBloc>().add(
                                            DeleteBookingEvent(booking.id),
                                          );
                                      Navigator.pop(dialogContext);
                                      context.showSuccessMessage(
                                        LocaleKeys.booking_cancelled,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFEF4444),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: LocalizedLabel(
                                      text: LocaleKeys.confirm,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: upcomingBookings.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
