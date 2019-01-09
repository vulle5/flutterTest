void main() {
  PowerGrid grid = new PowerGrid();
  NuclearPlant nuclear = new NuclearPlant();
  SolarPlant solar = new SolarPlant();
  
  grid.addPlant(nuclear);
  grid.addPlant(solar);
}

class PowerGrid {
  // This class now has List that expects abstract class PowerPlant
  List<PowerPlant> connectedPlants = [];
  
  addPlant(PowerPlant plant) {
    bool conformation = plant.turnOn('5 hours');
    if (conformation) {
    	connectedPlants.add(plant);
    } else {
      print('plant failed to turn on');
    }
  }
}

// Abstract class
// Anything that implements PowerPlant
abstract class PowerPlant {
  // Inside the func body you define what implemented
  // class has to have to qualify as a PowerPlant

  // Has to have implementation of instance variable costOfEnergy
  int costOfEnergy;

  // Here we say that class has to have method turnOn that accepts
  // one String and returns a bool
  bool turnOn(String duration);
}

class NuclearPlant implements PowerPlant {
  int costOfEnergy;
  // Variable name does not matter
  // Type and number of arguments are the only things that matter
  bool turnOn(String timeToStayOn) {
    print("i'm a nuclear plant turning on for $timeToStayOn");
    return true;
  }

  meltdown() {
    print('BLOWS UP!!');
  }
}

class SolarPlant implements PowerPlant {
  int costOfEnergy;
  
  bool turnOn(String howLongOn) {
    print("i'm a solar plant turning on for $howLongOn");
    return false;
  }
}