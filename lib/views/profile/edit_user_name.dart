import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cubit/auth_cubit.dart';
import '../../services/preferences_services.dart';
import '../../utils/color_utility.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class EditUserNameView extends StatefulWidget {
  static const id = 'Edit_User_Name';
  const EditUserNameView({super.key});

  @override
  State<EditUserNameView> createState() => _EditUserNameViewState();
}

class _EditUserNameViewState extends State<EditUserNameView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _editUserNameController;
  Future<void> _saveUserNameToPrefs(String userName) async {
    await PreferencesServices.prefs?.setString('user_name', userName);
  }

  Future<void> _init() async {
    String userName = await PreferencesServices.prefs?.getString('user_name') ?? '';
    setState(() {
      _editUserNameController.text = userName;
    });
  }

  @override
  void initState() {
    super.initState();
    _editUserNameController = TextEditingController();
    _init();
  }

  @override
  void dispose() {
    _editUserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Edit User Name',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 185,
        ),
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _editUserNameController,
                    hint: 'Edit UserName',
                    label: 'UserName',
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: ColorUtility.secondary,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final authCubit = context.read<AuthCubit>();
                              await authCubit.updateDisplayName(
                                  newName: _editUserNameController.text,
                                  context: context);

                              await _saveUserNameToPrefs(
                                  _editUserNameController.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
