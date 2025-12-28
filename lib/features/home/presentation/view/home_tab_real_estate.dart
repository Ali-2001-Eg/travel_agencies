part of '../../home.dart';

class RealEstateTabView extends StatelessWidget {
  const RealEstateTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RealEstateBloc(),
      child: const _RealEstateContent(),
    );
  }
}

class _RealEstateContent extends StatelessWidget {
  const _RealEstateContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _RealEstateCategorySelector(),
        Expanded(
          child: BlocBuilder<RealEstateBloc, RealEstateState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCategoryView(context, state.activeCategory),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryView(BuildContext context, RealEstateCategory category) {
    // For now, returning a common placeholder UI for each category
    // but clearly labeled. Consistent with the user request for 4 sections.
    return CustomScrollView(
      key: ValueKey(category),
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.responsive(1, 2),
              childAspectRatio: context.responsive(1.2, .95),
              crossAxisSpacing: context.responsive(0.0, 16.0),
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _PropertyCard(
                  title: "${category.name.tr()} ${index + 1}",
                  description:
                      "Beautiful ${category.name.tr()} in a prime location in Egypt.",
                  price: "150,000 \$",
                  imageUrl:
                      "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=400&q=80",
                );
              },
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}

class _RealEstateCategorySelector extends StatelessWidget {
  const _RealEstateCategorySelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: RealEstateCategory.values.map((category) {
          return BlocBuilder<RealEstateBloc, RealEstateState>(
            builder: (context, state) {
              final isActive = state.activeCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ChoiceChip(
                  label: LocalizedLabel(
                    text: category.localizedName,
                    style: AppTextTheme.headlineSmall.copyWith(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isActive,
                  onSelected: (selected) {
                    if (selected) {
                      context
                          .read<RealEstateBloc>()
                          .add(ChangeRealEstateCategoryEvent(category));
                    }
                  },
                  selectedColor: const Color(0xFF14B8A6),
                  backgroundColor: context.isDarkMode
                      ? const Color(0xFF2A2A3E)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color:
                          isActive ? Colors.transparent : Colors.grey.shade300,
                    ),
                  ),
                  showCheckmark: false,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const _PropertyCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: context.responsive(180.0, 240.0),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextTheme.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            context.isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      price,
                      style: AppTextTheme.headlineMedium.copyWith(
                        color: const Color(0xFF14B8A6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextTheme.bodyMedium.copyWith(
                    color: context.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14B8A6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: LocalizedLabel(
                      text: LocaleKeys.book_now,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
