class WeatherModel {
  dynamic lat;
  dynamic lon;
  String? timezone;
  dynamic timezoneOffset;
  Current? current;
  List<Minutely>? minutely;
  List<Hourly>? hourly;
  List<Daily>? daily;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['minutely'] != null) {
      minutely = [];
      json['minutely'].forEach((v) {
        minutely!.add(Minutely.fromJson(v));
      });
    }
    if (json['hourly'] != null) {
      hourly = [];
      json['hourly'].forEach((v) {
        hourly!.add(Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily!.add(Daily.fromJson(v));
      });
    }
  }
}

class Current {
  dynamic dt;
  dynamic sunrise;
  dynamic sunset;
  dynamic temp;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic uvi;
  dynamic clouds;
  dynamic visibility;
  dynamic windSpeed;
  dynamic windDeg;
  List<Weather>? weather;

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }
}

class Weather {
  dynamic id;
  String? main;
  String? description;
  String? icon;

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Minutely {
  dynamic dt;
  dynamic precipitation;

  Minutely.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    precipitation = json['precipitation'];
  }
}

class Hourly {
  dynamic dt;
  dynamic temp;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic uvi;
  dynamic clouds;
  dynamic visibility;
  dynamic windSpeed;
  dynamic windDeg;
  dynamic windGust;
  List<Weather>? weather;
  dynamic pop;

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    pop = json['pop'];
  }
}

class Daily {
  dynamic dt;
  dynamic sunrise;
  dynamic sunset;
  dynamic moonrise;
  dynamic moonset;
  dynamic moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic windSpeed;
  dynamic windDeg;
  dynamic windGust;
  List<Weather>? weather;
  dynamic clouds;
  dynamic pop;
  dynamic uvi;

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
  }
}

class Temp {
  dynamic day;
  dynamic min;
  dynamic max;
  dynamic night;
  dynamic eve;
  dynamic morn;

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
}

class FeelsLike {
  dynamic day;
  dynamic night;
  dynamic eve;
  dynamic morn;

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
}
