import 'package:bt_test_app/features/top_team/presentation/screens/widgets/team_info_widget.dart';
import 'package:bt_test_app/features/top_team/presentation/screens/widgets/team_logo_widget.dart';
import 'package:bt_test_app/features/top_team/presentation/ui_util.dart';
import 'package:flutter/material.dart';

class PortraitTeamView extends StatelessWidget {
  const PortraitTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: screenWidth(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const VerticalMargin(30),
            SizedBox(
              height: screenWidth(context, percent: 50),
              width: screenWidth(context, percent: 50),
              child: const TeamLogoWidget(),
            ),
            const VerticalMargin(30),
            const TeamInfoWidget(),
          ],
        ),
      ),
    );
  }
}
