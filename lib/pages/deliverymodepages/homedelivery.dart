import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/ResponsiveInfo.dart';
import 'dart:ui' as ui;

class Homedelivery extends StatefulWidget {
  const Homedelivery() : super();

  @override
  _HomedeliveryState createState() => _HomedeliveryState();
}

class _HomedeliveryState extends State<Homedelivery> {


  Completer<GoogleMapController> _controller = Completer();

  double lat = 25.5115671;
  double longitude = 51.1721832;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.5115671, 51.1721832),
    zoom: 9.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};



  @override
  Widget build(BuildContext context) {
    return Stack(


      children:[

      Column(

        children: [

          Expanded(child:Stack(

            children: [
              GoogleMap(
                onTap: (LatLng latLng) async {
                  final lat = latLng.latitude;
                  final longitude = latLng.longitude;

                  var m="123132";

                  final Uint8List markerIcon = await getBytesFromAsset('images/pin.png', 100);

                  Marker marker = Marker(
                      icon: BitmapDescriptor.fromBytes(markerIcon),
                      markerId: MarkerId(m),
                      infoWindow:   InfoWindow(
                        title: 'Delivery location',
                        snippet: "my address",
                      ),
                      position: LatLng(
                        lat,
                        longitude,
                      ));

                  setState(() {
                    markers[MarkerId('place_name')] = marker;




                  });


                },
                mapType: MapType.normal,
                markers: markers.values.toSet(),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ) ,

              Align(
                  alignment: FractionalOffset.bottomRight,
                  child:Padding(


                    padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(20) : EdgeInsets.all(25):EdgeInsets.all(35),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.my_location_sharp,
                        color: Colors.black,
                        size: 29,
                      ),

                      onPressed: () {
                        fetchLocation();

                      },

                    ),
                  )



              ),



              Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?20:25:35,left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20,right: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20  ),

                child: Card(

                  child: Container(

                    height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?40:50:70,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,

                      decoration: InputDecoration(
                          hintText: "Search",
                          filled: true,

                          border: InputBorder.none,
                          fillColor:  Colors.white,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black12,
                          ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color:  Colors.black38,
                          //       width: 1),
                          //   borderRadius: BorderRadius.circular(1),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color:  Colors.black38,
                          //       width: 1),
                          //   borderRadius: BorderRadius.circular(1),
                          // ),
                          errorStyle: const TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.all(0)),
                      onChanged: (value) {
                        // searchItem = value;
                      },
                    ),


                  ),



                ),

              )




            ],


          ),flex: 7, ),

          Expanded(child:

          Container(
            color: Colors.white,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.all(10):EdgeInsets.all(15):EdgeInsets.all(25)
                    ,
                    child:Row(

                      children: [

                        Expanded(child:Icon(Icons.location_on_outlined,size:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?20:25:30,color: Colors.black ,),
                          flex: 1,),

                        Expanded(child: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?3:5:11),

                          child:



                          Text(
                            "Almasco,dhd",


                            textAlign: TextAlign.left,
                            style: TextStyle(



                                fontWeight: FontWeight.bold,
                                fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?14:17:21 ,

                                color:  Colors.black),
                          ),
                        ),flex: 7, ),
                      ],

                    )
                ),

                Padding(padding:ResponsiveInfo.isMobile(context)? EdgeInsets.fromLTRB(10, 10, 10, 10):EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child:  Container(

                      width:double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 60:90,
                      decoration: BoxDecoration(
                        color: Color(0xff05ac54),
                        border: Border.all(
                          color: Color(0xff05ac54),
                        ),
                        // borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?20:40))


                      ),
                      child: TextButton(onPressed: () {




                      },
                        child: Text("Confirm Location",style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 17:26),),





                      ),




                    )),


              ],


            ),





          )



            ,flex: 2,)
        ],

      ),

      ]
    )


    ;
  }

  fetchLocation() async
  {

    bool  serviceEnabled = await  Geolocator.isLocationServiceEnabled();


    LocationPermission  permission = await Geolocator.requestPermission();

    if(permission==LocationPermission.whileInUse) {
      if (!serviceEnabled) {



        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Location disabled"),
        ));
      }
      else {

        var  loc = await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print(loc);

        lat=loc.latitude;
        longitude=loc.longitude;


        final Uint8List markerIcon = await getBytesFromAsset('images/pin.png', 100);


        var m="123132";
        Marker marker = Marker(
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow:   InfoWindow(
              title: 'Delivery location',
              snippet: "shdi",
            ),
            markerId: MarkerId(m),
            position: LatLng(
              lat,
              longitude,
            ));

        setState(() {
          markers[MarkerId('place_name')] = marker;




        });

        CameraPosition _kLake = CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(lat, longitude),
            tilt: 59.440717697143555,
            zoom: 16.151926040649414);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Location enabled"),
        ));
      }
    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Location permission not enabled"),
      ));
    }






  }



  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
