library concordi_around.globals;

/* 
disabilityMode is to save the state of the toggle from the app drawer.
it should be removed once a config file is used to save the user preferences
*/
bool disabilityMode = false;

//Available modes are: [driving, walking, bicycling, transit] respectively
//Default always set to 'driving'
List<bool> travelMode = [true, false, false, false];
