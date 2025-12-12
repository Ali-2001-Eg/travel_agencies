import 'dart:convert';
import '../../features/home/data/cache/bookings_cache.dart';
import '../../features/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsCacheImpl implements IBookingsCache {
  static const String _bookingsKey = 'bookings_cache';

  @override
  Future<void> saveBooking(BookingModel booking) async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = await getBookings();

    // Check if booking already exists, update it
    final index = bookings.indexWhere((b) => b.id == booking.id);
    if (index != -1) {
      bookings[index] = booking;
    } else {
      bookings.add(booking);
    }

    // Save to shared preferences
    final jsonList = bookings.map((b) => b.toJson()).toList();
    await prefs.setString(_bookingsKey, jsonEncode(jsonList));
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_bookingsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList
        .map((json) => BookingModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<BookingModel>> getUpcomingBookings() async {
    final bookings = await getBookings();
    final now = DateTime.now();

    return bookings
        .where((booking) =>
            booking.status == BookingStatus.confirmed &&
            booking.selectedDate.isAfter(now))
        .toList()
      ..sort((a, b) => a.selectedDate.compareTo(b.selectedDate));
  }

  @override
  Future<void> deleteBooking(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = await getBookings();

    bookings.removeWhere((b) => b.id == id);

    final jsonList = bookings.map((b) => b.toJson()).toList();
    await prefs.setString(_bookingsKey, jsonEncode(jsonList));
  }

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bookingsKey);
  }
}
