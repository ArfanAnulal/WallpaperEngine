import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/remote/api_calls.dart';
import 'package:wallpaper_app/utils/common_widgets/grid_cards.dart';

class GridBuilder extends StatefulWidget {
  const GridBuilder({super.key});

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  late Future<List<Hit>> _futureHits;

  @override
  void initState() {
    super.initState();
    _futureHits = ApiCalls().getAPI();
    
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hit>>(
      future: _futureHits, 
      builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting ){
              return CircularProgressIndicator();
            }
            else if(snapshot.hasData){
              final hits = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: hits.length,
                itemBuilder: (context, index){
                  final hit = hits[index];
                  return GridCards(hitDetails:hit);
                }
              );
              }
              else{
              return const Text('No posts found.');
            }
        }
      );
  }
}
