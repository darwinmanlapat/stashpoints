import 'package:equatable/equatable.dart';

/// Represents the operating hours for a Stashpoint.
///
/// This class models the operating hours of a stashpoint location, including the day of the week,
/// opening time, and closing time.
///
/// Properties:
/// - [open]: The opening time formatted as a string (e.g., "09:00:00").
/// - [day]: The day of the week represented as an integer (0 for Monday, 6 for Sunday).
/// - [close]: The closing time formatted as a string (e.g., "17:00:00").
///
/// Methods:
/// - [StashpointOperatingHours.fromJson]: Factory method to create a [StashpointOperatingHours] instance from JSON data.
///
/// Equality:
/// - The equality of two [StashpointOperatingHours] instances is based on all properties being equal.
///
/// String Conversion:
/// - [stringify] is set to true to enable readable string conversion of [StashpointOperatingHours] instances.

class StashpointOperatingHours extends Equatable {
  final String open;
  final int day;
  final String close;

  const StashpointOperatingHours({
    required this.open,
    required this.day,
    required this.close,
  });

  factory StashpointOperatingHours.fromJson(Map<String, dynamic> map) {
    return StashpointOperatingHours(
      open: map['open'] as String? ?? '00:00:00',
      day: map['day'] as int? ?? -1,
      close: map['close'] as String? ?? '00:00:00',
    );
  }
  @override
  List<Object> get props => [
        open,
        day,
        close,
      ];

  @override
  bool get stringify => true;
}
