class Direction {
  List<Routes> routes;

  Direction({this.routes});

  Direction.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = new List<Routes>();
      json['routes'].forEach((v) {
        routes.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  String summary;
  List<Legs> legs;
  Duration duration;
  Duration distance;
  LocationModel startLocation;
  LocationModel endLocation;
  String startAddress;
  String endAddress;

  Routes(
      {this.summary,
      this.legs,
      this.duration,
      this.distance,
      this.startLocation,
      this.endLocation,
      this.startAddress,
      this.endAddress});

  Routes.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    if (json['legs'] != null) {
      legs = new List<Legs>();
      json['legs'].forEach((v) {
        legs.add(new Legs.fromJson(v));
      });
    }
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    distance = json['distance'] != null
        ? new Duration.fromJson(json['distance'])
        : null;
    startLocation = json['start_location'] != null
        ? new LocationModel.fromJson(json['start_location'])
        : null;
    endLocation = json['end_location'] != null
        ? new LocationModel.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    endAddress = json['end_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    if (this.legs != null) {
      data['legs'] = this.legs.map((v) => v.toJson()).toList();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    if (this.distance != null) {
      data['distance'] = this.distance.toJson();
    }
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation.toJson();
    }
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation.toJson();
    }
    data['start_address'] = this.startAddress;
    data['end_address'] = this.endAddress;
    return data;
  }
}

class Legs {
  List<Steps> steps;

  Legs({this.steps});

  Legs.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  String travelMode;
  LocationModel startLocation;
  LocationModel endLocation;
  PolylineModel polyline;
  Duration duration;

  Steps(
      {this.travelMode,
      this.startLocation,
      this.endLocation,
      this.polyline,
      this.duration});

  Steps.fromJson(Map<String, dynamic> json) {
    travelMode = json['travel_mode'];
    startLocation = json['start_location'] != null
        ? new LocationModel.fromJson(json['start_location'])
        : null;
    endLocation = json['end_location'] != null
        ? new LocationModel.fromJson(json['end_location'])
        : null;
    polyline = json['polyline'] != null
        ? new PolylineModel.fromJson(json['polyline'])
        : null;
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travel_mode'] = this.travelMode;
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation.toJson();
    }
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation.toJson();
    }
    if (this.polyline != null) {
      data['polyline'] = this.polyline.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    return data;
  }
}

class LocationModel {
  double lat;
  double lng;

  LocationModel({this.lat, this.lng});

  LocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class PolylineModel {
  String points;

  PolylineModel({this.points});

  PolylineModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }
}

class Duration {
  int value;
  String text;

  Duration({this.value, this.text});

  Duration.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}