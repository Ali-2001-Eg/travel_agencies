part of '../../auth.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Determine the correct icon based on current theme mode
        IconData themeIcon;
        if (themeState.themeMode == ThemeMode.system) {
          // For system mode, check actual brightness
          themeIcon = context.isDarkMode ? Icons.light_mode : Icons.dark_mode;
        } else {
          // For explicit light/dark mode
          themeIcon = themeState.themeMode == ThemeMode.light
              ? Icons.dark_mode
              : Icons.light_mode;
        }

        return Container(
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
              ThemeMode newThemeMode;
              switch (themeState.themeMode) {
                case ThemeMode.light:
                  newThemeMode = ThemeMode.dark;
                  break;
                case ThemeMode.dark:
                  newThemeMode = ThemeMode.system;
                  break;
                case ThemeMode.system:
                  newThemeMode = ThemeMode.light;
                  break;
              }
              context.read<ThemeBloc>().add(ThemeChanged(newThemeMode));
            },
            icon: Icon(
              themeIcon,
              color: context.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        );
      },
    );
  }
}
