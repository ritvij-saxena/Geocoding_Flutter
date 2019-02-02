import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_app/locationUpdate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController addressTextController = TextEditingController();
  Marker markers;
  double latCenter, lngCenter;
  bool requestForAddress = false;
  bool isClicked = false;

  void searchPlace(String text) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(text);
    var first = addresses.first;
    setState(() {
      latCenter = first.coordinates.latitude;
      lngCenter = first.coordinates.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps Demo'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter Your Address Here'),
                            controller: addressTextController,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (addressTextController.text.isEmpty) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Enter Some Address')));
                              } else {
                                requestForAddress = true;
                                isClicked = true;
                                searchPlace(addressTextController.text);
                              }

//                        showDialog(
//                            context: context,
//                            builder: (BuildContext context){
////                              return AlertDialog(
////                                title: Text('Location Query'),
////                                content: Text(addressTextController.text),
////                                actions: <Widget>[
////                                  FlatButton(
////                                    child: Text('Okay'),
////                                    onPressed: (){
////                                      Navigator.of(context).pop();
////                                    },
////                                  )
////                                ],
////                              );
//                            }
//                        );
                            })
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                  child: isClicked == true
                      ? LocationUpdate(
                          text: addressTextController.text,
                          lat: latCenter,
                          lng: lngCenter,
                          request: true)
                      : LocationUpdate() //text: addressTextController.text,lat: latCenter,lng: lngCenter,request: requestForAddress)
                  )
            ],
          );
        }));
  }
}
