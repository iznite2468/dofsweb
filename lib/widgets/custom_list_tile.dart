import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String leading;
  final String data;
  final Color dataColor;
  const CustomListTile({
    Key? key,
    required this.leading,
    required this.data,
    this.dataColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '$leading :',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      title: Text(
        data,
        style: TextStyle(
          fontSize: 17,
          color: dataColor,
        ),
      ),
      dense: true,
    );
  }
}
