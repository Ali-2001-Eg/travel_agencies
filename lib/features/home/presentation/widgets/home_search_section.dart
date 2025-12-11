part of '../../home.dart';

class HomeSearchSection extends StatelessWidget {
  const HomeSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // QR Code scan button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              // QR scan logic
            },
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            label: LocalizedLabel(
              text: LocaleKeys.scan_qr_code,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        Gaps.v18(),

        // Search bar
        CustomTextField(
          hintText: LocaleKeys.search_activities,
          prefixIcon: Icon(
            Icons.search,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor:
              context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade300,
            ),
          ),
        ),

        Gaps.v18(),

        // City dropdown and filter
        Row(
          children: [
            // City dropdown
            const Expanded(child: CityDropdown()),
            Gaps.h12(),
            // Filter button
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color:
                    context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.shade300,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  // Filter logic
                },
                icon: Icon(
                  Icons.tune,
                  color: context.isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
