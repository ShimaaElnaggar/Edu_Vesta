class Instructor {
  String? id;
  String? name;
  String? graduatedFrom;
  int? yearsOfExperiences;

  Instructor({this.id, this.name, this.graduatedFrom, this.yearsOfExperiences});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'graduatedFrom': graduatedFrom,
      'yearsOfExperiences': yearsOfExperiences
    };
  }

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
        id: json['id'],
        name: json['name'],
        graduatedFrom: json['graduatedFrom'],
        yearsOfExperiences: json['yearsOfExperiences']);
  }
}
