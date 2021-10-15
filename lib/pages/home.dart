import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map<String,dynamic> data = {};

  @override
  Widget build(BuildContext context) {

    final args  = ModalRoute.of(context)!.settings.arguments;
    data= data.isNotEmpty ? data : args as Map<String,dynamic>;

    String bgImage = data['isDayTime']? 'day.jpg':'night.jpg';
    Color?  bgColor = data['isDayTime']? Colors.blue:Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time' : result['time'],
                        'location' : result['location'],
                        'isDayTime' : result['isDayTime'],
                        'flag' : result['flag'],
                      };
                    });
                  }, icon: const Icon(Icons.edit_location,
                      color: Colors.black),
                      label: const Text('Edit Location',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),)),
                const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
