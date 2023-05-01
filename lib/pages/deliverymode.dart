

import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/selectcountry.dart';



import '../utils/ResponsiveInfo.dart';
import 'deliverymodepages/homedelivery.dart';
import 'deliverymodepages/storepickup.dart';


class Deliverymode extends StatefulWidget {
  const Deliverymode() : super();

  @override
  _DeliverymodeState createState() => _DeliverymodeState();
}

class _DeliverymodeState extends State<Deliverymode> with SingleTickerProviderStateMixin {



  int _selectedIndex=0;



 late TabController _tabController;


  List<Widget> _pages = <Widget>[
    Deliverymode(),
    // NetworkPage(title: "Network"),
    Storepickup(),


  ];


  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
  }

//AIzaSyBw0gs6XJ7uKJNE7NDPaSZcED3scMaSmkk

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff05ac54), // Status bar color
    child: SafeArea(
    left: false,
    right: false,
    bottom: false,



    child:  Scaffold(
      resizeToAvoidBottomInset: true,

        appBar:  AppBar(
          backgroundColor: Color(0xffffffff),
          elevation: 4,
          toolbarHeight: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:60:110,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          //   onPressed: () => Navigator.pop(context),
          // ),
          // title: Text("Delivery Mode",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
          centerTitle: false,

          flexibleSpace:Container(

            width: double.infinity,
            height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:60:110,

            padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10,right: 10):EdgeInsets.only(left: 15,right: 15):EdgeInsets.only(left: 25,right: 25),


            child:   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [


                Expanded(child:     Align(
                  alignment: FractionalOffset.center,

                  child:  InkWell(child:


                  Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
                    onTap: (){



                    },
                  ),
                ),
                  flex: 1,
                ),


                Expanded(child:     Align(
                  alignment: FractionalOffset.center,

                  child:  Text("Delivery Mode",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Colors.black),),

                ),
                  flex: 3,
                ),








                Expanded(child:

                Align(
                    alignment: FractionalOffset.center,


                      child:   InkWell(child:

                          SizedBox(width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?160:190:240,
                            height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:75:100,

                            child: Row(

                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Image.network("https://cdn.britannica.com/27/70827-050-8D001288/Bahraini-flag-2002.jpg",
                                      width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?25:33:45,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?25:33:45,
                                      errorBuilder:
                                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return


                                               Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:45 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:45,
                                              ) ;
                                      },
                                    ),

                                Text("  Bahrain   ",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 12:13:14:17,color: Colors.black),),

                                Icon(Icons.keyboard_arrow_down_sharp,size:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 15:17:20:25,color: Color(0xff05ac54) ,)

                              ],

                            ),

                          ),




                                          onTap: (){

                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (_) => Selectcountry()));




                        },
                      ),







                )

                  ,flex: 2, )










              ],

            ),



































          ),
        ),


      body:  Container(

        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(

          children: [

            Flexible(child: Container(child: Align(

                alignment: FractionalOffset.topCenter,
                child: Card(

                  child:   TabBar(
                    controller: _tabController,
                    indicatorColor: Color(0xff05ac54),
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff05ac54),
                    onTap: _onItemTap ,
                    tabs: [

                      Tab(  child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delivery_dining,size: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?25:30:35,),
                          const SizedBox(width: 8),
                          Text('Home Delivery'),
                        ],
                      )),

                      Tab(  child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_bag_outlined,size: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?25:30:35,),
                          const SizedBox(width: 8),
                          Text('Store Pickup'),
                        ],
                      ))


                      // Tab(text: "Store Pickup",icon: Icon(Icons.delivery_dining,size: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?25:30:35,)),

                    ],
                  ),
                )




            ),
              width: double.infinity,


            ),),

            Flexible(child:  Container(child:  (_selectedIndex==0)?Homedelivery():Storepickup(),

            ),flex: 9,)


            
            ,
