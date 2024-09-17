import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/course/course_bloc.dart';
import '../../models/course.dart';
import '../../models/lecture.dart';
import '../../utils/app_enums.dart';
import '../../utils/color_utility.dart';
import '../expansion_list_tile_widget.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final void Function(Lecture) onLectureChosen;

  const CourseOptionsWidgets({
    required this.courseOption,
    required this.course,
    required this.onLectureChosen,
    Key? key,
  }) : super(key: key);

  @override
  _CourseOptionsWidgetsState createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  List<Lecture>? lectures;
  bool isLoading = false;
  Lecture? selectedLecture;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));
    lectures = await context.read<CourseBloc>().getLectures();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.lecture:
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (lectures == null || lectures!.isEmpty) {
          return const Center(
            child: Text('No lectures found'),
          );
        } else {
          return buildLecturesGrid();
        }

      case CourseOptions.download:
        return buildLecturesGrid(onTap: () async {
          String? url =
              await getLectureUrl(widget.course.id!, selectedLecture!.id!);
          if (url != null && url.isNotEmpty) {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              throw 'Could not launch $url';
            }
          } else {
            throw 'Lecture URL is empty';
          }
        });

      case CourseOptions.certificate:
        return Positioned(bottom: 20, child: buildCertificateContent());
      case CourseOptions.more:
        return SingleChildScrollView(child: buildMoreWidget());
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }

  Card buildCertificateContent() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Certification of Completion',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Jost',
                  color: ColorUtility.kBlue,
                )),
            SizedBox(height: 10),
            Text(
              'This certifies that ',
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: ColorUtility.darkGray,
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? '',
              style: TextStyle(
                  fontSize: 13.88,
                  fontWeight: FontWeight.w800,
                  color: ColorUtility.primary,
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              'Has Successfully Completed The Training Program, Entitled',
              style: TextStyle(
                  fontSize: 9.02,
                  fontWeight: FontWeight.w700,
                  color: ColorUtility.darkGray,
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              ' ${widget.course.title} ',
              style: TextStyle(
                  fontSize: 11.11,
                  fontWeight: FontWeight.w800,
                  color: ColorUtility.kBlue,
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              ' Issued on ${widget.course.createdDate} ',
              style: TextStyle(
                  fontSize: 9.02,
                  fontWeight: FontWeight.w700,
                  color: ColorUtility.darkGray,
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              ' ID: ${widget.course.id} ',
              style: TextStyle(
                  fontSize: 9.02,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF472D2D),
                  fontFamily: 'Mulish'),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.course.instructor?.name} ',
              style: TextStyle(
                  fontSize: 16.66,
                  fontWeight: FontWeight.w400,
                  color: ColorUtility.primary,
                  fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> getLectureUrl(String courseId, String lectureId) async {
    String lectureUrl;

    DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    DocumentSnapshot lectureSnapshot = await courseSnapshot.reference
        .collection('lectures')
        .doc(lectureId)
        .get();

    lectureUrl = lectureSnapshot['lecture_url'];

    return lectureUrl;
  }

  GridView buildLecturesGrid({void Function()? onTap}) {
    return GridView.count(
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(lectures!.length, (index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selectedLecture?.id == lectures![index].id
                ? ColorUtility.secondary
                : const Color(0xffE0E0E0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lectures![index].title ?? 'No Name',
                  style: TextStyle(
                    color: selectedLecture?.id == lectures![index].id
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.course.title ?? 'No Name',
                  style: TextStyle(
                    color: selectedLecture?.id == lectures![index].id
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  lectures![index].description ?? 'No Name',
                  style: TextStyle(
                    color: selectedLecture?.id == lectures![index].id
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lectures![index].description ?? 'No Name',
                      style: TextStyle(
                        color: selectedLecture?.id == lectures![index].id
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        widget.onLectureChosen(lectures![index]);
                        selectedLecture = lectures![index];
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.play_circle,
                        color: selectedLecture?.id == lectures![index].id
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Column buildMoreWidget() {
    return Column(
      children: [
        ExpansionListTile(
          title: 'About Instructor',
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: ColorUtility.secondary,
            ),
            title: Text('${widget.course.instructor?.name}'),
            subtitle: Text(
                'Experiences Years: ${widget.course.instructor?.yearsOfExperiences.toString()}'),
          ),
        ),
        ExpansionListTile(
          title: 'Course Resources',
          child: Center(
            child: Text(
              'No Resources Available',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        ExpansionListTile(
            title: 'Share this Course',
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
            )),
      ],
    );
  }
}
