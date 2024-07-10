import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stashpoints/common/services/http_service.dart';
import 'package:stashpoints/features/stashpoints/data/stashpoints_repository.dart';
import 'package:stashpoints/features/stashpoints/presentation/providers/stashpoints_provider.dart';
import 'package:stashpoints/features/stashpoints/presentation/widgets/stashpoints_list_view.dart';

class StashpointsScreen extends StatelessWidget {
  const StashpointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (BuildContext context) => StashpointsRepository(
            client: context.read<HttpService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => StashpointsNotifier(
            repository: context.read<StashpointsRepository>(),
          ),
        )
      ],
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: StashpointsListView(),
          ),
        ),
      ),
    );
  }
}
