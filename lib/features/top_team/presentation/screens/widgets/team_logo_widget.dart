import 'package:bt_test_app/features/top_team/presentation/app_provider.dart';
import 'package:bt_test_app/features/top_team/presentation/file_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TeamLogoWidget extends StatelessWidget {
  const TeamLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (_, provider, __) {
      final imageUrl = provider.teamResponse.data!.crestUrl!;
      final fileExt = FileUtil.getFileExtension(imageUrl);
      switch (fileExt) {
        case FileExtension.jpeg:
        case FileExtension.jpg:
        case FileExtension.png:
          return Image.network(
            imageUrl,
            errorBuilder: (ctx, __, err) => Center(
              child: Text("Unable to load image: $imageUrl"),
            ),
            fit: BoxFit.fill,
          );

        case FileExtension.svg:
          return SvgPicture.network(
            provider.teamResponse.data!.crestUrl!,
            fit: BoxFit.fill,
            placeholderBuilder: (ctx) => Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(50),
              child: const CircularProgressIndicator(),
            ),
          );

        case null:
        default:
          return const Text("Unknown image type");
      }
    });
  }
}
