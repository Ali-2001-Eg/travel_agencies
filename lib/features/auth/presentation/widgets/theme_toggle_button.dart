part of '../../auth.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Show the icon for the mode we will switch TO
        final themeIcon =
            context.isDarkMode ? Icons.light_mode : Icons.dark_mode;

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
              if (themeState.themeMode == ThemeMode.light) {
                newThemeMode = ThemeMode.dark;
              } else if (themeState.themeMode == ThemeMode.dark) {
                newThemeMode = ThemeMode.light;
              } else {
                // If in System mode, toggle to the opposite of current brightness
                newThemeMode =
                    context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
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
