part of '../../home.dart';

class StackedCategories extends StatelessWidget {
  final List<ExcursionCategory> categories;
  final bool showStacked;

  const StackedCategories({
    super.key,
    required this.categories,
    this.showStacked = false,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    if (!showStacked || categories.length == 1) {
      return _CategoryBadge(category: categories.first);
    }

    // For "Uno card" look, we fan the cards out
    // Top badge is categories.first
    final topCategory = categories.first;
    final otherCategories =
        categories.skip(1).take(2).toList(); // Show max 3 total for clean look

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background cards
        ...otherCategories.reversed.toList().asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          // deepIndex 1 is the 1st card behind the top one
          final deepIndex = otherCategories.length - index;

          // Rotation and Translation for Uno fanned look
          final double rotation = deepIndex * 0.15; // Subtle tilt (radians)
          final double translateX = deepIndex * 12.0;
          final double translateY = deepIndex * 4.0;
          final double opacity = 0.5 + (index * 0.2);

          return Transform.translate(
            offset: Offset(translateX, translateY),
            child: Transform.rotate(
              angle: rotation,
              child: _CategoryBadge(
                category: category,
                opacity: opacity,
                showShadow: false,
              ),
            ),
          );
        }),
        // Top card (unrotated for readability)
        _CategoryBadge(
          category: topCategory,
          opacity: 1.0,
          showShadow: true,
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final ExcursionCategory category;
  final double opacity;
  final bool showShadow;

  const _CategoryBadge({
    required this.category,
    this.opacity = 1.0,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF14B8A6).withValues(alpha: opacity),
            const Color(0xFF0D9488).withValues(alpha: opacity),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color:
                      const Color(0xFF14B8A6).withValues(alpha: 0.4 * opacity),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Text(
        _getCategoryLabel(category),
        style: TextStyle(
          color: Colors.white.withValues(alpha: opacity),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getCategoryLabel(ExcursionCategory category) {
    switch (category) {
      case ExcursionCategory.snorkeling:
        return LocaleKeys.snorkeling.tr();
      case ExcursionCategory.diving:
        return LocaleKeys.diving.tr();
      case ExcursionCategory.safari:
        return LocaleKeys.safari.tr();
      case ExcursionCategory.cultural:
        return LocaleKeys.cultural.tr();
      case ExcursionCategory.adventure:
        return LocaleKeys.adventure.tr();
      default:
        return LocaleKeys.all.tr();
    }
  }
}
