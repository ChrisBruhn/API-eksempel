class Weather {

  JSONObject jobj;
  String direction;
  float windspeed;

  Weather() {
    
  }


  void setupData(){
    getData();
    loadData();
    setWeatherData();
  }

  void getData() {
    // henter vejret fra Aabenraa
    String[] json = loadStrings("https://vejr.eu/api.php?location=Aabenraa&degree=C");
    saveStrings ("vejrdata.json", json);
  }

  void loadData() {
    this.jobj = loadJSONObject("vejrdata.json");
  }

  void setWeatherData() {
    String ws = jobj.getJSONObject("CurrentData").getString("windText");
    String[] list = split(ws, ' ');
    this.windspeed = float(list[0]);
    this.direction = list[2];
  }


  String getDirection() {
    return direction;
  }

  float getWindspeed() {
    return windspeed;
  }
}
