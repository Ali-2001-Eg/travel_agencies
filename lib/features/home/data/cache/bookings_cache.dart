import '../../home.dart';

abstract interface class IBookingsCache {
  /// Save a booking
  Future<void> saveBooking(BookingModel booking);

  /// Get all bookings
  Future<List<BookingModel>> getBookings();

  /// Get upcoming bookings (confirmed and in the future)
  Future<List<BookingModel>> getUpcomingBookings();

  ///Delete a booking
  Future<void> deleteBooking(String id);

  /// Clear all bookings
  Future<void> clearAll();
}
