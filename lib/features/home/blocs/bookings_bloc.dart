import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/cache/bookings_cache.dart';
import '../home.dart';

// Events
abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookingsEvent extends BookingsEvent {
  const LoadBookingsEvent();
}

class LoadUpcomingBookingsEvent extends BookingsEvent {
  const LoadUpcomingBookingsEvent();
}

class AddBookingEvent extends BookingsEvent {
  final BookingModel booking;

  const AddBookingEvent(this.booking);

  @override
  List<Object?> get props => [booking];
}

class DeleteBookingEvent extends BookingsEvent {
  final String bookingId;

  const DeleteBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

// States
abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object?> get props => [];
}

class BookingsInitial extends BookingsState {
  const BookingsInitial();
}

class BookingsLoading extends BookingsState {
  const BookingsLoading();
}

class BookingsLoaded extends BookingsState {
  final List<BookingModel> bookings;
  final List<BookingModel> upcomingBookings;

  const BookingsLoaded({
    required this.bookings,
    required this.upcomingBookings,
  });

  @override
  List<Object?> get props => [bookings, upcomingBookings];
}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final IBookingsCache bookingsCache;

  BookingsBloc({required this.bookingsCache}) : super(const BookingsInitial()) {
    on<LoadBookingsEvent>(_onLoadBookings);
    on<LoadUpcomingBookingsEvent>(_onLoadUpcomingBookings);
    on<AddBookingEvent>(_onAddBooking);
    on<DeleteBookingEvent>(_onDeleteBooking);
  }

  Future<void> _onLoadBookings(
    LoadBookingsEvent event,
    Emitter<BookingsState> emit,
  ) async {
    emit(const BookingsLoading());
    try {
      final bookings = await bookingsCache.getBookings();
      final upcoming = await bookingsCache.getUpcomingBookings();
      emit(BookingsLoaded(bookings: bookings, upcomingBookings: upcoming));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }

  Future<void> _onLoadUpcomingBookings(
    LoadUpcomingBookingsEvent event,
    Emitter<BookingsState> emit,
  ) async {
    try {
      final bookings = await bookingsCache.getBookings();
      final upcoming = await bookingsCache.getUpcomingBookings();
      emit(BookingsLoaded(bookings: bookings, upcomingBookings: upcoming));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }

  Future<void> _onAddBooking(
    AddBookingEvent event,
    Emitter<BookingsState> emit,
  ) async {
    try {
      await bookingsCache.saveBooking(event.booking);
      // Reload bookings
      final bookings = await bookingsCache.getBookings();
      final upcoming = await bookingsCache.getUpcomingBookings();
      emit(BookingsLoaded(bookings: bookings, upcomingBookings: upcoming));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }

  Future<void> _onDeleteBooking(
    DeleteBookingEvent event,
    Emitter<BookingsState> emit,
  ) async {
    try {
      await bookingsCache.deleteBooking(event.bookingId);
      // Reload bookings
      final bookings = await bookingsCache.getBookings();
      final upcoming = await bookingsCache.getUpcomingBookings();
      emit(BookingsLoaded(bookings: bookings, upcomingBookings: upcoming));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }
}
