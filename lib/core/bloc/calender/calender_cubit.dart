part of '../blocs.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState(currentDate: DateTime.now()));

  void nextMonth() {
    final newDate = DateTime(
      state.currentDate.year,
      state.currentDate.month + 1,
      1,
    );
    emit(CalendarState(
      currentDate: newDate,
      selectedDate: state.selectedDate,
      isForward: true,
    ));
  }

  void previousMonth() {
    final newDate = DateTime(
      state.currentDate.year,
      state.currentDate.month - 1,
      1,
    );
    emit(CalendarState(
      currentDate: newDate,
      selectedDate: state.selectedDate,
      isForward: false,
    ));
  }

  void nextYear() {
    final newDate = DateTime(
      state.currentDate.year + 1,
      state.currentDate.month,
      1,
    );
    emit(CalendarState(
      currentDate: newDate,
      selectedDate: state.selectedDate,
      isForward: true,
    ));
  }

  void previousYear() {
    final newDate = DateTime(
      state.currentDate.year - 1,
      state.currentDate.month,
      1,
    );
    emit(CalendarState(
      currentDate: newDate,
      selectedDate: state.selectedDate,
      isForward: false,
    ));
  }

  void selectDate(DateTime date, {bool isForward = true}) {
    emit(CalendarState(
      currentDate: date,
      selectedDate: date,
      isForward: isForward,
    ));
  }
}