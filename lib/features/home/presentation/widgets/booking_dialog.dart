part of '../../home.dart';

class BookingSheet extends StatelessWidget {
  final dynamic item; // Can be ExcursionModel or EventModel
  final bool isEvent;

  const BookingSheet({
    super.key,
    required this.item,
    this.isEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingDialogCubit()..openDialog(),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with image
            SizedBox(
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: isEvent
                          ? (item as EventModel).imageUrl
                          : (item as ExcursionModel).imageUrl,
                      width: double.infinity,
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
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Drag handle
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  // Close button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child:  Icon(Icons.close, size: 20,color: HexColor.primaryColor,),
                      ),
                    ),
                  ),
                  // Title and location
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isEvent
                              ? (item as EventModel).name
                              : (item as ExcursionModel).name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              isEvent
                                  ? (item as EventModel).location
                                  : (item as ExcursionModel).location,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Form content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<BookingDialogCubit, BookingDialogState>(
                  builder: (context, state) {
                    final cubit = context.read<BookingDialogCubit>();
                    final price = isEvent
                        ? (item as EventModel).price
                        : (item as ExcursionModel).price;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Date picker
                        LocalizedLabel(
                          text: LocaleKeys.select_date,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        Gaps.v(8),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              cubit.updateDate(date);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: context.isDarkMode
                                      ? Colors.white60
                                      : Colors.black45,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  state.selectedDate != null
                                      ? DateFormat('MMM dd, yyyy')
                                          .format(state.selectedDate!)
                                      : LocaleKeys.select_date.tr(),
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gaps.v(16),

                        // Time picker (for excursions)
                        if (!isEvent) ...[
                          LocalizedLabel(
                            text: LocaleKeys.preferred_time,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                          Gaps.v(8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<String>(
                              value: state.selectedTime,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: context.isDarkMode
                                    ? Colors.white60
                                    : Colors.black45,
                              ),
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                              dropdownColor: context.isDarkMode
                                  ? const Color(0xFF2A2A3E)
                                  : Colors.white,
                              items: ['09:00', '12:00', '15:00', '18:00']
                                  .map((time) => DropdownMenuItem(
                                        value: time,
                                        child: Text(time),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) cubit.updateTime(value);
                              },
                            ),
                          ),
                          Gaps.v(16),
                        ],

                        // Number of people
                        LocalizedLabel(
                          text: LocaleKeys.number_of_people,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        Gaps.v(8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '1',
                            prefixIcon: Icon(
                              Icons.people,
                              color: context.isDarkMode
                                  ? Colors.white60
                                  : Colors.black45,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                          onChanged: (value) {
                            final count = int.tryParse(value) ?? 1;
                            cubit.updateNumberOfPeople(count);
                          },
                        ),
                        Gaps.v(16),

                        // Additional notes
                        LocalizedLabel(
                          text: LocaleKeys.additional_notes,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        Gaps.v(8),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText:
                                LocaleKeys.additional_notes_placeholder.tr(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                          onChanged: cubit.updateNotes,
                        ),
                        Gaps.v(16),

                        // Price summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? const Color(0xFF2A2A3E)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(0)} × ${state.numberOfPeople} ${state.numberOfPeople == 1 ? LocaleKeys.person.tr() : LocaleKeys.people.tr()}',
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    '\$${(price * state.numberOfPeople).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LocalizedLabel(
                                    text: LocaleKeys.service_fee,
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    '\$${((price * state.numberOfPeople) * 0.1).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LocalizedLabel(
                                    text: LocaleKeys.total,
                                    style:
                                        context.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '\$${state.calculateTotal(price).toStringAsFixed(2)}',
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gaps.v(20),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(
                                    color: context.isDarkMode
                                        ? Colors.white24
                                        : Colors.black12,
                                  ),
                                ),
                                child: LocalizedLabel(
                                  text: LocaleKeys.cancel,
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,

                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: state.selectedDate != null
                                    ? () {
                                        context.showSuccessMessage(
                                          LocaleKeys.booking_confirmed,
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF14B8A6),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey[400],
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.credit_card, size: 20),
                                    const SizedBox(width: 8),
                                    LocalizedLabel(
                                      text: LocaleKeys.confirm_booking,
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Safe area at bottom for home indicator
                        SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom + 20),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
