abstract class ListItem{
  String get description;
}

class HeadingItem implements ListItem {
  final String description;

  HeadingItem(this.description);
}

class PlaceItem implements ListItem {
  final String placeId;
  final String description;

  PlaceItem(this.placeId, this.description);
}
