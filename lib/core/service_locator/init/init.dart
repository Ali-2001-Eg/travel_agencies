part of '../service_locator.dart';
final GetIt getIt = GetIt.instance;
abstract interface class DI{
  static Future<void> execute() async {
    await SharedServiceLocator.execute(getIt: getIt);
    await AuthServiceLocator.execute(getIt: getIt);
  }
}