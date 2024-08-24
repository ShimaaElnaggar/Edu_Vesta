class Lecture {
  String? id;
  String? title;
  String? description;
  int? duration;
  String? lectureUrl;
  int? sort;
  List<String>? watchedUsers;

  Lecture({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.lectureUrl,
    this.sort,
    this.watchedUsers,

});

  factory Lecture.fromJson(Map<String, dynamic> data) {
    return Lecture(
    id : data['id'],
    title : data['title'],
    description : data['description'],
    duration : data['duration'],
    lectureUrl : data['lecture_url'],
    sort : data['sort'],
    watchedUsers :
    data['watched_users'] != null ? List.from(data['watched_users']) : null,);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['lecture_url'] = lectureUrl;
    data['sort'] = sort;
    data['watched_users'] = watchedUsers;
    return data;
  }
}