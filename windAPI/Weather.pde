class Weather {

  JSONObject jobj;
  String direction;
  float windspeed;

  Weather() {
  }


  void setupData() {
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


  int calcDirection() {

    switch(direction) {

    case "Nord": 
      return 270;

    case "Syd": 
      return 90;

    case "Øst": 
      return 0;

    case "Vest": 
      return 180;

    case "Sydvest": 
      return 135;  

    case "Sydøst": 
      return 45;
      
    case "Nordvest": 
      return 225  ;
      
    case "Nordøst": 
      return 315;


    default:
      return 180;
      
    }
    
  }

  float getWindspeed() {
    return windspeed;
  }
}
