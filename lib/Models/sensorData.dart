class SensorData {
  String? fuelLevel;
  String? batteryLevel;
  String? temperature;
  String? depthDistance;
  String? getLocation;
  SensorData({
    this.fuelLevel,
    this.batteryLevel,
    this.temperature,
    this.depthDistance,
    this.getLocation,
  });

  SensorData.fromMap(Map<String, dynamic> map) {
    fuelLevel = map['fuel'];
    batteryLevel = map['battery'];
  }
}
