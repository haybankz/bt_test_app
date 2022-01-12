import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/presentation/app_provider.dart';
import 'package:bt_test_app/features/top_team/presentation/screens/landscapes/landscape_team_view.dart';
import 'package:bt_test_app/features/top_team/presentation/screens/portaits/portrait_team_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppProvider _provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _provider.loadTopTeam();
    });
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildView(),
      floatingActionButton: Consumer<AppProvider>(
        builder: (_, model, __) => FloatingActionButton(
          onPressed: () async {
            model.getTeamDetails(99);
          },
          tooltip: 'Refresh',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget _buildView() {
    if (_provider.matchesResponse.status == Status.loading ||
        _provider.teamResponse.status == Status.loading) {
      return const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_provider.matchesResponse.status == Status.error ||
        _provider.teamResponse.status == Status.error) {
      final error = _provider.matchesResponse.message ??
          _provider.teamResponse.message ??
          "Unable to get error message";

      return Center(child: Text(error));
    } else if (_provider.matchesResponse.data == null ||
        _provider.teamResponse.data == null) {
      return Container();
    }

    return OrientationBuilder(
        builder: (ctx, orientation) => orientation == Orientation.portrait
            ? const PortraitTeamView()
            : const LandscapeTeamView());
  }
}
