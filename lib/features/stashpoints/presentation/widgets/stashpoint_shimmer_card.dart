import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StashpointShimmerCard extends StatelessWidget {
  const StashpointShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD0D5DD),
          width: 1,
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[200]!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFD1E9FF),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 125,
                        height: 28,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        width: 150,
                        height: 24,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
