import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {

  final String id;

  const Player({required this.id});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '${widget.id}',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Player is Ready')));
        },
      ),
    );
  }
}