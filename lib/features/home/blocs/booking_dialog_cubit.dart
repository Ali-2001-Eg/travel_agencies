import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDialogState extends Equatable {
  final bool isOpen;
  final DateTime? selectedDate;
  final String selectedTime;
  final int numberOfPeople;
  final String additionalNotes;

  const BookingDialogState({
    this.isOpen = false,
    this.selectedDate,
    this.selectedTime = '09:00',
    this.numberOfPeople = 1,
    this.additionalNotes = '',
  });

  BookingDialogState copyWith({
    bool? isOpen,
    DateTime? selectedDate,
    String? selectedTime,
    int? numberOfPeople,
    String? additionalNotes,
  }) {
    return BookingDialogState(
      isOpen: isOpen ?? this.isOpen,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      additionalNotes: additionalNotes ?? this.additionalNotes,
    );
  }

  double calculateTotal(double basePrice) {
    final subtotal = basePrice * numberOfPeople;
    final serviceFee = subtotal * 0.1;
    return subtotal + serviceFee;
  }

  @override
  List<Object?> get props =>
      [isOpen, selectedDate, selectedTime, numberOfPeople, additionalNotes];
}

class BookingDialogCubit extends Cubit<BookingDialogState> {
  BookingDialogCubit() : super(const BookingDialogState());

  void openDialog() {
    emit(const BookingDialogState(isOpen: true));
  }

  void closeDialog() {
    emit(const BookingDialogState(isOpen: false));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateNumberOfPeople(int count) {
    emit(state.copyWith(numberOfPeople: count));
  }

  void updateNotes(String notes) {
    emit(state.copyWith(additionalNotes: notes));
  }

  void reset() {
    emit(const BookingDialogState());
  }
}
