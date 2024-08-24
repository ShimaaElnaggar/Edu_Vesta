import 'package:edu_vesta/models/course.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_box/video_box.dart';

import '../../bloc/course_bloc.dart';
import '../../widgets/course_options_widget.dart';
import '../../widgets/lecture_chips_widget.dart';

class CourseDetailsView extends StatefulWidget {
  static const id = 'Course Details';
  final Course course;
  const CourseDetailsView({required this.course, super.key});

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  double? height;

  @override
  void initState() {
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
            if (state is! LectureState) return const SizedBox();
            var stateEx = state is LectureChosenState ? state : null;
            return SizedBox(
              height: 250,
              child: VideoBox(
                controller: VideoController(
                    source: VideoPlayerController.networkUrl(
                        Uri.parse(stateEx!.lecture.lectureUrl!))),
              ),
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<CourseBloc, CourseState>(
              buildWhen: (previous, current) => current is LectureState,
              builder: (context, state) {
                var applyChanges = (state is LectureChosenState) ? true : false;
                return AnimatedContainer(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: applyChanges
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))
                          : null),
                  duration: const Duration(seconds: 3),
                  alignment: Alignment.bottomCenter,
                  height: applyChanges
                      ? MediaQuery.sizeOf(context).height - 220
                      : null,
                  curve: Curves.easeInOut,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.course.title ?? 'No Name',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.course.instructor?.name ??
                                'No Instructor Name',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: BlocBuilder<CourseBloc, CourseState>(
                                buildWhen: (previous, current) => false,
                                builder: (ctx, state) {
                                  if (kDebugMode) {
                                    print('>>>>>>>>build state');
                                  }
                                  return Column(
                                    children: [
                                      LectureChipsWidget(
                                        selectedOption:
                                            (state is CourseOptionStateChanges)
                                                ? state.courseOption
                                                : null,
                                        onChanged: (courseOption) {
                                          context.read<CourseBloc>().add(
                                              CourseOptionChosenEvent(
                                                  courseOption));
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: (state
                                                  is CourseOptionStateChanges)
                                              ? CourseOptionsWidgets(
                                                  course: context
                                                      .read<CourseBloc>()
                                                      .course!,
                                                  courseOption:
                                                      state.courseOption,
                                                  onLectureChosen: (lecture) {
                                                    context
                                                        .read<CourseBloc>()
                                                        .add(LectureChosenEvent(
                                                            lecture));
                                                  },
                                                )
                                              : const SizedBox.shrink())
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
