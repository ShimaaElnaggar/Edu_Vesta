
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/profile/edit_user_name.dart';
import 'package:edu_vesta/widgets/cart_Icon.dart';
import 'package:edu_vesta/widgets/custom_text_button.dart';
import 'package:edu_vesta/widgets/expansion_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }
  String profileImageUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: isDarkTheme ? darkTheme : lightTheme,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: ColorUtility.midBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    CartIcon(),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    CircleAvatar(
                  radius: 57.5,
                      backgroundImage:profileImageUrl.isNotEmpty ?
                NetworkImage(profileImageUrl) :
              const NetworkImage(
              'https://th.bing.com/th/id/OIP.sUtuDAldRIExk4haK9HB1AAAAA?rs=1&pid=ImgDetMain',
          ),
                      ),

                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: ColorUtility.primary),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            var imageResult = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.image, withData: true);
                            if (imageResult != null) {
                              var storageRef = FirebaseStorage.instance.ref(
                                  'images/${imageResult.files.first.name}');
                              var uploadResult = await storageRef.putData(
                                  imageResult.files.first.bytes!,
                                  SettableMetadata(
                                    contentType:
                                        'image/${imageResult.files.first.name.split('.').last}',
                                  ));

                              if (uploadResult.state == TaskState.success) {
                                var downloadUrl =
                                    await uploadResult.ref.getDownloadURL();
                                setState(() {
                                  profileImageUrl = downloadUrl;
                                });
                                print('>>>>>Image upload$downloadUrl');
                              }
                            } else {
                              print('No file selected');
                            }
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                            color: ColorUtility.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? '',
                  style: const TextStyle(
                      color: ColorUtility.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                const SizedBox(height: 5),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                  style: const TextStyle(
                      color: ColorUtility.darkGray,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  child: ListView(
                    children: [
                      ExpansionListWidget(
                        title: 'Edit',
                        child: ListTile(
                          leading: const Icon(
                            Icons.edit,
                            color: ColorUtility.secondary,
                          ),
                          title: const Text(
                            'Edit User Name',
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, EditUserNameView.id);
                          },
                        ),
                      ),
                      ExpansionListWidget(
                        title: 'Settings',
                        child: ListTile(
                          leading: Icon(
                            isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                            color: ColorUtility.secondary,
                          ),
                          title: Text(
                            isDarkTheme ? 'Light Theme ' : 'DarkTheme',
                          ),
                          onTap: toggleTheme,
                        ),
                      ),
                      const ExpansionListWidget(
                        title: 'About Us',
                        child: Text(
                          ' Edu vesta App  is a specialized application \n designed to facilitate learning and education.\n This apps provide educational content,\n resources, and interactive learning experiences to users',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextButton(
                          label: 'Logout',
                          textStyle: const TextStyle(
                            color: Color(0XFFEA4335),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.pop(context);
                            });
                          }),
                    ],
                  ),
                ),

              ],

            ),
          ),
        ),
      )
    );

  }
}
