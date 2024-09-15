import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/models/course.dart';
import 'package:edu_vesta/widgets/arrow_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/course/course_bloc.dart';
import '../../bloc/lecture/lecture_bloc.dart';
import '../../widgets/course_options_widget.dart';
import '../../widgets/lecture_chips_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailsView extends StatefulWidget {
  static const String id = 'course_details';
  final Course course;
  const CourseDetailsView({required this.course, super.key});

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  @override
  void initState() {
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    context.read<LectureBloc>().add(LectureEventInitial());
    super.initState();
  }

  bool applyChanges = false;

  void initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        applyChanges = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    initAnimation();

    super.didChangeDependencies();
  }

  String? urlVideo;
  YoutubePlayerController? controller;

  g({
    required String url,
  }) {
    final videoId = YoutubePlayer.convertUrlToId("$url");
    controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [

        BlocBuilder<LectureBloc, LectureState>(builder: (ctx, state) {
          var stateEx = state is LectureChosenState ? state : null;

          if (stateEx == null) {
            return const SizedBox.shrink();
          }
          g(url: stateEx.lecture.lectureUrl ?? '');
          return SizedBox(
            height: 250,
            child: stateEx.lecture.lectureUrl == null ||
                    stateEx.lecture.lectureUrl == ''
                ? const Center(
                    child: Text(
                    'Invalid Url',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
                : YoutubePlayer(
              controller: controller!,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: ProgressBarColors(
                    handleColor: Colors.white,
                    playedColor: Colors.red,
                  ),
                ),
                RemainingDuration(),
                PlaybackSpeedButton(),
              ],
            ),
          );
        }),
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              duration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,

              height:
                  applyChanges ? MediaQuery.sizeOf(context).height - 220 : null,
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
                        widget.course.instructor?.name ?? 'No Instructor Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const _BodyWidget()
                    ],
                  ),
                ),
              ),
            )),
        const Positioned(
          top: 20,
          left: 20,
          child: ArrowBack(),
        ),
      ],
    ));
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CourseBloc, CourseState>(builder: (ctx, state) {
        return Column(
          children: [
            LectureChipsWidget(
              selectedOption: (state is CourseOptionStateChanges)
                  ? state.courseOption
                  : null,
              onChanged: (courseOption) {
                context
                    .read<CourseBloc>()
                    .add(CourseOptionChosenEvent(courseOption));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: (state is CourseOptionStateChanges)
                    ? CourseOptionsWidgets(
                        course: context.read<CourseBloc>().course!,
                        courseOption: state.courseOption,
                        onLectureChosen: (lecture) async {
                          try {
                            final userProgressDoc = FirebaseFirestore.instance
                                .collection('course_user_progress')
                                .doc(FirebaseAuth.instance.currentUser!.uid);

                            final docSnapshot = await userProgressDoc.get();

                            if (docSnapshot.exists) {
                              await userProgressDoc.update({
                                context.read<CourseBloc>().course!.id!: FieldValue.increment(1)
                              });
                            } else {
                              await userProgressDoc.set({
                                context.read<CourseBloc>().course!.id!: 1
                              });
                            }
                          } catch (e) {
                            print('Error updating user progress: $e');
                          }
                          context
                              .read<LectureBloc>()
                              .add(LectureChosenEvent(lecture));
                        },
                      )
                    : const SizedBox.shrink())
          ],
        );
      }),
    );
  }
}
