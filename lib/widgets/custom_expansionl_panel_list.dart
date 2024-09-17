import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/models/course.dart';
import 'package:flutter/material.dart';
import '../utils/image_utility.dart';
import '../views/Cart/payment_methods.dart';
import '../views/Courses/course_details_view.dart';
import 'custom_elevated_button.dart';

class CustomExpansionPanelList extends StatefulWidget {


  @override
  _CustomExpansionPanelListState createState() => _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    futureCall = FirebaseFirestore.instance.collection('courses').get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: futureCall,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error occurred: ${snapshot.error}'));
            }

            if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? true)) {
              return Center(child: Text('No courses found'));
            }

            var courses = List<Course>.from(snapshot.data!.docs
                .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                .toList());

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return ExpansionPanelList(
                  expansionCallback: (int panelIndex, bool isExpanded) {
                    setState(() {
                      courses[index].isExpanded = !isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(courses[index].title ?? ''),
                          subtitle: Text(courses[index].instructor?.name ?? ''),
                          leading: Image.network(
                            courses[index].image ?? ImageUtility.defaultCourse,
                            width: 50,
                            height: 50,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CourseDetailsView.id,
                              arguments: courses[index],
                            );
                          },
                        );
                      },
                      isExpanded: courses[index].isExpanded,
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              // Add cancel functionality
                            },
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 10),
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, PaymentMethodsView.id);
                            },
                            child: Text('Buy Now'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}