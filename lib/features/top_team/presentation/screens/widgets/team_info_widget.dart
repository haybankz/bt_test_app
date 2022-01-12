import 'package:bt_test_app/features/top_team/presentation/app_provider.dart';
import 'package:bt_test_app/features/top_team/presentation/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamInfoWidget extends StatelessWidget {
  const TeamInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) {
        final team = provider.teamResponse.data!;
        return Column(
          children: [
            Text(
              team.name ?? "N/A",
              style: Theme.of(context).textTheme.headline4,
            ),
            const VerticalMargin(10),
            Text(
              team.address ?? "N/A",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const VerticalMargin(5),
            Text(team.phone ?? "N/A"),
            const VerticalMargin(5),
            Text(team.website ?? "N/A"),
            const VerticalMargin(5),
            Text(team.email ?? "N/A"),
          ],
        );
      },
    );
  }
}
