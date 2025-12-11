enum EgyptianCity {
  luxor('luxor', 'Luxor', '🏛️'),
  alexandria('alexandria', 'Alexandria', '🏖️'),
  hurghada('hurghada', 'Hurghada', '🏊‍♂️'),
  sharmElSheikh('sharm_el_sheikh', 'Sharm El Sheikh', '🤿'),
  cairo('cairo', 'Cairo', '🏛️'),
  aswan('aswan', 'Aswan', '⛵'),
  dahab('dahab', 'Dahab', '🏄‍♂️'),
  marsa_alam('marsa_alam', 'Marsa Alam', '🐠');

  const EgyptianCity(this.code, this.name, this.emoji);

  final String code;
  final String name;
  final String emoji;

  static EgyptianCity fromCode(String code) {
    return EgyptianCity.values.firstWhere(
      (city) => city.code == code,
      orElse: () => EgyptianCity.luxor,
    );
  }
}
