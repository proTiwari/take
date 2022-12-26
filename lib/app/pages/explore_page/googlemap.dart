import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take/app/pages/list_property/search_place_provider.dart';

import '../../models/auto_complete_result.dart';
import '../../services/map_services.dart';

class Googlemap extends ConsumerStatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final liss;
  const Googlemap({Key? key, this.liss}) : super(key: key);

  @override
  ConsumerState<Googlemap> createState() => _GooglemapState();
}

class _GooglemapState extends ConsumerState<Googlemap> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Circle> _circles = <Circle>{};
  final Set<Circle> _circles2 = <Circle>{};
  Set<Marker> _markers = <Marker>{};
  bool cardList = false;
  bool cir = false;
  bool cis = false;
  bool cin = false;
  bool searchToggle = false;
  bool radiusSlider = true;
  int markerIdCounter = 1;
  var lat = 25.435801;
  var long = 81.846313;
  var radiusValue = 3000.0;
  var tappedPoint;
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.435801, 81.846313),
    zoom: 14.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.liss != [] && widget.liss.length > 1) {
    //   lat = double.parse(widget.liss[0]["lat"]) ?? 25.435801;
    //   long = double.parse(widget.liss[0]["long"]) ?? 81.846313;
    //   _kGooglePlex = CameraPosition(
    //     target: LatLng(lat, long),
    //     zoom: 12.4746,
    //   );
    // }
  }

  bool isReviews = true;

  void _setMarker(point) {
    var counter = markerIdCounter++;
    _setCircle(point, counter);
    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    setState(() {
      _markers.add(marker);
    });
  }

  final GoogleMapController? controller = null;

  void _setCircle(LatLng point, dynamic n, {double? radius}) async {
    if (cir == false) {
      controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: point, zoom: 12)));
      setState(() {
        _circles.add(Circle(
            circleId: CircleId("$n"),
            center: point,
            fillColor: Colors.blue.withOpacity(0.1),
            radius: radius ?? radiusValue,
            strokeColor: Colors.blue,
            strokeWidth: 1));

        // searchToggle = false;
        // radiusSlider = true;
      });
    }
  }

  void _sCircle(LatLng point, dynamic n, {double? radius}) async {
    if (cir == true) {
      controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: point, zoom: 12)));
      setState(() {
        _circles2.add(Circle(
            circleId: CircleId("$n"),
            center: point,
            fillColor: Colors.blue.withOpacity(0.1),
            radius: radius ?? radiusValue,
            strokeColor: Colors.blue,
            strokeWidth: 1));

        // searchToggle = false;
        // radiusSlider = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var changeId = 0;
    final allSearchResults = ref.watch(placeResultsProvider);
    final searchFlag = ref.watch(searchToggleProvider);
    List lst = [];
    _circles.clear();
    // for (var i in widget.liss) {
    //   var lat = double.parse(i["lat"]);
    //   var lon = double.parse(i["long"]);
    //   var latlong = LatLng(lat, lon);
    //   _setMarker(latlong);
    // }

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers,
                  circles: cir ? _circles2 : _circles,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (point) {
                    tappedPoint = point;
                    var n = Random();
                    // radiusSlider = cir;
                    _sCircle(point, n.nextInt(1000));
                  },
                ),
              ),
              true
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                      child: Column(children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                border: InputBorder.none,
                                hintText: 'Search',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        searchToggle = false;

                                        searchController.text = '';
                                        _markers = {};
                                        if (searchFlag.searchToggle) {
                                          searchFlag.toggleSearch();
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.close))),
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false) {
                                _debounce?.cancel();
                              }
                              _debounce =
                                  Timer(const Duration(milliseconds: 700), () async {
                                if (value.length > 2) {
                                  if (!searchFlag.searchToggle) {
                                    searchFlag.toggleSearch();
                                    _markers = {};
                                  }

                                  List<AutoCompleteResult> searchResults =
                                      await MapServices().searchPlaces(value);

                                  allSearchResults.setResults(searchResults);
                                } else {
                                  List<AutoCompleteResult> emptyList = [];
                                  allSearchResults.setResults(emptyList);
                                }
                              });
                            },
                          ),
                        )
                      ]),
                    )
                  : Container(),
              searchFlag.searchToggle
                  ? allSearchResults.allReturnedResults.isNotEmpty
                      ? Positioned(
                          top: 100.0,
                          left: 15.0,
                          child: Container(
                            height: 200.0,
                            width: screenWidth - 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: ListView(
                              children: [
                                ...allSearchResults.allReturnedResults
                                    .map((e) => buildListItem(e, searchFlag))
                              ],
                            ),
                          ))
                      : Positioned(
                          top: 100.0,
                          left: 15.0,
                          child: Container(
                            height: 200.0,
                            width: screenWidth - 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: Center(
                              child: Column(children: [
                                const Text('No results to show',
                                    style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  width: 125.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      searchFlag.toggleSearch();
                                    },
                                    child: const Center(
                                      child: Text(
                                        'Close this',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ))
                  : Container(),
              false
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                      child: Container(
                          height: 50.0,
                          color: Colors.black.withOpacity(0.2),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Slider(
                                max: 7000.0,
                                min: 1000.0,
                                value: radiusValue,
                                onChangeEnd: (newVal) {
                                  // radiusValue = newVal;
                                  // pressedNear = false;
                                  // _circles.clear;
                                  var n = Random();
                                  changeId = changeId + 1;

                                  if (!cir) {
                                    for (var i in _circles) {
                                      if (i.center == tappedPoint) {
                                        // i.radius  = newVal;
                                        // i.radius = newVal;
                                        setState(() {
                                          _circles2.clear();
                                          // i.radius = newVal;
                                          i.copyWith(radiusParam: newVal);
                                        });
                                      }
                                    }
                                    _setCircle(tappedPoint, changeId,
                                        radius: newVal);
                                  }

                                  for (var i in _circles2) {
                                    if (i.center == tappedPoint) {
                                      // i.radius  = newVal;
                                      // i.radius = newVal;
                                      setState(() {
                                        // i.radius = newVal;
                                        i.copyWith(radiusParam: newVal);
                                      });
                                    }
                                  }
                                  _sCircle(tappedPoint, changeId,
                                      radius: newVal);
                                },
                                onChanged: (value) {
                                  if (!cir) {
                                    setState(() {
                                      _circles2.clear();
                                      radiusValue = value;
                                    });

                                    _setCircle(tappedPoint, 7);
                                  }
                                  // _circles2.clear;
                                  setState(() {
                                    radiusValue = value;
                                  });

                                  _sCircle(tappedPoint, 7);
                                },
                              )),
                              Text("${radiusValue.toInt()} m")
                            ],
                          )))
                  : Container(),
              cardList
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 530, 0, 0),
                      child: SizedBox(
                        child: Container(
                          height: 110.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              if (isReviews && widget.liss != null)
                                ...widget.liss!.map((e) {
                                  print("is this your are taking about :$e");
                                  return _buildReviewItem(e);
                                })
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      )),
      // floatingActionButton: FabCircularMenu(
      //     alignment: Alignment.bottomLeft,
      //     fabColor: Colors.blue.shade50,
      //     fabOpenColor: Colors.red.shade100,
      //     ringDiameter: 250.0,
      //     ringWidth: 60.0,
      //     ringColor: Colors.blue.shade50,
      //     fabSize: 60.0,
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             setState(() {
      //               cardList = !cardList;
      //               searchToggle = true;
      //               radiusSlider = false;

      //               // pressedNear = false;
      //               // cardTapped = false;
      //               // getDirections = false;
      //             });
      //           },
      //           icon: Icon(Icons.list_alt_rounded)),
      //       IconButton(
      //           onPressed: () {
      //             setState(() {
      //               searchToggle = !searchToggle;
      //               // cir = false;
      //               radiusSlider = false;

      //               // pressedNear = false;
      //               // cardTapped = false;
      //               // getDirections = false;
      //             });
      //           },
      //           icon: Icon(Icons.search)),
      //       IconButton(
      //           onPressed: () {
      //             setState(() {
      //               radiusValue = 3000;
      //               cir = !cir;
      //               searchToggle = false;
      //               radiusSlider = true;
      //               // pressedNear = false;
      //               // cardTapped = false;
      //               // getDirections = true;
      //             });
      //             if (cir == false) {
      //               _circles2.clear();
      //               _circles.clear();
      //             }
      //           },
      //           icon: Icon(Icons.circle_outlined))
      //     ]),
    );
  }

  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          var place = await MapServices().getPlace(placeItem.placeId);
          gotoSearchedPlace(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']);
          searchFlag.toggleSearch();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 25.0),
            SizedBox(width: 4.0),
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width - 75.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(review) {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 18.0),
            child: SizedBox(
              width: 200,
              height: 500,
              child: Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 2,
                child: InkWell(
                  onTap: () => {
                    goToTappedPlace(double.parse(review['lat']),
                        double.parse(review['long']))
                  },
                  child: Row(
                    children: [
                      Image(
                        width: 50,
                        height: 70,
                        image: NetworkImage(review["shopImageUrl"]),
                      ),
                      Text(review['name'] +
                          '\n' +
                          review['email'] +
                          '\n' +
                          review['phone'] +
                          '\n' +
                          review['streetAddress']),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.shade600, height: 1.0)
        ],
      ),
    );
  }

  Future<void> goToTappedPlace(review, review2) async {
    final GoogleMapController controller = await _controller.future;
    _markers = {};

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(review, review2),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
