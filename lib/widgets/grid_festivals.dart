import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/festivaldata.dart';
import 'package:flutter_application_2/screens/festival_detail.dart';
import 'package:flutter_application_2/utils/custom_image.dart';

class GridFestivals extends StatelessWidget {
  final List<Festival>? festivals;
  final ThemeData? themeData;
  const GridFestivals({super.key, this.festivals, this.themeData});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData!.primaryColor,
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: festivals!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FestivalDetail(
                            festival: festivals![index],
                            heroId: festivals![index].name,
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
                      tag: festivals![index].name!,
                      child: FadeInImage(
                        image: customImage(festivals![index].image),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(festivals![index].name!,
                            style: themeData!.textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis),
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
