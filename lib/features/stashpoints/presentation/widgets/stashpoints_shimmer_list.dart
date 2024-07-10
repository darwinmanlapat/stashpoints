import 'package:flutter/material.dart';
import 'package:stashpoints/features/stashpoints/presentation/widgets/stashpoint_shimmer_card.dart';

class StashpointsShimmerList extends StatelessWidget {
  const StashpointsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return const Column(
          children: [
            StashpointShimmerCard(),
            SizedBox(
              height: 8,
            )
          ],
        );
      },
    );
  }
}
