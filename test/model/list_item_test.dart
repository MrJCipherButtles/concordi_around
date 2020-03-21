import 'package:concordi_around/model/list_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('List Item Unit Test', () {
    test('Heading Item unit test', () {
      HeadingItem headingItem = HeadingItem('List Item Test Description');
      expect(headingItem.description, 'List Item Test Description');
    });

    test('Place Item unit test', () {
      PlaceItem placeItem =
          PlaceItem('Place Item Test placeId', 'Place Item Test description');
      expect(placeItem.placeId, 'Place Item Test placeId');
      expect(placeItem.description, 'Place Item Test description');
    });
  });
}