//             Expanded(child:Stack(
//
//               children: [
//                 GoogleMap(
//                   onTap: (LatLng latLng) async {
//                     final lat = latLng.latitude;
//                     final longitude = latLng.longitude;
//
//                     var m="123132";
//
//                     final Uint8List markerIcon = await getBytesFromAsset('images/pin.png', 100);
//
//                     Marker marker = Marker(
//                         icon: BitmapDescriptor.fromBytes(markerIcon),
//                         markerId: MarkerId(m),
//                         infoWindow:   InfoWindow(
//                           title: 'Delivery location',
//                           snippet: "my address",
//                         ),
//                         position: LatLng(
//                           lat,
//                           longitude,
//                         ));
//
//                     setState(() {
//                       markers[MarkerId('place_name')] = marker;
//
//
//
//
//                     });
//
//
//                   },
//                   mapType: MapType.normal,
//                   markers: markers.values.toSet(),
//                   initialCameraPosition: _kGooglePlex,
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ) ,
//
//                 Align(
//                     alignment: FractionalOffset.bottomRight,
//                     child:Padding(
//
//
//                       padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(20) : EdgeInsets.all(25):EdgeInsets.all(35),
//                       child: FloatingActionButton(
//                         backgroundColor: Colors.white,
//                         child: Icon(
//                           Icons.my_location_sharp,
//                           color: Colors.black,
//                           size: 29,
//                         ),
//
//                         onPressed: () {
//                           fetchLocation();
//
//                         },
//
//                       ),
//                     )
//
//
//
//                 ),
//
//
//
//                 Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?60:70:110,left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20,right: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20  ),
//
//                   child: Card(
//
//                     child: Container(
//
//                       height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?40:50:70,
//                       child: TextField(
//                         textAlignVertical: TextAlignVertical.center,
//
//                         decoration: InputDecoration(
//                             hintText: "Search",
//                             filled: true,
//
//                             border: InputBorder.none,
//                             fillColor:  Colors.white,
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               color: Colors.black12,
//                             ),
//                             // enabledBorder: OutlineInputBorder(
//                             //   borderSide: BorderSide(
//                             //       color:  Colors.black38,
//                             //       width: 1),
//                             //   borderRadius: BorderRadius.circular(1),
//                             // ),
//                             // focusedBorder: OutlineInputBorder(
//                             //   borderSide: BorderSide(
//                             //       color:  Colors.black38,
//                             //       width: 1),
//                             //   borderRadius: BorderRadius.circular(1),
//                             // ),
//                             errorStyle: const TextStyle(fontSize: 12),
//                             contentPadding: const EdgeInsets.all(0)),
//                         onChanged: (value) {
//                           // searchItem = value;
//                         },
//                       ),
//
//
//                     ),
//
//
//
//                   ),
//
//                 )
//
//
//
//
//               ],
//
//
//             ),flex: 4, ),
//
//             Expanded(child:
//
//               Container(
//                 color: Colors.white,
//
//                 child: Column(
//
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//
//                   children: [
// Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.all(10):EdgeInsets.all(15):EdgeInsets.all(25)
// ,
// child:Row(
//
//                 children: [
//
//                 Expanded(child:Icon(Icons.location_on_outlined,size:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?20:25:30,color: Colors.black ,),
//                 flex: 1,),
//
//               Expanded(child: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?3:5:11),
//
//                 child:
//
//
//
//                 Text(
//                   "Almasco,dhd",
//
//
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//
//
//
//                       fontWeight: FontWeight.bold,
//                       fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?14:17:21 ,
//
//                       color:  Colors.black),
//                 ),
//               ),flex: 7, ),
//               ],
//
//             )
// ),
//
//                     Padding(padding:ResponsiveInfo.isMobile(context)? EdgeInsets.fromLTRB(10, 10, 10, 10):EdgeInsets.fromLTRB(20, 20, 20, 20),
//                         child:  Container(
//
//                           width:double.infinity,
//                           height:ResponsiveInfo.isMobile(context)? 60:90,
//                           decoration: BoxDecoration(
//                               color: Color(0xff05ac54),
//                               border: Border.all(
//                                 color: Color(0xff05ac54),
//                               ),
//                               // borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?20:40))
//
//
//                           ),
//                           child: TextButton(onPressed: () {
//
//
//
//
//                           },
//                             child: Text("Confirm Location",style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 17:26),),
//
//
//
//
//
//                           ),
//
//
//
//
//                         )),
//
//
//                   ],
//
//
//                 ),
//
//
//
//
//
//               )
//
//
//
//               ,flex: 1,)

          ],

        )






      )

    )

    ));


  }
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




}
