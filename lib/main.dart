import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Weather App',
    home: Home(),
  )
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;
  var icon;
  var temp;
  var description;
  var windSpeed;
  var lon;
  var lat;

  Future getWeather () async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Pamulang&appid=7a64b03ed3eb2d3062fda101c926d067');
    http.Response response = await http.get(url);
    var result = jsonDecode(response.body);
    setState(() {
      this.name = result['name'];
      this.icon = result['weather'][0]['icon'];
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.windSpeed = result['wind']['speed'];
      this.lon = result['coord']['lon'];
      this.lat = result['coord']['lat'];
    });

    return temp = (temp - 273.15).toStringAsFixed(2);
  }


  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '181011450646 - Juwono'.toUpperCase(),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network('http://openweathermap.org/img/wn/'+ icon.toString()+ '.png',),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    name != null ? name.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0 C" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    description != null ? description.toString() : 'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w100
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Suhu"),
                    trailing: Text(
                      temp != null ? temp.toString() + ' Celcius' : 'Loading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Kecepatan Angin"),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() + ' km/jam' : 'Loading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.mapSigns),
                    title: Text("Latitude"),
                    trailing: Text(
                      lat != null ? lat.toString() : 'Loading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.solidMap),
                    title: Text("Longtitude"),
                    trailing: Text(
                      lon != null ? lon.toString() : 'Loading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
