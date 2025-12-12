part of '../../home.dart';

class ServiceRequestSheet extends StatelessWidget {
  final ServiceModel service;

  const ServiceRequestSheet({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceRequestCubit()..openDialog(),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient and details
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFA855F7), Color(0xFF9333EA)],
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        service.icon,
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              service.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40), // Space for close button
                    ],
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
                        color: Colors.white.withValues(alpha: 0.5),
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
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),

            // Form content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
                  builder: (context, state) {
                    final cubit = context.read<ServiceRequestCubit>();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Date picker
                        LocalizedLabel(
                          text: LocaleKeys.preferred_date,
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
                                  DateTime.now().add(const Duration(days: 90)),
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

                        // Time picker
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
                            value: state.selectedTime.isEmpty
                                ? null
                                : state.selectedTime,
                            hint: Text(LocaleKeys.select_time.tr()),
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
                            items: [
                              '08:00',
                              '10:00',
                              '12:00',
                              '14:00',
                              '16:00',
                              '18:00',
                              '20:00'
                            ]
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

                        // Urgency level
                        LocalizedLabel(
                          text: LocaleKeys.urgency_level,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        Gaps.v(8),
                        Row(
                          children: UrgencyLevel.values.map((level) {
                            final isSelected = state.urgency == level;
                            Color borderColor;
                            Color bgColor;
                            Color textColor;
                            String labelKey;

                            if (level == UrgencyLevel.emergency) {
                              borderColor = const Color(0xFFEF4444);
                              bgColor = isSelected
                                  ? const Color(0xFFEF4444)
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent;
                              textColor = const Color(0xFFEF4444);
                              labelKey = LocaleKeys.emergency;
                            } else if (level == UrgencyLevel.urgent) {
                              borderColor = const Color(0xFFF97316);
                              bgColor = isSelected
                                  ? const Color(0xFFF97316)
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent;
                              textColor = const Color(0xFFF97316);
                              labelKey = LocaleKeys.urgent;
                            } else {
                              borderColor = const Color(0xFF14B8A6);
                              bgColor = isSelected
                                  ? const Color(0xFF14B8A6)
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent;
                              textColor = const Color(0xFF14B8A6);
                              labelKey = LocaleKeys.normal;
                            }

                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () => cubit.updateUrgency(level),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      border: Border.all(
                                        color: isSelected
                                            ? borderColor
                                            : (context.isDarkMode
                                                ? Colors.white24
                                                : Colors.black12),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: LocalizedLabel(
                                      text: labelKey, // Use LocalizedLabel here
                                      style: TextStyle(
                                        color: isSelected
                                            ? textColor
                                            : (context.isDarkMode
                                                ? Colors.white70
                                                : Colors.black54),
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Gaps.v(16),

                        // Details textfield
                        LocalizedLabel(
                          text: LocaleKeys.additional_details,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        Gaps.v(8),
                        TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                                LocaleKeys.additional_details_placeholder.tr(),
                            prefixIcon: const Padding(
                              padding:
                                  EdgeInsets.only(left: 12, right: 8, top: 12),
                              child: Icon(Icons.message),
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
                          onChanged: cubit.updateDetails,
                        ),
                        Gaps.v(16),

                        // Info box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF3B82F6).withValues(alpha: 0.1),
                            border: Border.all(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info,
                                  color: Color(0xFF3B82F6), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: LocalizedLabel(
                                  text: LocaleKeys.service_request_info,
                                  style: const TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 12,
                                  ),
                                ),
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
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: state.selectedDate != null &&
                                        state.selectedTime.isNotEmpty
                                    ? () {
                                        context.showSuccessMessage(
                                          LocaleKeys.service_requested,
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFFA855F7), // Match service color
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
                                    const Icon(Icons.send, size: 18),
                                    const SizedBox(width: 8),
                                    LocalizedLabel(
                                      text: LocaleKeys.submit_request,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Safe area for bottom sheet
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
