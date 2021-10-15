import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  late String location;
  late String time;
  late String flag; // url to an asset flag
  late String url; // location url for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // final Uri url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
      // Response response = await get(url);
      // Map data = jsonDecode(response.body);
      // print(data);
      // print(data['title']);

      //make the request
      final Uri responseUrl =
          Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(responseUrl);
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String hourOffset = data['utc_offset'].substring(1, 3);
      String minuteOffset = data['utc_offset'].substring(4, 6);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hourOffset),minutes: int.parse(minuteOffset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error : $e');
      time = 'Could not get time';
    }
  }
}
