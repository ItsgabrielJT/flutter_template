import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/festivaldata.dart';
import 'package:flutter_application_2/utils/custom_image.dart';
import '../widgets/custom_carousel.dart';

class FestivalDetail extends StatefulWidget {
  final String? heroId;
  final Festival festival;
  final ThemeData? themeData;

  const FestivalDetail(
      {super.key, required this.heroId,
      required this.festival,
      required this.themeData});
  @override
  _FestivalDetailState createState() => _FestivalDetailState();
}

class _FestivalDetailState extends State<FestivalDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: height / 3,
              floating: true,
              title: Text(
                widget.festival.name!,
                style: widget.themeData!.textTheme.headlineSmall,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: widget.themeData!.colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: widget.themeData!.primaryColor,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.heroId!,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    child: FadeInImage(
                      image: customImage(widget.festival.image),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/images/loading.gif'),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
            color: widget.themeData!.primaryColor, child: generalTab()),
      ),
    );
  }

  Widget generalTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: <Widget>[
        widget.festival.img!.length == 0
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Photos',
                          style: widget.themeData!.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CustomCarousel(
                        imageUrls: widget.festival.img,
                        themeData: widget.themeData),
                  ),
                ],
              ),
        ExpansionTile(
          title: Text(
            'Description',
            style: widget.themeData!.textTheme.bodyMedium,
          ),
          initiallyExpanded: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.festival.description!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    widget.festival.description![index],
                    style: widget.themeData!.textTheme.bodyLarge,
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
