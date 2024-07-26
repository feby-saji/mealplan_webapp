import 'package:flutter/material.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/widgets/tile_detail.dart';

void showUserDetailsDialog(BuildContext context, UserModel user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTileDetailRow('Email: ', user.email),
            buildTileDetailRow('Family ID: ', user.familyId),
            buildTileDetailRow('UID: ', user.uid),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
