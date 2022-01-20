class PlanetInfo {
  final int? position;
  final String? name;
  final String? iconImage;
  final String? description;
  final List<String>? images;

  PlanetInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.images,
  });
}

List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Location',
      iconImage: 'assets/icons/google-maps.png',
            ),
  PlanetInfo(2,
      name: 'Battery',
      iconImage: 'assets/icons/battery.png',
            ),
  PlanetInfo(3,
      name: 'Fuel',
      iconImage: 'assets/icons/petrol.png',
      
      ),
  PlanetInfo(4,
      name: 'Temperature',
      iconImage: 'assets/icons/temperature.png',
  
      ),
  PlanetInfo(5,
      name: 'Jupiter',
      iconImage: 'assets/icons/text-spacing.png',
      description:
          "The fifth planet from the sun, Jupiter is a giant gas world that is the most massive planet in our solar system — more than twice as massive as all the other planets combined, according to NASA. Its swirling clouds are colorful due to different types of trace gases. And a major feature in its swirling clouds is the Great Red Spot, a giant storm more than 10,000 miles wide. It has raged at more than 400 mph for the last 150 years, at least. Jupiter has a strong magnetic field, and with 75 moons, it looks a bit like a miniature solar system.",
      ),

];
