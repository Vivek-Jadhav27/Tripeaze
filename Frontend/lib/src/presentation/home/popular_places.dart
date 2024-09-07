import 'package:flutter/material.dart';
import 'package:tripeaze/src/model/place_model.dart';
import 'package:tripeaze/src/service/api_service.dart';
class PopularPlacesScreen extends StatefulWidget {
  @override
  _PopularPlacesScreenState createState() => _PopularPlacesScreenState();
}

class _PopularPlacesScreenState extends State<PopularPlacesScreen> {
  late Future<List<Place>> futurePlaces;
  final APIService apiService = APIService();


  @override
  void initState() {
    super.initState();
    futurePlaces = apiService.fetchPopularPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Places'),
      ),
      body: FutureBuilder<List<Place>>(
        future: futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Place> places = snapshot.data!;
            return ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(places[index].imgUrl),
                  title: Text(places[index].name),
                  subtitle: Text(places[index].description),
                );
              },
            );
          } else if (snapshot.hasError) {
            
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
