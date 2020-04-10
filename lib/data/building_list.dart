import 'package:concordi_around/model/building.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'data_points.dart';

Map<String, Building> buildings = {
  //SGW
  'EV': Building("Engineering, Computer Science and Visual Arts",
      coordinate: Coordinate(45.495559, -73.578054, "0", "EV", "SGW"),
      polygon: bounds['EV']),

  'JMSB': Building("John Molson School of Business",
      coordinate: Coordinate(45.495266, -73.578938, "0", "JMSB", "SGW"),
      polygon: bounds['JMSB']),

  'GM': Building("Pavillon Guy-De Maisonneuve",
      coordinate: Coordinate(45.495860, -73.578791, "0", "GM", "SGW"),
      polygon: bounds['GM']),

  'JW': Building("J.W McConell Building",
      coordinate: Coordinate(45.496865, -73.578041, "0", "JW", "SGW"),
      polygon: bounds['JW']),

  'LB': Building("Webster Library Building",
      coordinate: Coordinate(45.496817, -73.577915, "0", "LB", "SGW"),
      polygon: bounds['LB']),

  'H': Building('Henry F. Hall',
      coordinate: Coordinate(45.497250, -73.578955, "0", "H", "SGW"),
      polygon: bounds['H']),

  //LOYOLA
  'VL': Building('Vanier Library',
      coordinate:
          Coordinate(45.458950, -73.638552, "0", "Vanier Library", "LOY"),
      polygon: bounds['VL']),

  'FC': Building('F.C Smith Building',
      coordinate: Coordinate(45.4585971, -73.6405597, "0", "FC", "LOY"),
      polygon: bounds['FC']),

  'PB': Building('Psychology Building',
      coordinate: Coordinate(45.458978, -73.640472, "0", "PB", "LOY"),
      polygon: bounds['PB']),

  'CJ': Building('Communication Studies and Journalism Building',
      coordinate: Coordinate(45.457457, -73.640378, "0", "CJ", "LOY"),
      polygon: bounds['CJ']),

  'SP': Building('Richard J. Renaud Science Complex',
      coordinate: Coordinate(45.457847, -73.641489, "0", "SP", "LOY"),
      polygon: bounds['SP']),

  'CB': Building('Central Building',
      coordinate: Coordinate(45.458302, -73.640348, "0", "CB", "LOY"),
      polygon: bounds['CB']),

  'PSB': Building('Physical Service Building',
      coordinate: Coordinate(45.4596546, -73.639771, "0", "PSB", "LOY"),
      polygon: bounds['PSB']),
};
