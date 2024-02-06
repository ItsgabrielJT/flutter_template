import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/graphQlConstant.dart';
import 'package:flutter_application_2/modals/restaurantData.dart';
import 'package:flutter_application_2/screens/restaurantDetail.dart';
import 'package:flutter_application_2/utils/custom_image.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GridRestaurants extends StatefulWidget {
  final ThemeData? themeData;
  final int isWhat;

  const GridRestaurants({super.key, this.themeData, this.isWhat = 0});
  @override
  _GridRestaurantsState createState() => _GridRestaurantsState();
}

class _GridRestaurantsState extends State<GridRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(widget.isWhat == 0
              ? restaurantList
              : widget.isWhat == 1
                  ? cafeList
                  : pubList),
          variables: const <String, dynamic>{}),
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
                  'Loading ',
                  style: widget.themeData!.textTheme.bodyLarge,
                ),
              )
            ],
          );
        } else if (result.data == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Oops! Something went wrong !",
                  style: Theme.of(context).textTheme.bodyLarge),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        widget.themeData!.colorScheme.secondary)),
                child: Text("Retry",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: widget.themeData!.primaryColor)),
                onPressed: () {
                  refetch!();
                },
              )
            ],
          );
        } else {
          List<Restaurant> restaurants = widget.isWhat == 0
              ? RestaurantData.fromJson(result.data!).restaurantList!
              : widget.isWhat == 1
                  ? RestaurantData.fromJson(result.data!).cafeList!
                  : RestaurantData.fromJson(result.data!).pubList!;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: restaurants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantDetail(
                                place: restaurants[index],
                                heroId: restaurants[index].name,
                                themeData: widget.themeData,
                              )));
                },
                child: Stack(
                  children: <Widget>[
                    Card(
                      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        child: Hero(
                          tag: restaurants[index].name!,
                          child: FadeInImage(
                            image: customImage(restaurants[index].image),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/images/loading.gif'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 8,
                      child: Card(
                        color: widget.themeData!.primaryColorDark,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(restaurants[index].name!,
                                  style: widget.themeData!.textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: widget.themeData!.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Text(restaurants[index].district!,
                                      style:
                                          widget.themeData!.textTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
