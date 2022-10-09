import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

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
            'Ingresado como: ',
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

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(37.773972, -122.431297),
//     zoom: 11.5,
//   );

//   GoogleMapController? _googleMapController;

//   @override
//   void dispose() {
//     _googleMapController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: _initialCameraPosition,
//         onMapCreated: (controller) => _googleMapController = controller,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _googleMapController?.animateCamera(
//           CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: Icon(Icons.center_focus_strong),
//       ),
//     );
//   }
// }
