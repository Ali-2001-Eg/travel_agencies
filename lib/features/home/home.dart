import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_agencies/core/helpers/helpers.dart';
import 'package:travel_agencies/core/http/either.dart';
import 'package:travel_agencies/core/http/failure.dart';
import 'package:travel_agencies/core/http/http.dart';
import 'package:travel_agencies/core/local_storage/local_storage.dart';
import 'package:travel_agencies/core/theme/theme.dart';

import '../../core/extensions/extensions.dart';
import '../../core/localization/locale_keys.g.dart';
import '../../core/router/router.dart';
import '../../core/service_locator/service_locator.dart';
import '../../core/widgets/widgets.dart';
import '../auth/auth.dart';

// Blocs
import 'blocs/cities/city_bloc.dart';
import 'blocs/home_navigation/home_navigation_bloc.dart';
import 'blocs/booking_dialogue/booking_dialog_cubit.dart';
import 'blocs/request_service/service_request_cubit.dart';
import 'blocs/booking/bookings_bloc.dart';
import 'blocs/real_estate/real_estate_bloc.dart';

part 'models/excursion_model.dart';
part 'models/event_model.dart';
part 'models/service_model.dart';
part 'models/booking_model.dart';

// Views
part 'presentation/view/home_screen.dart';
part 'presentation/view/home_tab_body.dart';
part 'presentation/view/home_tab_helpers.dart';
part 'presentation/view/home_tab_home.dart';
part 'presentation/view/home_tab_excursions.dart';
part 'presentation/view/home_tab_events.dart';
part 'presentation/view/home_tab_services.dart';
part 'presentation/view/home_tab_favorites.dart';
part 'presentation/view/home_tab_offers.dart';
part 'presentation/view/home_tab_real_estate.dart';
part 'presentation/view/bookings_screen.dart';

// Widgets
part 'presentation/widgets/home_header.dart';
part 'presentation/widgets/home_search_section.dart';
part 'presentation/widgets/city_dropdown.dart';
part 'presentation/widgets/popular_activities_section.dart';
part 'presentation/widgets/activity_card.dart';
part 'presentation/widgets/special_events_section.dart';
part 'presentation/widgets/event_card.dart';
part 'presentation/widgets/additional_services_section.dart';
part 'presentation/widgets/service_card.dart';
part 'presentation/widgets/tab_navigation_bar.dart';
part 'presentation/widgets/booking_dialog.dart';
part 'presentation/widgets/service_request_dialog.dart';
part 'presentation/widgets/upcoming_bookings_card.dart';
part 'presentation/widgets/booking_reminder_badge.dart';
part 'models/city_model.dart';
part 'data_source/city_data_source.dart';

