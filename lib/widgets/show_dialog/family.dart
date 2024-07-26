import 'package:flutter/material.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/widgets/tile_detail.dart';

void showFamilyDetailsDialog(BuildContext context, FamilyModel fam) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(fam.id),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTileDetailRow('creted on: ', fam.createdOn),
            buildTileDetailRow('creator: ', fam.creator),
            buildTileDetailRowMembers('members: ', fam.members),
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

Widget buildTileDetailRowMembers(String label, List<String> members) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: members.length > 5 ? 100.0 : 80,
          width: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (context, index) {
              return Text(members[index]);
            },
          ),
        ),
      ],
    ),
  );
}
