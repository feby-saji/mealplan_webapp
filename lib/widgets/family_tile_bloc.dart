import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/widgets/show_dialog/family.dart';

class KFamilyTileBloc extends StatelessWidget {
  const KFamilyTileBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is UsersFamilysDetailsLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.familys.length,
              itemBuilder: (context, index) {
                FamilyModel fam = state.familys[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  child: ListTile(
                    onTap: () {
                      showFamilyDetailsDialog(context, fam);
                    },
                    title: Text(fam.id),
                    trailing: const Icon(Icons.info),
                  ),
                );
              },
            ),
          );
        } else if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('couln\'t fetch family\'s'));
      },
    );
  }
}
