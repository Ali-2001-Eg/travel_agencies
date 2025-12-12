part of '../../home.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // App logo
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF6B35),
                Color(0xFFFFB347),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 28,
          ),
        ),

        // Controls (language, theme, logout)
        Row(
          children: [
            // Language dropdown
            const LocaleDropdown(),
            Gaps.h10(),

            // Theme toggle
            const ThemeToggleButton(),
            Gaps.h10(),

            // Logout button
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
                onPressed: () {
                  // Logout logic - navigate back to login
                  context.go('/');
                },
                icon: Icon(
                  Icons.logout,
                  color: HexColor.errorColor
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
