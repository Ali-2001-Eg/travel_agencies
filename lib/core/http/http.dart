import 'dart:convert';
import 'dart:developer';

import '../enum/snack_bar_enum.dart';
import '../extensions/extensions.dart';

import '../../main.dart';
import '../helpers/helpers.dart';
import 'either.dart';
import 'failure.dart';
import 'package:dio/dio.dart';
part 'api_consumer.dart';
part 'base_api_consumer.dart';
part 'handle_dio_error.dart';
part 'endpoints.dart';