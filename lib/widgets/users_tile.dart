import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/widgets/show_dialog/users.dart';

class KUsersTileBloc extends StatelessWidget {
  const KUsersTileBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is UsersFamilysDetailsLoaded) {
          return KUsersTiles(users: state.users);
        } else if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('couln\'t fetch user\'s'));
      },
    );
  }
}

class KUsersTiles extends StatelessWidget {
  const KUsersTiles({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserModel user = users[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: ListTile(
              onTap: () {
                showUserDetailsDialog(context, user);
              },
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.info),
            ),
          );
        },
      ),
    );
  }
}
