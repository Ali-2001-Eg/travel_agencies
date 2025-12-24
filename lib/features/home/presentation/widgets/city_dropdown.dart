part of '../../home.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CityBloc>(),
      child: BlocBuilder<CityBloc, CitySate>(
        builder: (context, state) {
          final cities = state.items;
          if (cities.isEmpty && state.isSuccess) {
            return const Center(child: Text("No cities"));
          }

          return Stack(
            children: [
              Opacity(
                opacity: state.isLoading ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: state.isLoading,
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? const Color(0xFF2A2A3E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<CityModel>(
                        value: state.selectedCity,
                        isExpanded: true,
                        hint: LocalizedLabel(
                          text: LocaleKeys.select_city,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black87,
                        ),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black87,
                        ),
                        dropdownColor: context.isDarkMode
                            ? const Color(0xFF2A2A3E)
                            : Colors.white,
                        items: cities.map((CityModel city) {
                          return DropdownMenuItem<CityModel>(
                            value: city,
                            child: Text(
                              city.name,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (CityModel? newCity) {
                          if (newCity != null) {
                            context
                                .read<CityBloc>()
                                .add(SelectCityEvent(city: newCity));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
