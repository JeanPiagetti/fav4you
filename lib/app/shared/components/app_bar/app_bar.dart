import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final String? title;
  final bool? centerTitle;
  const AppBarComponent({Key? key, this.title, this.centerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title'),
      centerTitle: centerTitle,
    );
  }
}
