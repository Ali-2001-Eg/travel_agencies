import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../enum/app_locale.dart';
import '../enum/egyptian_city.dart';
import '../enum/status.dart';
import '../helpers/helpers.dart';
import '../http/either.dart';
import '../http/failure.dart';
import '../local_storage/local_storage.dart';
import '../service_locator/service_locator.dart';

part 'base_state/base_state.dart';
part 'calender/calender_cubit.dart';
part 'calender/calender_state.dart';
part 'city_bloc/city_bloc.dart';
part 'enum_bloc/enum_bloc.dart';
part 'enum_bloc/enum_event.dart';
part 'enum_bloc/enum_state.dart';
part 'locale_bloc/locale_bloc.dart';
part 'paginated_bloc/paginated_bloc.dart';
part 'paginated_bloc/paginated_event.dart';
part 'theme_bloc/theme_bloc.dart';
part 'theme_bloc/theme_events.dart';
part 'theme_bloc/theme_states.dart';
