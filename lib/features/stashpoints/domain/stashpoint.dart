import 'package:equatable/equatable.dart';
import 'package:stashpoints/common/utils/text_utils.dart';

import 'package:stashpoints/features/stashpoints/domain/stashpoint_operating_hours.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_operating_hours_exception.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_pricing.dart';

/// Represents a stashpoint location with details such as its operational hours,
/// pricing, location coordinates, ratings, and photos.
///
/// This class is used to model stashpoints fetched from JSON data and provides
/// methods to serialize to and deserialize from JSON.
///
/// Properties:
/// - [isOpenLate]: Indicates if the stashpoint is open late.
/// - [rating]: The rating of the stashpoint.
/// - [ratingCount]: The number of ratings received.
/// - [type]: The type of stashpoint.
/// - [locationName]: The name of the stashpoint location.
/// - [timezone]: The timezone of the stashpoint.
/// - [latitude]: The latitude coordinate of the stashpoint.
/// - [longitude]: The longitude coordinate of the stashpoint.
/// - [pricing]: The pricing structure of the stashpoint.
/// - [photos]: List of photo URLs associated with the stashpoint.
/// - [operatingHoursExceptions]: List of exceptions to regular operating hours.
/// - [operatingHours]: List of regular operating hours for the stashpoint.
///
/// Methods:
/// - [Stashpoint.fromJson]: Factory method to create a [Stashpoint] instance from JSON data.
///
/// Equality:
/// - The equality of two [Stashpoint] instances is based on all properties being equal.
///
/// String Conversion:
/// - [stringify] is set to true to enable readable string conversion of [Stashpoint] instances.

class Stashpoint extends Equatable {
  final bool isOpenLate;
  final double rating;
  final int ratingCount;
  final String type;
  final String locationName;
  final String timezone;
  final double latitude;
  final double longitude;
  final StashpointPricing pricing;
  final List<String> photos;
  final List<StashpointOperatingHoursException> operatingHoursExceptions;
  final List<StashpointOperatingHours> operatingHours;

  const Stashpoint({
    required this.isOpenLate,
    required this.rating,
    required this.ratingCount,
    required this.type,
    required this.locationName,
    required this.timezone,
    required this.photos,
    required this.latitude,
    required this.longitude,
    required this.pricing,
    required this.operatingHoursExceptions,
    required this.operatingHours,
  });

  factory Stashpoint.fromJson(Map<String, dynamic> map) {
    final locationName = map['location_name'] as String? ?? '';
    final ratingCount = map['rating_count'] as int? ?? 0;

    return Stashpoint(
      isOpenLate: map['open_late'] as bool? ?? false,
      rating: ratingCount == 0 ? 0.0 : map['rating'] as double? ?? 0.0,
      ratingCount: ratingCount,
      type: TextUtils.capitalizeEachWord(map['type'] as String? ?? '',
          delimiter: '_'),
      locationName: TextUtils.capitalizeEachWord(locationName.toLowerCase()),
      timezone: map['timezone'] as String? ?? 'Europe/London',
      photos: (map['photos'] as List<dynamic>?)?.cast<String>() ?? [],
      latitude: map['latitude'] as double? ?? 0.0,
      longitude: map['longitude'] as double? ?? 0.0,
      pricing: StashpointPricing.fromJson(
        map['pricing_structure'] as Map<String, dynamic>,
      ),
      operatingHoursExceptions:
          (map['opening_hours_exceptions'] as List<dynamic>)
              .map<StashpointOperatingHoursException>(
                (x) => StashpointOperatingHoursException.fromJson(
                    x as Map<String, dynamic>),
              )
              .toList(),
      operatingHours: (map['opening_hours'] as List<dynamic>)
          .map<StashpointOperatingHours>(
            (x) => StashpointOperatingHours.fromJson(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object> get props {
    return [
      isOpenLate,
      rating,
      ratingCount,
      type,
      locationName,
      timezone,
      latitude,
      longitude,
      pricing,
      photos,
      operatingHoursExceptions,
      operatingHours,
    ];
  }

  @override
  bool get stringify => true;
}
