/* //<>// //<>// //<>// //<>// //<>//

Ændre ikke i denne kode!
lavet af Christian 
*/

import java.util.Arrays;    

class APIController {
  JSONObject jobj;


  String stockCode = ""; // koden for BITCOIN er BTC
  String currencyCode = "DKK"; // valutaen det skal omregnes til
  String from;
  String fromName;
  String toCurrency;
  String toCurrencyName;
  float exchangeRate;
  String fromDate;
  String[] json;



  void initAPIController() {
    while (!loadJsonData()); // henter datafra fil 
    loadData(); // når data er hentet skal de indlæses
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

  // lav en url til forspørgsel
  void getJasonData() {
    this.json = loadStrings("https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency="+stockCode+"&to_currency="+currencyCode+"&apikey=9BT0NSQQSBCTYQUR");
  }

  void saveJsonData() {
    saveStrings ("data.json", this.json); // Gem data på disk med filnavn data.json
  }

  void loadData() {
    // henter den del som er time series
    JSONObject bubbleData = jobj.getJSONObject("Realtime Currency Exchange Rate");
    from = bubbleData.getString("1. From_Currency Code");
    fromName = bubbleData.getString("2. From_Currency Name");
    toCurrency = bubbleData.getString("3. To_Currency Code");
    toCurrencyName = bubbleData.getString("4. To_Currency Name");
    exchangeRate = bubbleData.getFloat("5. Exchange Rate");
    fromDate = bubbleData.getString("6. Last Refreshed");
  }





  void printAll() {

    float x=50;
    float y=50;

    text( fromName+" ("+from+") koster i "+toCurrencyName+" ("+toCurrency+") "+exchangeRate, x, y);
    text( fromDate, x, y+50);
  }

  Date makeDate(String str) {
    // konstruer en dato
    StringToDateTime stdt = new StringToDateTime();
    stdt.StringToDate(str);
    Date d = stdt.date;
    return d;
  }

  String makeStringDate(Date d) {
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
  float exchangeRate;
  String fromName, toName, toCurrency, toCurrencyName, strDate;
  Date date;

  // Create  the Bubble
  Bubble(String fromName, String toName, String toCurrency, String strDate) {
    this.fromName = fromName;
    this.toName = toName;
    this.toCurrency = toCurrency;
    StringToDateTime stdt = new StringToDateTime();
    stdt.StringToDate(strDate);
    this.date = stdt.date;
  }

  String getFromName() {
    return this.fromName;
  }

  String gettoName() {
    return this.toName;
  }

  String getToCurrency() {
    return this.toCurrency;
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
  StringToDateTime() {
  }

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
