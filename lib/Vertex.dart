 import 'dart:collection';
 import 'package:latlong/latlong.dart';


class Vertex  extends LinkedListEntry<Vertex>{

    String id;
    String name;
    LatLng point;



    Vertex(this.id, this.name, this.point) {
        this.id = id;
        this.name = name;
        this.point = point;
    }
   getId() {
        return id;
    }

    getName() {
        return name;
    }

    //   @override

    //  int hashCode() {
    //     final int prime = 31;
    //     int result = 1;
    //     result = prime * result + ((id == null) ? 0 : id.hashCode);
    //     return result;
    // }

     bool equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
       
        Vertex other = obj as Vertex;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (id != (other.id))
            return false;
        return true;
    }

    
     String toString() {
        return name;
    }

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return super == other;
  }

}