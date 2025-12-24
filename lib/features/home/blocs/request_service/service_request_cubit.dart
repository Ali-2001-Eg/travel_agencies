import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UrgencyLevel { normal, urgent, emergency }

class ServiceRequestState extends Equatable {
  final bool isOpen;
  final DateTime? selectedDate;
  final String selectedTime;
  final UrgencyLevel urgency;
  final String details;

  const ServiceRequestState({
    this.isOpen = false,
    this.selectedDate,
    this.selectedTime = '',
    this.urgency = UrgencyLevel.normal,
    this.details = '',
  });

  ServiceRequestState copyWith({
    bool? isOpen,
    DateTime? selectedDate,
    String? selectedTime,
    UrgencyLevel? urgency,
    String? details,
  }) {
    return ServiceRequestState(
      isOpen: isOpen ?? this.isOpen,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      urgency: urgency ?? this.urgency,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props =>
      [isOpen, selectedDate, selectedTime, urgency, details];
}

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  ServiceRequestCubit() : super(const ServiceRequestState());

  void openDialog() {
    emit(const ServiceRequestState(isOpen: true));
  }

  void closeDialog() {
    emit(const ServiceRequestState(isOpen: false));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateUrgency(UrgencyLevel urgency) {
    emit(state.copyWith(urgency: urgency));
  }

  void updateDetails(String details) {
    emit(state.copyWith(details: details));
  }

  void reset() {
    emit(const ServiceRequestState());
  }
}
