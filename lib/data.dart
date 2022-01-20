class SensorData {
  String? name;
  String? data;
  String? icon;
  int? position;

  SensorData(
    this.position, {
    this.name,
    this.data,
    this.icon,
  });
}

List<SensorData> sensorInfo = [
  SensorData(1,
      name: "Location",
      data: 'Get Location',
      icon: 'assets/icons/google-maps.png'),
  SensorData(2, name: 'Battery', data: '100%', icon: 'assets/icons/battery.png'),
  SensorData(3,name: 'Fuel', data: '40 %', icon: 'assets/icons/petrol.png'),
  SensorData(4, name: 'Temperature', data: '24 °C', icon: 'assets/icons/temperature.png'),
  SensorData(5, name: 'Depth-Distance', data: '60 Cm', icon: 'assets/icons/text-spacing.png')
];
