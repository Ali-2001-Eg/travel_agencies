part of '../home.dart';

class BookingStatus {
  static const String confirmed = 'confirmed';
  static const String cancelled = 'cancelled';
  static const String completed = 'completed';
}

class BookingModel {
  final String id;
  final String itemId;
  final String itemName;
  final String itemType; // 'excursion' or 'event'
  final String imageUrl;
  final String location;
  final DateTime selectedDate;
  final String selectedTime;
  final int numberOfPeople;
  final String additionalNotes;
  final double totalPrice;
  final DateTime bookingDate;
  final String status;

  const BookingModel({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.itemType,
    required this.imageUrl,
    required this.location,
    required this.selectedDate,
    required this.selectedTime,
    required this.numberOfPeople,
    required this.additionalNotes,
    required this.totalPrice,
    required this.bookingDate,
    this.status = BookingStatus.confirmed,
  });

  // Copyith
  BookingModel copyWith({
    String? id,
    String? itemId,
    String? itemName,
    String? itemType,
    String? imageUrl,
    String? location,
    DateTime? selectedDate,
    String? selectedTime,
    int? numberOfPeople,
    String? additionalNotes,
    double? totalPrice,
    DateTime? bookingDate,
    String? status,
  }) {
    return BookingModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemType: itemType ?? this.itemType,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      totalPrice: totalPrice ?? this.totalPrice,
      bookingDate: bookingDate ?? this.bookingDate,
      status: status ?? this.status,
    );
  }

  // To JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'itemType': itemType,
      'imageUrl': imageUrl,
      'location': location,
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTime': selectedTime,
      'numberOfPeople': numberOfPeople,
      'additionalNotes': additionalNotes,
      'totalPrice': totalPrice,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
    };
  }

  // From JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      itemType: json['itemType'] as String,
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      selectedTime: json['selectedTime'] as String,
      numberOfPeople: json['numberOfPeople'] as int,
      additionalNotes: json['additionalNotes'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      status: json['status'] as String? ?? BookingStatus.confirmed,
    );
  }

  // Check if booking is upcoming
  bool get isUpcoming {
    return status == BookingStatus.confirmed &&
        selectedDate.isAfter(DateTime.now());
  }

  // Days until booking
  int get daysUntil {
    return selectedDate.difference(DateTime.now()).inDays;
  }
}
