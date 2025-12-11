part of '../widgets.dart';

class LocaleDropdown extends StatelessWidget {
  const LocaleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, EnumState<AppLocale>>(
      builder: (context, state) {
        return PopupMenuButton<AppLocale>(
          onSelected: (AppLocale locale) {
            context.read<LocaleBloc>().changeLocale(locale);
          },
          itemBuilder: (BuildContext context) {
            return AppLocale.values.map((AppLocale locale) {
              return PopupMenuItem<AppLocale>(
                value: locale,
                child: Row(
                  children: [
                    Text(
                      locale.flag,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      locale.name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color:
                            context.isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: state.selected == locale
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (state.selected == locale) ...[
                      const Spacer(),
                      Icon(
                        Icons.check,
                        color: const Color(0xFF00BFA5),
                        size: 18,
                      ),
                    ],
                  ],
                ),
              );
            }).toList();
          },
          child: Container(
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
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.selected.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: context.isDarkMode ? Colors.white : Colors.black87,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
        );
      },
    );
  }
}
