import 'package:equatable/equatable.dart';

/// Represents an exception to the regular operating hours of a Stashpoint, such as a holiday or special closure.
///
/// This class models an exception to the stashpoint's regular operating hours, including details such as
/// the name of the exception, start and end times, date, and type (e.g., "closed").
///
/// Properties:
/// - [name]: The name of the exception (e.g., "Holiday").
/// - [startTime]: The start time of the exception formatted as a string (e.g., "00:00:00").
/// - [date]: The date of the exception formatted as a string (e.g., "2024-07-16").
/// - [endTime]: The end time of the exception formatted as a string (e.g., "00:00:00").
/// - [type]: The type of the exception (e.g., "closed").
///
/// Methods:
/// - [StashpointOperatingHoursException.fromJson]: Factory method to create a [StashpointOperatingHoursException] instance from JSON data.
///
/// Equality:
/// - The equality of two [StashpointOperatingHoursException] instances is based on all properties being equal.
///
/// String Conversion:
/// - [stringify] is set to true to enable readable string conversion of [StashpointOperatingHoursException] instances.

class StashpointOperatingHoursException extends Equatable {
  final String name;
  final String startTime;
  final String date;
  final String endTime;
  final String type;

  const StashpointOperatingHoursException({
    required this.name,
    required this.startTime,
    required this.date,
    required this.endTime,
    required this.type,
  });

  factory StashpointOperatingHoursException.fromJson(Map<String, dynamic> map) {
    return StashpointOperatingHoursException(
      name: map['name'] as String? ?? '',
      startTime: map['start_time'] as String? ?? '00:00:00',
      date: map['date'] as String? ?? '',
      endTime: map['end_time'] as String? ?? '00:00:00',
      type: map['type'] as String? ?? '',
    );
  }

  @override
  List<Object> get props => [
        name,
        startTime,
        date,
        endTime,
        type,
      ];

  @override
  bool get stringify => true;
}
