class Weather {  //<>// //<>//

  JSONObject jobj;
  //DayData[] dayDataList = new DayData[7];
  ArrayList<DayData> dayDataList = new ArrayList<DayData>();
  String dateFrom = "";
  String dateTo = "";


  Weather() {
    setupData();
  }


  void setdateFrom(String df){
    this.dateFrom = df;
  }
  void setdateTo(String dt){
    this.dateTo = dt;
  }

  void setupData() {
    getData(); 
    loadData();
    setWeatherData();
  }

  void getData() {
    // henter vejret fra Aabenraa
    // danmark String[] json = loadStrings("https://dmigw.govcloud.dk/v2/climateData/collections/countryValue/items?countryId=Danmark&datetime=..%2F2022-03-17T12%3A31%3A12Z&parameterId=bright_sunshine&bbox-crs=https%3A%2F%2Fwww.opengis.net%2Fdef%2Fcrs%2FOGC%2F1.3%2FCRS84&api-key=a557255e-d605-410a-adbe-ee588279f3a2");
    // time String[] json = loadStrings("https://dmigw.govcloud.dk/v2/climateData/collections/municipalityValue/items?municipalityId=0580&datetime=2022-02-12T00%3A00%3A00Z%2F2022-03-18T12%3A31%3A12Z&parameterId=bright_sunshine&bbox-crs=https%3A%2F%2Fwww.opengis.net%2Fdef%2Fcrs%2FOGC%2F1.3%2FCRS84&api-key=a557255e-d605-410a-adbe-ee588279f3a2");
    //dag:
    
    String[] json = loadStrings("https://dmigw.govcloud.dk/v2/climateData/collections/municipalityValue/items?municipalityId=0580&datetime="+dateFrom+"T00%3A00%3A00Z%2F"+dateTo+"T12%3A31%3A12Z&parameterId=bright_sunshine&timeResolution=day&bbox-crs=https%3A%2F%2Fwww.opengis.net%2Fdef%2Fcrs%2FOGC%2F1.3%2FCRS84&api-key=a557255e-d605-410a-adbe-ee588279f3a2");
    saveStrings ("vejrdata.json", json);
  }



  void loadData() {
    this.jobj = loadJSONObject("vejrdata.json");
  }

  void setWeatherData() {
    // String ws = jobj.getJSONObject("CurrentData").getString("windText");
    JSONArray values = jobj.getJSONArray("features");

    int length = values.size();      

    for (int i=0; i<length; i++) {
      if (values.getJSONObject(i)!= null) {

        JSONObject jso = values.getJSONObject(i).getJSONObject("properties");

        String minicipalityID   = jso.getString("municipalityId");
        String parameterId      = jso.getString("parameterId");
        String created          = jso.getString("created");
        String from             = jso.getString("from");
        String to               = jso.getString("to");
        String municipalityName = jso.getString("municipalityName");
        float value               = jso.getFloat("value");

        dayDataList.add(new DayData(minicipalityID, parameterId, created, from, to, municipalityName, value));
      }
    }
  }

  int getLength() {
    return dayDataList.size();
  }

  float getLastWeek() {
    float sum=0;

    for (int i=0; i < 8; i++) {
      sum= sum +dayDataList.get(i).getValue();
      }
    return sum;
  }
}

import java.util.Date;
import java.text.SimpleDateFormat;

class DayData {
  String minicipalityID;
  String parameterId;
  Date created;
  Date from;
  Date to;
  String municipalityName;
  float value;


  DayData(String minicipalityID, String parameterId, String created, String from, String to, String municipalityName, float value) {
    //SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss zzz");
    //Date date = sdf.parse(time);

    this.minicipalityID   = minicipalityID;
    this.parameterId      = parameterId;
    this.created          = parseDateExp(created);
    this.from             = parseDateExp(from);
    this.to               = parseDateExp(to);
    this.municipalityName = municipalityName;
    this.value            = value;
  }


  Date parseDateExp(String d) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    d = d.substring(0, 10);
    //2022-03-09T00:00:00.001000+01:00

    Date date = new Date();
    try {
      date = sdf.parse(d);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    return date;
  }

  void display() {
    println(from, " timer med sol: ", value);
  }
  
  float getValue() {
    return this.value;
  }
  Date getFromDate(){
    return this.from;
  }
  Date getToDate(){
    return this.to;
  }
}
