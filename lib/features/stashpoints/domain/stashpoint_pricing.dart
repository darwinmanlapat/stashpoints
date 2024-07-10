import 'package:equatable/equatable.dart';

/// Represents the pricing details for a Stashpoint, including various fees and costs associated with the service.
///
/// This class provides a structured representation of pricing information, including currency details,
/// costs for the first day and extra days, booking fees, guarantee fees, and currency conversion details.
///
/// Properties:
/// - [currency]: The currency code (e.g., "USD", "EUR").
/// - [currencySymbol]: The symbol of the currency (e.g., "$", "€").
/// - [firstDayCost]: The cost for the first day.
/// - [extraDayCost]: The cost for each additional day.
/// - [bookingFee]: The fee for booking.
/// - [guaranteeFee]: The guarantee fee.
/// - [currencyMinorInMajor]: The minor currency units in a major currency unit (e.g., 100 for cents in a dollar).
///
/// Methods:
/// - [StashpointPricing.fromJson]: Factory method to create a [StashpointPricing] instance from JSON data.
/// - [copyWith]: Method to create a copy of the [StashpointPricing] instance with optional new values.
///
/// Equality:
/// - The equality of two [StashpointPricing] instances is based on all properties being equal.
///
/// String Conversion:
/// - [stringify] is set to true to enable readable string conversion of [StashpointPricing] instances.

class StashpointPricing extends Equatable {
  final String currency;
  final String currencySymbol;
  final num firstDayCost;
  final num extraDayCost;
  final num bookingFee;
  final num guaranteeFee;
  final num currencyMinorInMajor;

  const StashpointPricing({
    required this.currency,
    required this.currencySymbol,
    required this.firstDayCost,
    required this.extraDayCost,
    required this.bookingFee,
    required this.guaranteeFee,
    required this.currencyMinorInMajor,
  });

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
