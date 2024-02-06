import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/attractiondata.dart';
import 'package:flutter_application_2/modals/graphQlConstant.dart';
import 'package:flutter_application_2/widgets/grid_attractions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NearbyAttractions extends StatefulWidget {
  final ThemeData? themeData;
  final int? provinceId;
  const NearbyAttractions({super.key, this.themeData, this.provinceId});
  @override
  _NearbyAttractionsState createState() => _NearbyAttractionsState();
}

class _NearbyAttractionsState extends State<NearbyAttractions> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(nearbyAttractionsList),
          variables: <String, dynamic>{"id": widget.provinceId}),
      builder: (QueryResult result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(widget.themeData!.colorScheme.secondary),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Loading Attractions.',
                  style: widget.themeData!.textTheme.bodyLarge,
                ),
              )
            ],
          );
        } else if (result.data == null) {
          return const Center(child: Text("No Data Found !"));
        } else {
          List<Attraction>? attractions =
              NearbyData.fromJson(result.data!).attractionList;

          return GridAttractions(
              themeData: widget.themeData, attractions: attractions);
        }
      },
    );
  }
}
