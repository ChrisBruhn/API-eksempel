import java.util.Arrays;     //<>//
import java.util.Iterator;  

class APIController {
  JSONObject jobj;
  //String stockCode = "MSFT"; // Microsoft aktiekurser
  String stockCode = "AAPL"; // Microsoft aktiekurser
  String[] json;
  //Bubble[] b;
  Bubble[] bubbles;


  void initAPIController() {
    while (!loadJsonData()); // henter datafra fil 
    bubbles = loadData(); // når data er hentet skal de indlæses
  }

  boolean loadJsonData() {
    // jeg ser lige om der ligger en lokal kopi ellers henter jeg fra nettet
    try {
      jobj = loadJSONObject("data.json");
      return true;
    }
    catch (Exception e) {
      updateData();
      return false;
    }
  }

  void updateData() {
    getJasonData();     // hent fra internetserver
    saveJsonData();     // gen som json fil
  }

  void getJasonData() {
    this.json = loadStrings("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="+stockCode+"&apikey=9BT0NSQQSBCTYQUR");
  }

  void saveJsonData() {
    saveStrings ("data.json", this.json); // Gem data på disk med filnavn data.json
  }

  Bubble[] loadData() {
    // henter den del som er time series

    JSONObject bubbleData = jobj.getJSONObject("Time Series (Daily)");
    Bubble[] bubbles = new Bubble[bubbleData.size()]; // sætter størrelsen på array efter hvor mange der er

    int i=0;// array index

    // json data læser jeg og oprettet mit eget objekt for hvert jsonobjekt 
    Iterator it = bubbleData.keys().iterator();
    while (it.hasNext()) {
      String str = it.next().toString();
      JSONObject b = bubbleData.getJSONObject(str);
      float open = b.getFloat("1. open");
      float high = b.getFloat("2. high");
      float low =  b.getFloat("3. low");
      float close =  b.getFloat("4. close");
      int vol =  b.getInt("5. volume");

      // opret mit eget objekt
      Bubble bu = new Bubble(str, open, high, low, close, vol);
      // tilføj til array
      bubbles[i]=bu;
      i++;
    }
    Arrays.sort(bubbles); // for at være sikker på at de er sorteret efter dato
    return bubbles;
  }

  Bubble[] getBubbleArray() {
    return this.bubbles;
  }

  Bubble getBubbleByDate(String str) {
    Date d = makeDate(str);
    Bubble b1 = new Bubble("2000-01-01", 0, 0, 0, 0, 0);
    for (Bubble b : bubbles) {
      if (b.getDate().equals(d)) {
        b1=b;
      }
    }
    return b1;
  }


  void printAll() {

    // Display all bubbles
    int i =0;  // til at styre y pos
    int x=50;  // x pos
    for (Bubble b : bubbles) {
      text(makeStringDate(b.getDate())+" "+b.getClose(), x, 50+i*20 );
      if (50+i*20>height-80) {
        x=x+400;
        i=-1;
      }
      i++;
    }
  }

  Date makeDate(String str) {
    // konstruer en dato
    StringToDateTime stdt = new StringToDateTime();
    stdt.StringToDate(str);
    Date d = stdt.date;
    return d;
  }
  
  String makeStringDate(Date d){
    StringToDateTime stdt = new StringToDateTime();
    return stdt.formatMyDate(d);
  }

  void setStockCode(String s) {
    this.stockCode = s; // set ny aktie kode
    
  }

  String getStockCode() {
    return this.stockCode;
  }
}

// Modified Bubble json example from processing.org

class Bubble implements Comparable<Bubble> {
  float open, high, low, close, vol;
  Date date;

  // Create  the Bubble
  Bubble(String name, float open, float high, float low, float close, float vol) {
    this.open = open;
    this.high = high;
    this.low = low;
    this.close = close;
    this.vol = vol;


    StringToDateTime stdt = new StringToDateTime();
    stdt.StringToDate(name);
    this.date = stdt.date;
  }

  float getOpen() {
    return this.open;
  }
  float getHigh() {
    return this.high;
  }
  float getLow() {
    return this.low;
  }
  float getClose() {
    return this.close;
  }
  float getVol() {
    return this.vol;
  }
  String getOpenString() {
    return String.valueOf(open);
  }
  Date getDate() {
    return date;
  }

  // har implementeret comparable for at kunne sortere på datoen
  @Override
    public int compareTo(Bubble b) {
    return this.date.compareTo(b.date);
  }
}

// har implementeret comparable for at kunne sortere på datoen
import java.util.Comparator;

 class BubbleComparator implements Comparator<Bubble> {

    @Override
    public int compare(Bubble b1, Bubble b2) {
           return b1.date.compareTo(b2.date);     
    }
}

// https://www.w3schools.blog/string-to-date-java
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

class StringToDateTime {

  Date date;
  StringToDateTime() {}

  void StringToDate(String date_time) {
    //String date_time = "11/27/2020 05:35:00";
    //SimpleDateFormat dateParser = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
    SimpleDateFormat dateParser = new SimpleDateFormat("yy-MM-dd");
    {
      try {
        date = dateParser.parse(date_time);
      } 
      catch (ParseException e) {
        e.printStackTrace();
      }
    }
  }  

String formatMyDate(Date date) {
  SimpleDateFormat DateFor = new SimpleDateFormat("dd-MM-yyyy");
  String stringDate= DateFor.format(date);
  //System.out.println(stringDate);
  return stringDate;
}

}
