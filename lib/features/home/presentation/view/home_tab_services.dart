part of '../../home.dart';

class _ServicesTabView extends StatelessWidget {
  const _ServicesTabView();

  @override
  Widget build(BuildContext context) {
    final services = ServiceModel.getMockData();

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsive(2, 3),
        childAspectRatio: context.responsive(0.85, 1.0),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCardWidget(
          service: service,
          onRequest: () => _showServiceRequestSheet(context, service),
        );
      },
    );
  }
}
