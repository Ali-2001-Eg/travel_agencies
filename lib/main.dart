import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agencies/core/cache/bookings_cache_impl.dart';

import 'core/bloc/blocs.dart';
import 'core/enum/app_locale.dart';
import 'core/helpers/helpers.dart';
import 'core/local_storage/local_storage.dart';
import 'core/localization/translation_service.dart';
import 'core/notification/messaging_config.dart';
import 'core/router/router.dart';
import 'core/service_locator/service_locator.dart';
import 'features/home/blocs/booking/bookings_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DI.execute();
  await HiveServiceImpl.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) {
      runApp(LocalizationService.rootWidget(child: const MyApp()));

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final context = navigatorKey.currentContext;

        if (context != null) {
          await MessagingConfig.initFirebaseMessaging();
          FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);
        } else {
          loggerWarn('Navigator context is not available');
        }
      });
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<ThemeBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<LocaleBloc>(),
            ),
            BlocProvider(
              create: (context) => BookingsBloc(
                bookingsCache: BookingsCacheImpl(),
              )..add(const LoadUpcomingBookingsEvent()),
            ),
          ],
          child: Builder(
            builder: (context) {
              // Sync LocaleBloc with initial locale from EasyLocalization
              final initialLocale = AppLocale.fromLocale(context.locale);
              context.read<LocaleBloc>().syncLocale(initialLocale);

              return BlocListener<LocaleBloc, EnumState<AppLocale>>(
                listener: (context, state) {
                  context.setLocale(state.selected.locale);
                },
                child: AppRouter.getRootApp(
                  context: context,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
