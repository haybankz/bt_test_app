import 'package:bt_test_app/features/top_team/presentation/screens/widgets/team_info_widget.dart';
import 'package:bt_test_app/features/top_team/presentation/screens/widgets/team_logo_widget.dart';
import 'package:bt_test_app/features/top_team/presentation/ui_util.dart';
import 'package:flutter/material.dart';

class LandscapeTeamView extends StatelessWidget {
  const LandscapeTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context),
      child: Row(
        children: [
          const HorizontalMargin(30),
          SizedBox(
            height: screenHeight(context, percent: 60),
            width: screenHeight(context, percent: 60),
            child: const TeamLogoWidget(),
          ),
          const HorizontalMargin(30),
          const SingleChildScrollView(child: TeamInfoWidget()),
        ],
      ),
    );
  }
}
