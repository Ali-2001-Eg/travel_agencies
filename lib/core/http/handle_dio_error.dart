part of "http.dart";


Failure _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.cancel:
      navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'تم الغاء الطلب ');
      return ServerFailure(message: 'تم إلغاء الطلب ');
    case DioExceptionType.connectionTimeout:
      navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'انتهت مهلة الاتصال ');
      return ServerFailure(message: 'انتهت مهلة الاتصال ');
    case DioExceptionType.receiveTimeout:
      navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'انتهت مهلة الاتصال ');
      return ServerFailure(message: 'انتهت مهلة الاستقبال في الاتصال ');
    case DioExceptionType.sendTimeout:
      navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'انتهت مهلة الاتصال ');
      return ServerFailure(message: 'انتهت مهلة الإرسال في الاتصال ');
    case DioExceptionType.badResponse:
      return _handleBadResponse(error);
    case DioExceptionType.badCertificate:
      return ServerFailure(message: 'تعذر الاتصال ');
    case DioExceptionType.connectionError:
      navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'تعذر الاتصال ');
      return NetworkFailure(message: 'تعذر الاتصال ');
    case DioExceptionType.unknown:
      return UnknownFailure(message: 'Unexpected error: ${error.message}');
  }
}

Failure _handleBadResponse(DioException error) {
  if (error.response?.data == null) {
    return ServerFailure(
      message: 'Received invalid status code: ${error.response?.statusCode}',
    );
  }

  try {
    final res = error.response!;
    final data = res.data;

    Map<String, dynamic>? decoded;
    String? textMessage;

    if (data is Map<String, dynamic>) {
      decoded = data;
    } else if (data is String) {
      try {
        decoded = json.decode(data) as Map<String, dynamic>;
      } catch (_) {
        textMessage = data.trim();
      }
    }

    // Handle specific status codes
    switch (res.statusCode) {
      case 503:
        return ServerFailure(message: 'network failure ${error.message}');
      case 500:
        return ServerFailure(message: "Internal server error");

      case 401:
        final msg = _extractErrorMessage(decoded, textMessage, 'غير مصرح لك');
        return ValidationFailure(message: msg, errors: [msg]);
      case 413:
        navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:'File size is too large');
        return ServerFailure(message: 'File size is too large');
      case 404:
      // navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message: messagemessage:)('لا توجد نتائج');
        return NotFoundFailure(message: 'لا توجد نتائج');
      case 407:
        loggerWarn('APP IS OPENED IN ANOTHER DEVICE');
        return SyncAppFailure(message: 'تم فتح التطبيق في جهاز آخر');
      case 402:
        return PaymentFailure(message: error.message ?? "");
      case 409:
        loggerWarn('VERIFYERROR');
        return VerifyOTPFailure(message: 'خطأ في التحقق من الكود');
    }

    // Handle validation errors
    if (decoded != null && decoded.containsKey('message')) {
      if (decoded.containsKey('result') && decoded['result'] is Map) {
        return _handleValidationErrors(decoded);
      }

      String message = decoded['message'];
      return (res.statusCode != null && res.statusCode! >= 400 && res.statusCode! < 500)
          ? ValidationFailure(message: message, errors: [message])
          : ServerFailure(message: message);
    }

    // Handle plain text messages
    if (textMessage != null && textMessage.isNotEmpty) {
      final code = res.statusCode ?? 0;
      if (code >= 400 && code < 500) {
        return ValidationFailure(message: textMessage, errors: [textMessage]);
      }
      return ServerFailure(message: textMessage);
    }
  } catch (e) {
    return ServerFailure(
      message: 'Received invalid status code: ${error.response?.statusCode}',
    );
  }

  return ServerFailure(
    message: 'Received invalid status code: ${error.response?.statusCode}',
  );
}

String _extractErrorMessage(Map<String, dynamic>? decoded, String? textMessage, String defaultMessage) {
  if (decoded != null && decoded.containsKey('message')) {
    return decoded['message']?.toString() ?? defaultMessage;
  }
  if (textMessage?.isNotEmpty == true) {
    return textMessage!;
  }
  return defaultMessage;
}

ValidationFailure _handleValidationErrors(Map<String, dynamic> decoded) {
  final errors = decoded['result'] as Map<String, dynamic>;
  List<String> messages = [];

  errors.forEach((key, value) {
    if (value is List) {
      messages.addAll(value.map((e) => '$key: $e'));
    } else if (value is String) {
      messages.add('$key: $value');
    }
  });

  final message = decoded['message'] ?? 'حدث خطأ ما';

  if (messages.isNotEmpty) {
    navigatorKey.currentContext!.showTopSnackBar(type: SnackBarType.error,message:messages.first);
  }

  return ValidationFailure(
    message: messages.isNotEmpty ? messages.first : message,
    errors: messages,
  );
}