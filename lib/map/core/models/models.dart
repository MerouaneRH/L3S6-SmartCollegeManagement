class Light {
  late String location;
  late String name;
  late bool status;
  late List<double> position;
  late int tile;

  Light.fromMap(Map data) {
    location = data['location'] ?? 'No location.';
    name = data['name'] ?? 'No name.';
    status = data['status'] ?? false;
    position = data['position'] ?? [0.0];
    tile = data['tile'] ?? 0;
  }
}