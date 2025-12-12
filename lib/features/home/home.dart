import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_agencies/core/theme/theme.dart';

import '../../core/bloc/blocs.dart';
import '../../core/enum/egyptian_city.dart';
import '../../core/extensions/extensions.dart';
import '../../core/localization/locale_keys.g.dart';
import '../../core/widgets/widgets.dart';
import '../auth/auth.dart';

// Blocs
import 'blocs/home_navigation_bloc.dart';
import 'blocs/booking_dialog_cubit.dart';
import 'blocs/service_request_cubit.dart';

// Models
part 'models/excursion_model.dart';
part 'models/event_model.dart';
part 'models/service_model.dart';

// Views
part 'presentation/view/home_screen.dart';

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
