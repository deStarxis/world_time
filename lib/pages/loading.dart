import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "loading...";

  void setupWorldTime() async {
    WorldTime worldtime = WorldTime(
        location: 'Kathmandu', flag: 'nepal.jpg', url: 'Asia/Kathmandu');
    await worldtime.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments:{
      'location' : worldtime.location,
      'flag':worldtime.flag,
      'time':worldtime.time,
      'isDayTime':worldtime.isDaytime
    });
    setState(() {
      time = worldtime.time;
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      )
    );
  }
}
