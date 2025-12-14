part of '../../auth.dart';

class AuthResponsiveScaffold extends StatelessWidget {
  final Widget header;
  final Widget card;
  final IconData brandingIcon;
  final String brandingTitle;
  final String brandingSubtitle;

  const AuthResponsiveScaffold({
    super.key,
    required this.header,
    required this.card,
    required this.brandingIcon,
    required this.brandingTitle,
    required this.brandingSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? const Color(0xFF1A1A2E) : const Color(0xFFF5F7FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final showBranding = constraints.maxWidth >= 1000;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: showBranding
                    ? Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: context.isDarkMode
                                      ? [
                                          const Color(0xFF2A2A3E),
                                          const Color(0xFF151523),
                                        ]
                                      : [
                                          Colors.blue.shade400,
                                          Colors.blue.shade800,
                                        ],
                                ),
                              ),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 520),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 48),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          brandingIcon,
                                          size: 120,
                                          color: Colors.white
                                              .withValues(alpha: 0.92),
                                        ),
                                        const SizedBox(height: 28),
                                        Text(
                                          brandingTitle,
                                          style: context.textTheme.displayMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          brandingSubtitle,
                                          style: context
                                              .textTheme.headlineSmall
                                              ?.copyWith(
                                            color: Colors.white70,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Align(
                              alignment: Alignment.center,
                              child: _AuthFormPane(
                                header: header,
                                card: card,
                                maxWidth: 640,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: _AuthFormPane(
                          header: header,
                          card: card,
                          maxWidth: 560,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AuthFormPane extends StatelessWidget {
  final Widget header;
  final Widget card;
  final double maxWidth;

  const _AuthFormPane({
    required this.header,
    required this.card,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(24.0, 48.0),
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            Gaps.v(32),
            card,
          ],
        ),
      ),
    );
  }
}
