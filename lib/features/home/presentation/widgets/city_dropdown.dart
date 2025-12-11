part of '../../home.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, EnumState<EgyptianCity>>(
      builder: (context, state) {
        return Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade300,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<EgyptianCity>(
              value: state.selected,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.isDarkMode ? Colors.white : Colors.black87,
              ),
              dropdownColor:
                  context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
              items: EgyptianCity.values.map((EgyptianCity city) {
                return DropdownMenuItem<EgyptianCity>(
                  value: city,
                  child: Row(
                    children: [
                      Text(
                        city.emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        city.name,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (EgyptianCity? newCity) {
                if (newCity != null) {
                  context.read<CityBloc>().changeCity(newCity);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
