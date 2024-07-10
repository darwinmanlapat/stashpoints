import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stashpoints/features/stashpoints/presentation/providers/stashpoints_provider.dart';
import 'package:stashpoints/features/stashpoints/presentation/widgets/stashpoint_card.dart';
import 'package:stashpoints/features/stashpoints/presentation/widgets/stashpoints_shimmer_list.dart';

class StashpointsListView extends StatefulWidget {
  const StashpointsListView({super.key});

  @override
  State<StashpointsListView> createState() => _StashpointsListViewState();
}

class _StashpointsListViewState extends State<StashpointsListView> {
  late StashpointsNotifier _stashpointsNotifier;
  final ScrollController _listViewScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stashpointsNotifier = context.read<StashpointsNotifier>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _stashpointsNotifier.fetchItems();
    });

    _listViewScrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_listViewScrollController.position.pixels ==
        _listViewScrollController.position.maxScrollExtent) {
      _stashpointsNotifier.nextPage();
    }
  }

  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StashpointsNotifier>();
    final stashpoints = notifier.items;

    if (notifier.hasError) {
      return Center(
        child: Text(notifier.errorMessage!),
      );
    }

    return notifier.isLoading && stashpoints.isEmpty
        ? const StashpointsShimmerList()
        : RefreshIndicator(
            onRefresh: notifier.onRefresh,
            child: ListView.builder(
              controller: _listViewScrollController,
              itemCount: notifier.hasNext
                  ? stashpoints.length + 1
                  : stashpoints.length,
              itemBuilder: (context, index) {
                if (index < stashpoints.length) {
                  return Column(
                    children: [
                      StashpointCard(
                        key: ValueKey(stashpoints[index]),
                        stashpoint: stashpoints[index],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          );
  }
}
