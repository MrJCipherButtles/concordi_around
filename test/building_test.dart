import 'package:concordi_around/models/building.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Building instantiate with the right value', () {
    final building = Building("Henry", "H", "none", "1456", "Maisonneuve");

    final String t = building.toString();

    expect(t, "H : Henry");
  });
}