import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/widgets/family_tile_bloc.dart';
import 'package:web_app/widgets/settings_icon_homescreen.dart';
import 'package:web_app/widgets/users_tile.dart';

int usersCount = 0;
int familyCount = 0;

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(GetFamilyuserDetails());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Panel'),
        actions: const [KSettingInHomeScreen()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text('Users($usersCount)'),
                      ),
                      const Expanded(
                        child: KUsersTileBloc(),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text('Family\'s($familyCount)'),
                      ),
                      const Expanded(
                        child: KFamilyTileBloc(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
