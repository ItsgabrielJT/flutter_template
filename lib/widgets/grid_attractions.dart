import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/place_detail.dart';
import 'package:flutter_application_2/utils/custom_image.dart';
import '../modals/attractiondata.dart';

class GridAttractions extends StatelessWidget {
  final List<Attraction>? attractions;
  final ThemeData? themeData;
  const GridAttractions({super.key, this.attractions, this.themeData});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData!.primaryColor,
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: attractions!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceDetail(
                            place: attractions![index],
                            heroId: attractions![index].name,
                            themeData: themeData,
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
                      tag: attractions![index].name!,
                      child: FadeInImage(
                        image: customImage(attractions![index].image),
                        width: double.infinity,
                        height: double.infinity,
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
                    color: themeData!.primaryColorDark,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(attractions![index].name!,
                              style: themeData!.textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: themeData!.colorScheme.secondary,
                                size: 20,
                              ),
                              Text(attractions![index].district!,
                                  style: themeData!.textTheme.bodyLarge,
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
      ),
    );
  }
}
