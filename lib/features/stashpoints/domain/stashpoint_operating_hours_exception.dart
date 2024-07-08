import 'package:equatable/equatable.dart';

/// Represents an exception to the regular operating hours, such as a holiday.
class StashpointOperatingHoursException extends Equatable {
  final String name;
  final String startTime;
  final String date;
  final String endTime;
  final String type;

  /// Constructs an instance of [StashpointOperatingHoursException].
  ///
  /// Parameters:
  /// - [name]: The name of the exception (e.g., "Holiday").
  /// - [startTime]: The start time of the exception (e.g., "00:00:00").
  /// - [date]: The date of the exception (e.g., "2024-07-16").
  /// - [endTime]: The end time of the exception (e.g., "00:00:00").
  /// - [type]: The type of the exception (e.g., "closed").
  const StashpointOperatingHoursException({
    required this.name,
    required this.startTime,
    required this.date,
    required this.endTime,
    required this.type,
  });

  /// Creates an instance of [StashpointOperatingHoursException] from a JSON map.
  ///
  /// Parameters:
  /// - [map]: The JSON map containing the data.
  ///
  /// Returns:
  /// - An instance of [StashpointOperatingHoursException].
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
