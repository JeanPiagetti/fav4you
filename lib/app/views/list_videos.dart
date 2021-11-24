import 'package:fav4you/app/models/video.dart';
import 'package:fav4you/app/services/api.dart';
import 'package:fav4you/app/views/player/player.dart';
import 'package:flutter/material.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({Key? key}) : super(key: key);

  @override
  _ListVideosState createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  static Api api = Api.instance;
  Future<List<Video>> _videos = api.fetchVideos();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _videos,
        builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
               TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Buscar vídeos',
                  ),
                  onChanged: (string) {
                    _videos = api.findOne(string);
                  }
                ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemBuilder: (context, index) => 
                        ListTile(
                          title: Text('${snapshot.data?[index].title}'),
                          leading: const Icon(Icons.play_arrow),
                          onTap: () {
                            // close(context, data[index]);
                            
                             Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>  Player(id: '${snapshot.data?[index].id}'),
                                  ),
                                );
                                                        },
                  ),
                  itemCount: snapshot.data!.length,
                  ),
                ))
                ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        });
  }
}
