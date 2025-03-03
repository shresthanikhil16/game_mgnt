import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/profile/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent(_token!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF990000),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return _buildProfile(state.user);
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Loading profile...'));
          }
        },
      ),
    );
  }

  Widget _buildProfile(AuthEntity user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileHeader(user),
          const SizedBox(height: 20),
          _buildProfileDetails(user),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {}, // TODO: Implement Edit Profile functionality
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text('Edit Profile',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF990000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AuthEntity user) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: user.profilePicture != null &&
                    user.profilePicture!.isNotEmpty
                ? NetworkImage(
                    'http://your-api-base-url/uploads/${user.profilePicture}')
                : const AssetImage('assets/images/profile.png')
                    as ImageProvider,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.username,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(user.email,
            style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildProfileDetails(AuthEntity user) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.person, "Username", user.username),
            _buildDetailRow(Icons.email, "Email", user.email),
            _buildDetailRow(Icons.badge, "User ID", user.userId ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF990000)),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
