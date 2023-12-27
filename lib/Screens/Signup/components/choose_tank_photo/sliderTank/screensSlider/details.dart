import 'package:flutter/material.dart';
import 'package:flutter_auth/network/local/cache_helper.dart';

import '../models.dart';

class DetailsScreen extends StatefulWidget {
  final DataModel data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              widget.data.title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: widget.data.imageName,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage(
                              widget.data.imageName,
                            ),
                            fit: BoxFit.fill),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26)
                        ]),
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    "Width ${widget.data.width} m, height ${widget.data.height} m",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: ElevatedButton(
                      style:ButtonStyle(),
                      onPressed: ()  {
                        if (widget.data.title=="Other") {
                          Navigator.of(context).pushNamed('OtherTankSize');

                        }  else{
                          // Show SnackBar
                          Navigator.of(context).pushNamed('signupScreen');
                          //Navigator.of(context).popUntil((route) => route.);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Height: ${widget.data.height}, Width: ${widget.data.width}, length: ${widget.data.length}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white), // Text color
                                ),
                              ),
                              backgroundColor: Colors.green, // SnackBar background color
                              duration: Duration(seconds: 3), // You can customize the duration
                            ),);

                          TankModel tankModel = TankModel(tankName: widget.data.title, height: widget.data.height,width: widget.data.width,length:  widget.data.length);
                          CacheHelper.saveTankModel(key: 'TankModel', tankModel: tankModel);
                        }


                      },
                      child: Text("choose tank".toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
