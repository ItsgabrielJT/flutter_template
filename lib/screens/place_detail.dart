import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/custom_image.dart';
import '../modals/attractiondata.dart';
import '../modals/openweather.dart';
import '../widgets/custom_carousel.dart';
import 'package:http/http.dart' as http;
import 'nearby_attractions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_2/utils/constants.dart';


class PlaceDetail extends StatefulWidget {
  final String? heroId;
  final Attraction place;
  final ThemeData? themeData;

  const PlaceDetail(
      {super.key, required this.heroId, required this.place, required this.themeData});
  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  OpenWeatherMap? weatherData;

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    try {
      var res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${widget.place.latitude}&lon=${widget.place.longitude}&appid=$apiString"));
      var decodeRes = jsonDecode(res.body);
      print(decodeRes);
      weatherData = OpenWeatherMap.fromJson(decodeRes);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: height / 3 + kTextTabBarHeight,
                floating: true,
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: kTextTabBarHeight),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        child: FadeInImage(
                          image: customImage(widget.place.image),
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/images/loading.gif'),
                        ),
                      ),
                    ),
                  ),
                ),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: widget.themeData!.colorScheme.secondary,
                  tabs: <Widget>[
                    Tab(
                      child: Text('General',
                          style: widget.themeData!.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Tab(
                      child: Text('Nearby',
                          style: widget.themeData!.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    // Tab(
                    //   child: Text('Hotels',
                    //       style: widget.themeData.textTheme.bodyText1
                    //           .copyWith(fontWeight: FontWeight.bold)),
                    // ),
                  ],
                ),
              ),
            ];
          },
          body: Container(
              color: widget.themeData!.primaryColor,
              child: TabBarView(
                children: <Widget>[
                  generalTab(),
                  Container(
                    child: NearbyAttractions(
                      themeData: widget.themeData,
                      provinceId: widget.place.province,
                    ),
                  ),
                  // Container()
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String url =
              "google.navigation:q=${widget.place.latitude},${widget.place.longitude}";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            print('cannot launch');
          }
        },
        backgroundColor: widget.themeData!.colorScheme.secondary,
        tooltip: 'Navigate',
        child: Transform.rotate(
            angle: math.pi / 4.0,
            child:
                Icon(Icons.navigation, color: widget.themeData!.primaryColor)),
      ),
    );
  }

  Widget weatherWidget() {
    if (weatherData == null) return const SizedBox.shrink();
    var data = weatherData?.weather![0].icon;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: widget.themeData!.primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: data == null
                      ? const SizedBox.shrink()
                      : Image.asset(
                          weatherData == null
                              ? 'assets/images/weather.gif'
                              : 'assets/images/weather/${weatherData!.weather![0].icon}.png',
                          fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          weatherData == null
                              ? 'Fetching...'
                              : '${(weatherData!.main!.temp! - 273.15).toStringAsFixed(2)} °C',
                          overflow: TextOverflow.ellipsis,
                          style: widget.themeData!.textTheme.bodyMedium),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                          weatherData == null
                              ? 'Fetching...'
                              : '${weatherData!.weather![0].description}',
                          overflow: TextOverflow.ellipsis,
                          style: widget.themeData!.textTheme.bodyLarge),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        weatherData == null
                            ? '...'
                            : '${(weatherData!.main!.tempMin! - 273.15).toStringAsFixed(2)} / ${(weatherData!.main!.tempMax! - 273.15).toStringAsFixed(2)} °C',
                        overflow: TextOverflow.ellipsis,
                        style: widget.themeData!.textTheme.bodySmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                        weatherData == null
                            ? '...'
                            : 'Humidity : ${weatherData!.main!.humidity} %',
                        overflow: TextOverflow.ellipsis,
                        style: widget.themeData!.textTheme.bodyLarge),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generalTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.place.name!,
            style: widget.themeData!.textTheme.headlineSmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Chip(
              backgroundColor: widget.themeData!.colorScheme.secondary,
              label: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: widget.themeData!.primaryColor,
                  ),
                  Text(
                    widget.place.district!,
                    style: widget.themeData!.textTheme.bodyLarge!
                        .copyWith(color: widget.themeData!.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        weatherWidget(),
        widget.place.img!.isEmpty ? Container() : _imageWidget(),
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
                itemCount: widget.place.description!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    widget.place.description![index],
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

  Widget _imageWidget() {
    return Column(
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
              imageUrls: widget.place.img, themeData: widget.themeData),
        ),
      ],
    );
  }
}