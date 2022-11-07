import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() callback;
  const ActivityCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Card(
              margin: EdgeInsets.all(30),
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.accessible_forward,
                      size: 75,
                    ),
                    title: Text(
                      this.title,
                      style: TextStyle(fontSize: 50),
                    ),
                    subtitle: Text(
                      this.subtitle,
                      style: TextStyle(fontSize: 25),
                    ),
                    dense: false,
                  )
                ],
              )),
          onTap: () {
            callback();
          },
        )
      ],
    );
  }
}
