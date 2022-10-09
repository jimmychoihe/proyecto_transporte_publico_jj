import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: UserInfoLogout(),
    );
  }
}

class UserInfoLogout extends StatefulWidget {
  const UserInfoLogout({super.key});

  @override
  State<UserInfoLogout> createState() => _UserInfoLogoutState();
}

class _UserInfoLogoutState extends State<UserInfoLogout> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Signed In as',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            user.email!,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(
              Icons.arrow_back,
              size: 32,
            ),
            label: Text(
              'Sign Out',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
