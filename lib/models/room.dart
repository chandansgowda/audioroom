class AudioRoom {
  AudioRoom({
    required this.name,
    required this.description,
  });
  late final String name;
  late final String description;

  AudioRoom.fromJson(Map<String, dynamic> json){
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    return _data;
  }
}