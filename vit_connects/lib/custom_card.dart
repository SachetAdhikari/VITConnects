import 'package:flutter/material.dart';

Widget showCard(BuildContext context, String title, String subTitle) {
  return Container(
    height: 110,
    color: Colors.red,
    child: Card(
      elevation: 8,
      color: Colors.white,
      child: ListTile(
        trailing: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_rounded,
                ),
                color: Colors.red,
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.delete_rounded),
                color: Colors.red,
              ),
            ],
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            title,
            maxLines: 2,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                subTitle,
                maxLines: 2,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                " Due Date: 10/4/21",
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
