part of 'http.dart';

abstract interface class Endpoints {
  static const String baseUrl = 'https://travel.shaarapp.com/api/';
  static const String login = 'login';
  static const String register = 'register';
  static const String verifyOtp = 'verify';
  static const String resendOtp = 'resend';
  static const String cities = 'cities';
  static const String auth = '/auth';
  static const String user = '/user';
  static const String product = '/product';
  static const String order = '/order';
  static const String cart = '/cart';
  static const String payment = '/payment';
  static const String notification = '/notification';
  static const String setting = '/setting';
  static const String help = '/help';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String forgetPassword = "/forget-password";
  static const String logout = "/logout";
}
