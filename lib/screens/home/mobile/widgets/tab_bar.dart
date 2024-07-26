import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/screens/home/desktop.dart';
import 'package:web_app/screens/home/mobile/bloc/tab_bar_bloc.dart';

class TabBarViewWidget extends StatefulWidget {
  final List<Widget> childrenTabViews;

  const TabBarViewWidget({super.key, required this.childrenTabViews});

  @override
  _TabBarViewWidgetState createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<TabBloc>().add(TabChanged(_tabController.index));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabBloc, TabState>(
      listener: (context, state) {
        if (_tabController.index != state.index) {
          _tabController.animateTo(state.index);
        }
      },
      child: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Users($usersCount)',
                  ),
                  Tab(
                    text: 'Familys($familyCount)',
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.childrenTabViews,
            ),
          ),
        ],
      ),
    );
  }
}
