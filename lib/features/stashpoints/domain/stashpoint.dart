import 'package:equatable/equatable.dart';
import 'package:stashpoints/common/utils/text_utils.dart';

import 'package:stashpoints/features/stashpoints/domain/stashpoint_operating_hours.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_operating_hours_exception.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_pricing.dart';

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
