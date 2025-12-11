part of '../../home.dart';

class ServiceCardWidget extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onRequest;

  const ServiceCardWidget({
    super.key,
    required this.service,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double iconSize = constraints.maxWidth * 0.35;
      final bool isSmall =
          constraints.maxWidth < 140 || constraints.maxHeight < 180;

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
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 12 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top section (Icon + Title)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Service icon
                    Flexible(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Text(
                              service.icon,
                              style: TextStyle(
                                fontSize: iconSize.clamp(24, 56),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Gaps.v(isSmall ? 4 : 8),
                    // Service name
                    Text(
                      service.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            context.isDarkMode ? Colors.white : Colors.black87,
                        fontSize: isSmall ? 13 : null,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!isSmall) ...[
                      Gaps.v(4),
                      // Service description (hide if small)
                      Flexible(
                        child: Text(
                          service.description,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Gaps.v(8),

              // Request button (Bottom)
              SizedBox(
                width: double.infinity,
                height: isSmall ? 32 : 36,
                child: ElevatedButton(
                  onPressed: service.available ? onRequest : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF14B8A6),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: LocalizedLabel(
                    text: LocaleKeys.request_service,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: isSmall ? 11 : 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
