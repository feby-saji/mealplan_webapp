import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/screens/home/mobile/widgets/tab_bar.dart';
import 'package:web_app/widgets/family_tile_bloc.dart';
import 'package:web_app/widgets/settings_icon_homescreen.dart';
import 'package:web_app/widgets/users_tile.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(GetFamilyuserDetails());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Panel'),
        actions: const [KSettingInHomeScreen()],
      ),
      body: const TabBarViewWidget(
        childrenTabViews: [
          KUsersTileBloc(),
          KFamilyTileBloc(),
        ],
      ),
    );
  }
}
