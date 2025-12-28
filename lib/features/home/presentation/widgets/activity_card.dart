part of '../../home.dart';

class ExcursionCard extends StatelessWidget {
  final ExcursionModel excursion;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onBook;

  final bool showStackedCategories;
  const ExcursionCard({
    super.key,
    required this.excursion,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onBook,
    this.showStackedCategories = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isUnbounded = constraints.maxHeight == double.infinity;

        return Container(
          decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: context.isDarkMode ? 0.3 : 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: isUnbounded ? MainAxisSize.min : MainAxisSize.max,
            children: [
              // Image with overlays
              if (isUnbounded)
                SizedBox(
                  height: 220,
                  child: _buildImageStack(context),
                )
              else
                Expanded(
                  child: _buildImageStack(context),
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      excursion.name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            context.isDarkMode ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      excursion.description,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.isDarkMode
                            ? Colors.white70
                            : Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Location and Duration
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: context.isDarkMode
                              ? Colors.white60
                              : Colors.black45,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            excursion.location,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.isDarkMode
                                  ? Colors.white60
                                  : Colors.black45,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: context.isDarkMode
                              ? Colors.white60
                              : Colors.black45,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          excursion.duration,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white60
                                : Colors.black45,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Price and Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${excursion.price}',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            LocalizedLabel(
                              text: LocaleKeys.per_person,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.isDarkMode
                                    ? Colors.white60
                                    : Colors.black45,
                                fontSize: context.responsive(12, 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: onBook,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF97316),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: LocalizedLabel(
                              text: LocaleKeys.book_now,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: CachedNetworkImage(
            imageUrl: excursion.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator.adaptive()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
        ),
        // Category badge (top-left)
        Positioned(
          top: 12,
          left: 12,
          child: StackedCategories(
            categories: excursion.categories,
            showStacked: showStackedCategories,
          ),
        ),
        // Favorite button (top-right)
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: onToggleFavorite,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: 20,
              ),
            ),
          ),
        ),
        // Rating badge (bottom-left)
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  excursion.rating.toString(),
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
