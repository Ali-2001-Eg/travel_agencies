part of '../blocs.dart';
class CalendarState extends Equatable {
  final DateTime currentDate;
  final DateTime? selectedDate;
  final bool isForward;

  const CalendarState({
    required this.currentDate,
    this.selectedDate,
    this.isForward = true,
  });

  @override
  List<Object?> get props => [currentDate, selectedDate, isForward];
}