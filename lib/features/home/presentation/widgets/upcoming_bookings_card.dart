part of '../../home.dart';

class UpcomingBookingsCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onCancel;

  const UpcomingBookingsCard({
    super.key,
    required this.booking,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final daysUntil = booking.daysUntil;
    final isToday = daysUntil == 0;
    final isTomorrow = daysUntil == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: context.isDarkMode ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image header with countdown
          SizedBox(
            height: 140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: booking.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Countdown badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isToday
                            ? [const Color(0xFFEF4444), const Color(0xFFDC2626)]
                            : isTomorrow
                                ? [
                                    const Color(0xFFF97316),
                                    const Color(0xFFEA580C)
                                  ]
                                : [
                                    const Color(0xFF14B8A6),
                                    const Color(0xFF0D9488)
                                  ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (isToday
                                  ? const Color(0xFFEF4444)
                                  : isTomorrow
                                      ? const Color(0xFFF97316)
                                      : const Color(0xFF14B8A6))
                              .withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.schedule,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          isToday
                              ? LocaleKeys.today.tr()
                              : isTomorrow
                                  ? LocaleKeys.tomorrow.tr()
                                  : '$daysUntil ${LocaleKeys.days_until.tr()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Activity name
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    booking.itemName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Details section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color:
                          context.isDarkMode ? Colors.white60 : Colors.black45,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking.location,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.isDarkMode
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Date and time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color:
                          context.isDarkMode ? Colors.white60 : Colors.black45,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(booking.selectedDate),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.isDarkMode
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color:
                          context.isDarkMode ? Colors.white60 : Colors.black45,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking.selectedTime,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.isDarkMode
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Number of people
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color:
                          context.isDarkMode ? Colors.white60 : Colors.black45,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${booking.numberOfPeople} ${booking.numberOfPeople == 1 ? LocaleKeys.person.tr() : LocaleKeys.people.tr()}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.isDarkMode
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
                if (booking.additionalNotes.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notes,
                        size: 16,
                        color: context.isDarkMode
                            ? Colors.white60
                            : Colors.black45,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          booking.additionalNotes,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white60
                                : Colors.black45,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const Divider(height: 24),
                // Actions row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.total.tr(),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white60
                                : Colors.black45,
                          ),
                        ),
                        Text(
                          '\$${booking.totalPrice.toStringAsFixed(2)}',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // Cancel button
                    TextButton.icon(
                      onPressed: onCancel,
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 18,
                      ),
                      label: LocalizedLabel(
                        text: LocaleKeys.cancel_booking,
                        style: const TextStyle(fontSize: 14),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
