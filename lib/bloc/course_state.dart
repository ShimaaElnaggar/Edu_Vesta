part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

class CourseOptionStateChanges extends CourseState {
  final CourseOptions courseOption;

  CourseOptionStateChanges(this.courseOption);
}


class LectureState extends CourseState {}

class LectureChosenState extends LectureState {
  final Lecture lecture;
  LectureChosenState(this.lecture);
}
