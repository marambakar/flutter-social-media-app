import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pronz/config.dart';

import 'package:pronz/models/Locationn.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/notification_page/notification_allow.dart';

import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';

class LocationmapPage extends StatefulWidget {
  Userr temp;
  LocationmapPage({this.temp});
  @override
  LocationmapPageBody createState() => LocationmapPageBody();
}

class LocationmapPageBody extends State<LocationmapPage> {
  double widthscreen, heightscreen;
  String locationTex;
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  //Locationn loc;
  @override
  initState() {


    super.initState();

    print("nnnnnnnnnnnnnivo"+double.parse(widget.temp.lat).toString());
    _center =  LatLng(double.parse(widget.temp.lat) , double.parse(widget.temp.lng));
    _lastMapPosition = _center;




    // Add listeners to this class


  }

  String val;

  Completer<GoogleMapController> _controller= Completer();
  static LatLng _center ;
  LatLng _lastMapPosition ;

  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastMapPosition = position.target;

     print("markerId^^^Nivo22222" + _lastMapPosition.toString());
    });
  }

  void _onAddMarkerButtonPressed(String title, String img) {

    print("ok remove");

     setState(() {
   _markers.clear();
      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),

          position: _lastMapPosition,

          infoWindow: InfoWindow(
            title: title,
            // snippet: val.toString(),
          ),
          //  icon: await getMarkerIcon(img, Size(150.0, 150.0))
        ),
      );
   });
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(
        imagePath); // Alternatively use your own method to get the image
    // ui.Image image = await getUiImage(imagePath, 50, 50);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  // Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
  //   final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  //   image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List());
  //   image.Image resizeImage = image.copyResize(baseSizeImage, height: height, width: width);
  //   ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage));
  //   ui.FrameInfo frameInfo = await codec.getNextFrame();
  //   return frameInfo.image;
  // }
  BitmapDescriptor pinLocationIcon;
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "images/img.jpg");
  }



  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    locationTex = "dont location";

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    LatLng temp = LatLng(double.parse(widget.temp.lat),double.parse(widget.temp.lng));
    _center = LatLng(double.parse(widget.temp.lat), double.parse(widget.temp.lng));
    _markers.add(
      Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          position: temp,
          infoWindow: InfoWindow(
            //  title: title,
            snippet: val.toString(),
          ),
          icon: pinLocationIcon),
      //await getMarkerIcon(img, Size(150.0, 150.0)))
    );

    return Scaffold(
      body: Stack(
          children: [
            GoogleMap(
              mapType: _currentMapType,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              // compassEnabled: true,
              markers: _markers,
              onCameraMove:_onCameraMove,
            ),
            Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Color_green,
                  child: const Icon(Icons.map, size: 36.0),
                )),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _onAddMarkerButtonPressed(
                        widget.temp.userName, "images/img.jpg");

                    print("markerId^^^Nivo" + _lastMapPosition.toString());

                    widget.temp.lat = _lastMapPosition.latitude.toString();
                    widget.temp.lng = _lastMapPosition.longitude.toString();
                  });
                },
                //   materialTapTargetSize: MaterialTapTargetSize.padded,
                //  backgroundColor: Colors.green,
                icon: const Icon(
                  Icons.location_on_sharp,
                  size: 55.0,
                  color: Color_green,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () async {
                  var res =
                      await Post_user("api/Account/updateUser", widget.temp);
                  print(res.statusCode);
                  print(res.toString());
                  if (res.statusCode == 200) {
                    print("succccc_Location");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationAllowPage()));
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                color: Color_green,
                minWidth: widthscreen / 3.5,
                height: heightscreen / 17,
              ),
            ),
          ],
        ),

        //  clipBehavior: Clip.antiAliasWithSaveLayer,

    );
  }

  Future<http.Response> Post_user(url, Userr temp) async {
    var baseUrl = network_client.Url;
    print("posttttt");

    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'UserId': temp.userID.toString(),
        'Name': temp.name,
        'PhoneNumber': temp.phoneNumber,
        'VarificationCode': temp.varificationCode,
        'Upublic': temp.uPublic,
        'UserName': temp.userName,
        'Gender': temp.gender,
        'Birthday': temp.birthday.toIso8601String(),
        'Lat': temp.lat,
        'Lng': temp.lng,
        'Status':temp.status,
        'Token' : Splash_Screen.token,
        'LastSeen' : DateTime.now().toString(),
        'Online' : 1,//y.toDouble(),
      }),
    );
  }
}
