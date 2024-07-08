import 'package:equatable/equatable.dart';

/// Represents the operating hours for a Stashpoint.
class StashpointOperatingHours extends Equatable {
  final String open;
  final int day;
  final String close;

  /// Constructs an instance of [StashpointOperatingHours].
  ///
  /// Parameters:
  /// - [open]: The opening time (e.g., "09:00:00").
  /// - [day]: The day of the week as an integer (e.g., 0 for Monday, 6 for Sunday).
  /// - [close]: The closing time (e.g., "17:00:00").
  const StashpointOperatingHours({
    required this.open,
    required this.day,
    required this.close,
  });

  /// Creates an instance of [StashpointOperatingHours] from a JSON map.
  ///
  /// Parameters:
  /// - [map]: The JSON map containing the data.
  ///
  /// Returns:
  /// - An instance of [StashpointOperatingHours].
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
