import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint_pricing.dart';
import 'package:stashpoints/features/stashpoints/presentation/providers/stashpoints_provider.dart';

class StashpointCard extends StatelessWidget {
  const StashpointCard({
    super.key,
    required this.stashpoint,
  });

  final Stashpoint stashpoint;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StashpointsNotifier>();
    final isStoreOpen = notifier.checkStoreAvailability(
        stashpoint.timezone, stashpoint.operatingHours);
    final operatingHours = notifier.getTodayOperatingHours(
        stashpoint.timezone, stashpoint.operatingHours);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD0D5DD),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _IconTitleSection(
              imageUrl: stashpoint.photos[0],
              type: stashpoint.type,
              locationName: stashpoint.locationName,
            ),
            const SizedBox(
              height: 12.0,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RateStatusDistanceSection(
                    rating: stashpoint.rating,
                    ratingCount: stashpoint.ratingCount,
                    isStoreOpen: isStoreOpen,
                    operatingHours: operatingHours,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  _BadgePriceSection(
                    isStoreOpen: isStoreOpen,
                    isOpenLate: stashpoint.isOpenLate,
                    pricing: stashpoint.pricing,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTitleSection extends StatelessWidget {
  const _IconTitleSection({
    required this.imageUrl,
    required this.type,
    required this.locationName,
  });

  final String imageUrl;
  final String type;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              color: const Color(0xFFEFF8FF),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: const Color(0xFFD1E9FF),
                width: 1,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Color(0xFF1D2939),
                  fontFamily: 'DM Sans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                locationName,
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontFamily: 'DM Sans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _RateStatusDistanceSection extends StatelessWidget {
  const _RateStatusDistanceSection({
    required this.rating,
    required this.ratingCount,
    required this.isStoreOpen,
    required this.operatingHours,
  });

  final double rating;
  final int ratingCount;
  final bool isStoreOpen;
  final String operatingHours;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 14,
              color: Color(0xFF000000),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              rating.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Color(0xFF1D2939),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '($ratingCount+)',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Color(0xFF1D2939),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(
              isStoreOpen ? 'Open' : 'Close',
              style: TextStyle(
                color: isStoreOpen
                    ? const Color(0xFF087443)
                    : const Color(0xFF800000),
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            if (operatingHours.isNotEmpty && isStoreOpen)
              Text(
                '($operatingHours)',
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          '1 min. from your location ',
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _BadgePriceSection extends StatelessWidget {
  const _BadgePriceSection({
    required this.pricing,
    required this.isOpenLate,
    required this.isStoreOpen,
  });

  final StashpointPricing pricing;
  final bool isOpenLate;
  final bool isStoreOpen;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StashpointsNotifier>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isOpenLate && isStoreOpen) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFEAE9F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFC5AEFF),
                width: 1, // border width
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode_outlined,
                    size: 16,
                    color: Color(0xFF5524D3),
                    weight: 1.2,
                  ), // Icon with size 16px
                  SizedBox(width: 4), // Space between icon and text
                  Text(
                    'Open till late',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5524D3),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.67,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          const SizedBox()
        ],
        Row(
          children: [
            Text(
              ' ${pricing.currencySymbol}${notifier.calculateRatePerDay(pricing)}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Color(0xFF1D2939),
              ),
            ),
            const Text(
              ' bag/day',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
