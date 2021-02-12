import 'package:flutter/material.dart';

class FavoriteBubble extends StatelessWidget {
  final String text;

  const FavoriteBubble({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Theme.of(context).primaryColor,
            elevation: 5,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Vollkorn',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
