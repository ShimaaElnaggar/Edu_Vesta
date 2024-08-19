import 'package:edu_vesta/views/Login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const id = 'Home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Firebase Auth Status')),
            const SizedBox(height: 10),
            Center(
                child: Text('${FirebaseAuth.instance.currentUser?.email}'
                    ' \n ${FirebaseAuth.instance.currentUser?.displayName}')),
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshots.data != null) {
                    return const Text('Yor are Logged In');
                  }
                  return const Text('No user signed in.');
                }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginView.id);
              },
              child: const Text('go'),
            )
          ],
        ),
      ),
    );
  }
}
