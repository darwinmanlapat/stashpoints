// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Represents the pricing details for a Stashpoint, including various fees and costs associated with the service.
class StashpointPricing extends Equatable {
  final String currency;
  final String currencySymbol;
  final num firstDayCost;
  final num extraDayCost;
  final num bookingFee;
  final num guaranteeFee;
  final num currencyMinorInMajor;

  /// Constructs an instance of [StashpointPricing].
  ///
  /// Parameters:
  /// - [currency]: The currency code (e.g., "USD", "EUR").
  /// - [currencySymbol]: The symbol of the currency (e.g., "$", "€").
  /// - [firstDayCost]: The cost for the first day.
  /// - [extraDayCost]: The cost for each additional day.
  /// - [bookingFee]: The fee for booking.
  /// - [guaranteeFee]: The guarantee fee.
  /// - [currencyMinorInMajor]: The minor currency units in a major currency unit (e.g., 100 for cents in a dollar).
  const StashpointPricing({
    required this.currency,
    required this.currencySymbol,
    required this.firstDayCost,
    required this.extraDayCost,
    required this.bookingFee,
    required this.guaranteeFee,
    required this.currencyMinorInMajor,
  });

  /// Creates an instance of [StashpointPricing] from a JSON map.
  ///
  /// Parameters:
  /// - [map]: The JSON map containing the data.
  ///
  /// Returns:
  /// - An instance of [StashpointPricing].
  factory StashpointPricing.fromJson(Map<String, dynamic> map) {
    return StashpointPricing(
      currency: map['ccy'] as String? ?? 'EUR',
      currencySymbol: map['ccy_symbol'] as String? ?? '€',
      firstDayCost: map['first_day_cost'] as num? ?? 0.0,
      extraDayCost: map['extra_day_cost'] as num? ?? 0.0,
      bookingFee: map['booking_fee'] as num? ?? 0.0,
      guaranteeFee: map['guarantee_fee'] as num? ?? 0.0,
      currencyMinorInMajor: map['ccy_minor_in_major'] as num? ?? 0.0,
    );
  }

  @override
  List<Object> get props => [
        currency,
        currencySymbol,
        firstDayCost,
        extraDayCost,
        bookingFee,
        guaranteeFee,
        currencyMinorInMajor,
      ];

  @override
  bool get stringify => true;

  StashpointPricing copyWith({
    String? currency,
    String? currencySymbol,
    num? firstDayCost,
    num? extraDayCost,
    num? bookingFee,
    num? guaranteeFee,
    num? currencyMinorInMajor,
  }) {
    return StashpointPricing(
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      firstDayCost: firstDayCost ?? this.firstDayCost,
      extraDayCost: extraDayCost ?? this.extraDayCost,
      bookingFee: bookingFee ?? this.bookingFee,
      guaranteeFee: guaranteeFee ?? this.guaranteeFee,
      currencyMinorInMajor: currencyMinorInMajor ?? this.currencyMinorInMajor,
    );
  }
}
