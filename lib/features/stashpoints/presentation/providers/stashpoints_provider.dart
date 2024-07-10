import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stashpoints/common/exceptions/resource_not_found_exception.dart';
import 'package:stashpoints/common/utils/date_time_utils.dart';
import 'package:stashpoints/features/stashpoints/data/stashpoints_repository.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_operating_hours.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_pricing.dart';

class StashpointsNotifier with ChangeNotifier {
  StashpointsNotifier({
    required StashpointsRepository repository,
  }) : _repository = repository;

  final StashpointsRepository _repository;
  List<Stashpoint> _items = [];
  int _currentPage = 1;
  String? _errorMessage;
  String? _storeOpeningHours;
  bool _hasError = false;
  bool _hasNext = true;
  bool _isLoading = false;

  List<Stashpoint> get items => _items;

  String? get errorMessage => _errorMessage;

  String? get storeOpeningHours => _storeOpeningHours;

  bool get hasError => _hasError;

  bool get isLoading => _isLoading;

  bool get hasNext => _hasNext;

  /// Fetches stashpoints from the repository.
  Future<void> fetchItems() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final newItems = await _repository.fetchStashpoints(page: _currentPage);

      if (newItems.isEmpty) {
        _hasNext = false;
      } else {
        _hasNext = true;
        _items.addAll(newItems);
      }
    } catch (e) {
      if (e is! ResourceNotFoundException) {
        _hasError = true;
        _errorMessage = 'Failed to retrieve data';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Moves to the next page of stashpoints if available.
  void nextPage() {
    if (hasNext) {
      _currentPage++;
      fetchItems();
    }
  }

  /// Refreshes the list of stashpoints.
  Future<void> onRefresh() async {
    _items = [];
    fetchItems();
  }

  /// Calculates the rate per day based on pricing and number of days.
  double calculateRatePerDay(StashpointPricing pricing, {int days = 1}) {
    if (days <= 0) {
      return 0.0;
    }
    // Convert costs from minor units to major units
    final firstDayCost = pricing.firstDayCost / pricing.currencyMinorInMajor;
    final extraDayCost = pricing.extraDayCost / pricing.currencyMinorInMajor;
    final bookingFee = pricing.bookingFee / pricing.currencyMinorInMajor;
    final guaranteeFee = pricing.guaranteeFee / pricing.currencyMinorInMajor;

    // Calculate the total cost
    final totalCost =
        firstDayCost + (extraDayCost * (days - 1)) + bookingFee + guaranteeFee;

    // Calculate the rate per day
    double ratePerDay = totalCost / days;

    ratePerDay = double.parse(ratePerDay.toStringAsFixed(2));

    return ratePerDay;
  }

  /// Checks if the store is currently open.
  bool checkStoreAvailability(
    String timezone,
    List<StashpointOperatingHours> operatingHours,
  ) {
    if (operatingHours.isEmpty) return false;

    final DateTime now = _getCurrentTimeInTimezone(timezone);
    final int currentDayOfWeek = now.weekday;
    final String currentTime = DateFormat('HH:mm:ss').format(now);

    final todayOpeningHours = operatingHours.firstWhere(
      (hours) => hours.day == currentDayOfWeek,
      orElse: () => const StashpointOperatingHours(
        open: '00:00:00',
        close: '00:00:00',
        day: -1,
      ),
    );

    return currentTime.compareTo(todayOpeningHours.open) >= 0 &&
        currentTime.compareTo(todayOpeningHours.close) < 0;
  }

  /// Retrieves today's operating hours formatted as a string.
  String getTodayOperatingHours(
    String timezone,
    List<StashpointOperatingHours> operatingHours,
  ) {
    if (operatingHours.isEmpty) return '';

    final DateTime now = _getCurrentTimeInTimezone(timezone);
    final int currentDayOfWeek = now.weekday;

    final todayOpeningHours = operatingHours.firstWhere(
      (hours) => hours.day == currentDayOfWeek,
      orElse: () => const StashpointOperatingHours(
        open: '00:00:00',
        close: '00:00:00',
        day: -1,
      ),
    );

    return '${DateTimeUtils.formatTime(todayOpeningHours.open)} - ${DateTimeUtils.formatTime(todayOpeningHours.close)}';
  }

  /// Converts the current UTC time to the specified timezone.
  DateTime _getCurrentTimeInTimezone(String timezone) {
    final DateTime now = DateTime.now().toUtc();
    final int offsetHours = _getTimezoneOffset(timezone);
    return now.add(Duration(hours: offsetHours));
  }

  /// Retrieves the timezone offset in hours.
  int _getTimezoneOffset(String timezone) {
    final DateTime now = DateTime.now();
    final Duration offset = DateTime.parse(now.toString()).timeZoneOffset;
    return offset.inHours;
  }

  // Function to calculate the distance between two points using Haversine formula
  double calculateDistance(double stashpointLat, double stashpointLng) {
    // Assume that the location of the user
    const double userLat = 51.5074; // London coordinates
    const double userLng = -0.1278;

    const R = 6371; // Radius of the Earth in km
    var dLat = _degToRad(userLat - stashpointLat);
    var dLon = _degToRad(userLng - stashpointLng);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(stashpointLat)) *
            cos(_degToRad(userLat)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = R * c; // Distance in km
    return distance;
  }

  // Helper function to convert degrees to radians
  double _degToRad(double deg) {
    return deg * (pi / 180);
  }

  // Helper function to calculate travel time in minutes
  double calculateTravelTime(double distance, double speed) {
    // speed should be in km/h
    return (distance / speed) * 60;
  }
}
