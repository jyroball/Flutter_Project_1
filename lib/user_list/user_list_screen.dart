import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Different screens for bio
import 'package:test1/user_list/user_list_screens/bio_screen.dart';

//import model
import 'package:test1/models/user_entity.dart';

//import reusable widghets
import 'package:test1/widgets/user_card.dart';

//Import Form pages
import 'package:test1/add_user/add_user.dart';

//bloc models
import 'bloc/user_list_bloc.dart';
import 'bloc/user_list_event.dart';
import 'bloc/user_list_state.dart';

//change back to statless since bloc handle state
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  //wanna move to bio
  void _viewBio(BuildContext context, UserEntity user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BioScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Users'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add User',
            onPressed: () async {
              final newUser = await Navigator.push<UserEntity>(
                context,
                MaterialPageRoute(builder: (_) => const AddUserScreen()),
              );
              if (newUser != null && context.mounted) {
                //for some reason API GET not updated after POST, so do local for now
                context.read<UserListBloc>().add(AddUserLocally(newUser));
              }
            },
          ),
        ],
      ),

      //build
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          //loading new nusers
          if (state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          //L<oad Users
          else if (state is UserListLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users found.'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserListBloc>().add(RefreshUsers());
              },
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (ctx, i) {
                  return UserCard(
                    user: state.users[i],
                    goBio: () => _viewBio(context, state.users[i]),
                  );
                },
              ),
            );
          } 
          
          //Error
          else if (state is UserListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserListBloc>().add(FetchUsers());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}