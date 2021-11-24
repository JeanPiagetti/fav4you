import 'package:fav4you/app/shared/components/app_bar/app_bar.dart';
import 'package:fav4you/app/shared/components/drawer/drawer_component.dart';
import 'package:fav4you/app/views/list_videos.dart';
import 'package:fav4you/app/views/player/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Fav4You';
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarComponent(title: title, centerTitle: true),
      ),
      // body: Player(id: 'fj3cPllHSGs'),
      body: ListVideos(),
      drawer: DrawerComponent(
        nameApp: title,
      ),
    );
  }
}
