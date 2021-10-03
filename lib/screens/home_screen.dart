import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  DateTime convertUtcToDateTime(dynamic time) =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true)
          .add(const Duration(hours: 3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
              onPressed: () =>
                  Provider.of<WeatherProvider>(context, listen: false)
                      .refresh(),
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, value, child) => value.isLoading
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  future: value.getWeather(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return value.model == null
                          ? const Center(
                              child: Text(
                                'Please, enable the location and try again.',
                                style: TextStyle(
                                  fontSize: 36,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.shade700,
                                    Colors.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _cloudIcon(value.model!),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _temperature(value.model!),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _location(value.model!.timezone!),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            _date(value.model!.current!.dt),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        details(value.model!)
                                      ],
                                    ),
                                    _hourlyPrediction(value.model!),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _weeklyPrediction(value.model!),
                                  ],
                                ),
                              ),
                            );
                    }
                  }),
        ));
  }

  Widget _cloudIcon(WeatherModel model) {
    var iconCode = model.current!.weather!.first.icon;
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ImageIcon(
            NetworkImage(
              'http://openweathermap.org/img/wn/$iconCode@2x.png',
            ),
            size: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(model.current!.weather!.first.main!),
          ),
        ],
      ),
    );
  }

  _temperature(WeatherModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Day ${model.daily!.first.temp!.day.round()}°'),
            const SizedBox(
              width: 10,
            ),
            Text('Night ${model.daily!.first.temp!.night.round()}°'),
          ],
        ),
        Text(
          model.current!.temp.round().toString() + '°',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  _location(String timeZone) {
    return Row(
      children: [
        const Icon(Icons.place),
        const SizedBox(
          width: 10,
        ),
        Text(timeZone),
      ],
    );
  }

  _date(date) {
    var dateNow = convertUtcToDateTime(date);
    return Row(
      children: [
        const Text('Today'),
        const SizedBox(
          width: 10,
        ),
        Text(DateFormat.yMMMEd().format(dateNow)),
      ],
    );
  }

  details(WeatherModel model) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Feels like'),
              Text(model.current!.feelsLike.round().toString() + '°'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text('Humidity'),
              Text(model.current!.humidity.round().toString() + ' %'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pressure'),
              Text((model.current!.pressure.round() / 1000).toString() +
                  ' mBar'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Wind Speed'),
              Text(model.current!.windSpeed.round().toString() + ' Km/h'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // final List<Map<String, String>> times = [
  //   {'time': 'now', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  //   {'time': '1', 'temp': '-10'},
  // ];

  _hourlyPrediction(WeatherModel model) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.white),
        bottom: BorderSide(color: Colors.white),
      )),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          var time = convertUtcToDateTime(model.hourly![index].dt!);
          var iconCode = model.hourly![index].weather!.first.icon;
          return Card(
            color: Colors.grey.shade600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(index == 0 ? 'Now' : DateFormat.j().format(time)),
                  SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.network(
                          'http://openweathermap.org/img/wn/$iconCode@2x.png')),
                  Text(model.hourly![index].temp.round().toString() + '°'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// final List<Map<String, String>> week = [
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
//   {'day': 'Monday', 'temp': '-10'},
// ];

  _weeklyPrediction(WeatherModel model) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.white),
        )),
        height: 100,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: model.daily!.length,
          itemBuilder: (context, index) {
            var time = convertUtcToDateTime(model.daily![index].dt);
            var iconCode = model.daily![index].weather!.first.icon;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: 100,
                      width: 80,
                      child: Text(DateFormat.EEEE().format(time)),
                    ),
                    Image.network(
                        'http://openweathermap.org/img/wn/$iconCode@2x.png'),
                    SizedBox(
                      width: 80,
                      child: Text(
                        model.daily![index].temp!.day.round().toString() + '°',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
