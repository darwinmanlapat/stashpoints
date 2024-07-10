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

  void nextPage() {
    if (hasNext) {
      _currentPage++;
      fetchItems();
    }
  }

  Future<void> onRefresh() async {
    _items = [];
    fetchItems();
  }

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

  bool checkStoreAvailability(
    String timezone,
    List<StashpointOperatingHours> operatingHours,
  ) {
    if (operatingHours.isEmpty) {
      return false;
    } else {
      // Get current date and time now
      final DateTime now = DateTime.now()
          .toUtc()
          .add(Duration(hours: _getTimezoneOffset(timezone)));

      // Get the current day of the week (0 for Monday, 6 for Sunday)
      final int currentDayOfWeek = now.weekday;

      // Get the current time as a formatted string "HH:mm:ss"
      final String currentTime = DateFormat('HH:mm:ss').format(now);

      // Find today's opening hours
      final todayOpeningHours = operatingHours.firstWhere(
        (hours) => hours.day == currentDayOfWeek,
      );

      // Check if current time is within opening hours
      if (currentTime.compareTo(todayOpeningHours.open) >= 0 &&
          currentTime.compareTo(todayOpeningHours.close) < 0) {
        return true;
      }
    }

    return false;
  }

  int _getTimezoneOffset(String timezone) {
    DateTime now = DateTime.now();
    Duration offset = DateTime.parse(now.toString()).timeZoneOffset;
    return offset.inHours;
  }

  String getTodayOperatingHours(
    String timezone,
    List<StashpointOperatingHours> operatingHours,
  ) {
    if (operatingHours.isEmpty) {
      return '';
    }

    // Get current date and time now
    final DateTime now = DateTime.now()
        .toUtc()
        .add(Duration(hours: _getTimezoneOffset(timezone)));

    // Get the current day of the week (0 for Monday, 6 for Sunday)
    final int currentDayOfWeek = now.weekday;

    // Find today's opening hours
    final todayOpeningHours = operatingHours.firstWhere(
      (hours) => hours.day == currentDayOfWeek,
    );

    return '${DateTimeUtils.formatTime(todayOpeningHours.open)} - ${DateTimeUtils.formatTime(todayOpeningHours.close)}';
  }
}
