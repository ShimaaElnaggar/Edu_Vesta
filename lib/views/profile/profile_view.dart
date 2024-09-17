import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/profile/edit_user_name.dart';
import 'package:edu_vesta/widgets/custom_text_button.dart';
import 'package:edu_vesta/widgets/expansion_list_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../provider/theme_provider.dart';
import '../../services/preferences_services.dart';
import '../../widgets/view_header_item.dart';
import '../Login/login_view.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      profileImageUrl =
          PreferencesServices.prefs?.getString('profileImageUrl') ?? '';
    });
  }

  Future<void> _saveProfileImageUrl(String imageUrl) async {
    setState(() {
      profileImageUrl = imageUrl;
    });
    await PreferencesServices.prefs?.setString('profileImageUrl', imageUrl);
  }

  void _logout() async {
    setState(() {
      signingOut = true;
    });

    // Clear user data from shared preferences
    await PreferencesServices.prefs?.remove('profileImageUrl');
    await FirebaseAuth.instance.signOut();

    setState(() {
      signingOut = false;
    });

    Navigator.pushNamed(context, LoginView.id);
  }

  bool signingOut = false;
  String profileImageUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ViewHeaderItem(
              title: 'Profile',
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 57.5,
                  backgroundColor: ColorUtility.secondary,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl) as ImageProvider<Object>
                      : const NetworkImage(
                          'https://th.bing.com/th/id/OIP.sUtuDAldRIExk4haK9HB1AAAAA?rs=1&pid=ImgDetMain',
                        ),
                  child: ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          color: ColorUtility.primary,
                        );
                      },
                    ),
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
                            .pickFiles(type: FileType.image, withData: true);
                        if (imageResult != null) {
                          var storageRef = FirebaseStorage.instance
                              .ref('images/${imageResult.files.first.name}');
                          var uploadResult = await storageRef.putData(
                            imageResult.files.first.bytes!,
                            SettableMetadata(
                              contentType:
                                  'image/${imageResult.files.first.name.split('.').last}',
                            ),
                          );

                          if (uploadResult.state == TaskState.success) {
                            var downloadUrl =
                                await uploadResult.ref.getDownloadURL();
                            _saveProfileImageUrl(
                                downloadUrl); // Save the new image URL
                            print('>>>>>Image upload $downloadUrl');
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
                  ExpansionListTile(
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
                        Navigator.pushNamed(context, EditUserNameView.id);
                      },
                    ),
                  ),
                  ExpansionListTile(
                    title: 'Settings',
                    child: ListTile(
                      leading: Icon(
                        isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                        color: ColorUtility.secondary,
                      ),
                      title: Text(
                        isDarkTheme ? 'LightTheme' : 'DarkTheme',
                      ),
                      onTap: () {
                        ThemeModel themeModel =
                            Provider.of<ThemeModel>(context, listen: false);
                        themeModel.toggleMode();
                      },
                    ),
                  ),
                  const ExpansionListTile(
                    title: 'About Us',
                    child: Text(
                      ' Edu vesta App  is a specialized application \n '
                      'designed to facilitate learning and education.\n '
                      'This apps provide educational content,\n '
                      'resources, and interactive learning experiences to users',
                      style: TextStyle(
                        color: ColorUtility.darkGray,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    onPressed: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
