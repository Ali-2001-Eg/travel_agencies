part of '../../auth.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with back button, language and theme toggles
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            Container(
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: context.isDarkMode
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: context.isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),

            // Language and theme toggles
            Row(
              children: [
                // Language dropdown
                const LocaleDropdown(),
                Gaps.h10(),
                // Theme toggle
                const ThemeToggleButton(),
              ],
            ),
          ],
        ),

        Gaps.v25(),

        // Back to role selection text
        Align(
          alignment: Alignment.centerLeft,
          child: LocalizedLabel(
            text: LocaleKeys.back_to_role_selection,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
