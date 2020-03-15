import 'package:concordi_around/model/building.dart';
import 'package:concordi_around/model/coordinate.dart';

import 'data_points.dart';

Map<String, Building> buildings = {
  //SGW
  'EV': Building("Engineering, Computer Science and Visual Arts",
      coordinate: Coordinate(45.49558, -73.57801, "0", "EV", "SGW"),
      polygon: bounds['EV']),

  'JMSB': Building("John Molson School of Business",
      coordinate: Coordinate(45.4954, -73.57909, "0", "JMSB", "SGW"),
      polygon: bounds['JMSB']),

  'GM': Building("Pavillon Guy-De Maisonneuve",
      coordinate: Coordinate(45.49589, -73.5785, "0", "GM", "SGW"),
      polygon: bounds['GM']),

  'JW': Building("J.W McConell Building",
      coordinate: Coordinate(45.496865, -73.578041, "0", "JW", "SGW"),
      polygon: bounds['JW']),

  'H': Building('Henry F. Hall',
      coordinate: Coordinate(45.49726, -73.57893, "0", "H", "SGW")),

  //LOYOLA
  'VL': Building('Vanier Library',
      coordinate:
          Coordinate(45.459053, -73.638683, "0", "Vanier Library", "LOY"),
      polygon: bounds['VL']),

  'FC': Building('F.C Smith Building',
      coordinate: Coordinate(45.458563, -73.639277, "0", "FC", "LOY"),
      polygon: bounds['FC']),

  'PB': Building('Psychology Building',
      coordinate: Coordinate(45.459068, -73.640577, "0", "PB", "LOY"),
      polygon: bounds['PB']),

  'CJ': Building('Communication Studies and Journalism Building',
      coordinate: Coordinate(45.457523, -73.640375, "0", "CJ", "LOY"),
      polygon: bounds['CJ']),

  'SP': Building('Richard J. Renaud Science Complex',
      coordinate: Coordinate(45.457832, -73.641494, "0", "SP", "LOY"),
      polygon: bounds['SP']),

  'CB': Building('Central Building',
      coordinate: Coordinate(45.458306, -73.640352, "0", "CB", "LOY"),
      polygon: bounds['CB']),

  'PSB': Building('Physical Service Building',
      coordinate: Coordinate(45.459647, -73.639784, "0", "PSB", "LOY"),
      polygon: bounds['PSB']),
};
