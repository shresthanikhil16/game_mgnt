import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:game_mgnt/features/profile/presentation/view_model/profile_event.dart';
import 'package:game_mgnt/features/profile/presentation/view_model/profile_state.dart';
import 'package:get_it/get_it.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to fetch profile data when the view is initialized
    context.read<ProfileBloc>().add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF990000),
      ),
      body: BlocProvider<ProfileBloc>(
        // Ensure ProfileBloc is created using GetIt
        create: (context) => GetIt.instance<ProfileBloc>(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(profile.profilePicture),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: profile.username,
                        decoration: InputDecoration(labelText: 'Username'),
                        enabled: false,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue: profile.email,
                        decoration: InputDecoration(labelText: 'Email'),
                        enabled: false,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Initial State'));
            }
          },
        ),
      ),
    );
  }
}
