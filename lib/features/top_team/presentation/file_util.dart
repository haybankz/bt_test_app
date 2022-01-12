import 'package:bt_test_app/features/top_team/data/export.dart';

enum FileExtension { jpeg, jpg, png, svg }

final fileExtensionValues = EnumValues({
  "jpeg": FileExtension.jpeg,
  "jpg": FileExtension.jpg,
  "png": FileExtension.png,
  "svg": FileExtension.svg
});

class FileUtil {
  static FileExtension? getFileExtension(String imageUrl) {
    final extensionString = imageUrl.split(".").last;
    return fileExtensionValues.map[extensionString];
  }
}
