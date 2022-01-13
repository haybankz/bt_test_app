import 'dart:io';

String reader(String name) {
  String json;
  try {
    // Runs correctly on C.I/IDE (non relative path)
    json = File('test/test_resources/json/$name').readAsStringSync();
  } catch (e) {
    // Flutter 'test' tool for some reason wants a relative path
    json = File('../test/test_resources/json/$name').readAsStringSync();
  }

  return json;
}
