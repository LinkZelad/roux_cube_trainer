import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android manifest allows loading the cubing.js player', () {
    final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(manifest, contains('android.permission.INTERNET'));
  });
}
