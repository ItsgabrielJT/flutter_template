import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/attractiondata.dart';
import 'package:flutter_application_2/modals/graphQlConstant.dart';
import 'package:flutter_application_2/screens/all_attractions.dart';
import 'package:flutter_application_2/screens/place_detail.dart';
import 'package:flutter_application_2/utils/custom_image.dart';
import 'package:flutter_application_2/utils/widgets.dart';
import 'package:flutter_application_2/widgets/retry_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math' as math;


class SlidingPlacesView extends StatefulWidget {
  final ThemeData? themeData;

  const SlidingPlacesView({super.key, this.themeData});

  @override
  _SlidingPlacesViewState createState() => _SlidingPlacesViewState();
}

class _SlidingPlacesViewState extends State<SlidingPlacesView> {
  PageController? pageController;
  double? pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController!.addListener(() {
      setState(() => pageOffset = pageController!.page);
    });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Query(
        options: QueryOptions(
            document: gql(attractionsList), variables: const <String, dynamic>{}),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.themeData!.colorScheme.secondary),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Loading Attractions.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            );
          } else if (result.data == null) {
            return RetryWidget(
              themeData: widget.themeData,
              onRetried: () {
                refetch!();
              },
            );
          } else {
            List<Attraction> attractions =
                AttractionData.fromJson(result.data!).attractionList!;
            return Column(
              children: <Widget>[
                ShowMore(
                  text: 'Attractions',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllAttractions(
                                  themeData: widget.themeData,
                                  attractions: attractions,
                                )));
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: attractions.length >= 5 ? 5 : attractions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceDetail(
                                        place: Attraction.fromJson(result
                                            .data?['attractionList'][index]),
                                        heroId: attractions[index].name,
                                        themeData: widget.themeData,
                                      )));
                        },
                        child: SlidingCard(
                          name: result.data!['attractionList'][index]['name'],
                          imageUrl: result.data!['attractionList'][index]
                              ['image'],
                          location: result.data!['attractionList'][index]
                              ['district'],
                          offset: pageOffset! - index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String? name, imageUrl, location;
  final double offset;

  const SlidingCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
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
                tag: name!,
                child: FadeInImage(
                  image: customImage(imageUrl),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/images/loading.gif'),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 8,
            child: Card(
              color: Theme.of(context).primaryColorDark,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(name!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        Text(location!,
                            style: Theme.of(context).textTheme.bodyLarge,
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
  }
}
