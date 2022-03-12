class APIController { //<>// //<>// //<>//

  //JSONObject rates;
  JSONObject intraday; 
  JSONObject jobj;
  String[] json;
  ArrayList<Valuta> valutaList = new ArrayList<Valuta>();
  ArrayList<SingleStock> stockList = new ArrayList<SingleStock>();


  APIController() {
    // henter datafra fil 
    while (!loadJsonData());
  }


  void updateData() {
    getJasonData();     // hent fra internetserver
    saveJsonData();     // gen som json fil
  }

  void getJasonData() {
    this.json = loadStrings("https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=FB&interval=60min&apikey=9BT0NSQQSBCTYQUR");
  }

  void saveJsonData() {
    // Gem data på disk med filnavn data.json
    saveStrings ("data.json", this.json);
  }

  boolean loadJsonData() {
    // indlæs data igen, denne gang som objekt
    // hvis filen ikke findes så henter jeg nye data fra nettet
    
    //hvis jeg hellere vil have de som string
    this.json = loadStrings("data.json");
    
    
    try {
      this.jobj = loadJSONObject("data.json");
      //this.rates = jobj.getJSONObject("Meta Data");
      this.intraday = jobj.getJSONObject("Meta Data");
      println("41 - !");
      return true;
    }
    catch (Exception e) {
      updateData();
      return false;
    }


    

    //String n = this.jobj.getString("Meta Data");
    //this.jobj = parseJSONObject(this.json);
  }

  void printAll() {
    //println(rates.keys());
    //Valuta v;
    SingleStock s;

    //Iterator it = rates.keys().iterator();
     Iterator it = intraday.keys().iterator();

    while (it.hasNext()) {
      //println(it.next());
      String str = it.next().toString();

      //float kur = rates.getFloat(str);
      float kur = intraday.getFloat(str);
      println("72",kur);
      //v= new Valuta(kur, s);

      //valutaList.add(v);
      //stockList.add(s);
      
      it.next();
    }



    for (Valuta val : valutaList) {
      val.display();
    }
    /*
    // udskriver alle data til consol men fra en string[] og ikke json obj 
     for (String s : json ) {
     println  ("89", s  );
     }
     */
  }


  ArrayList<SingleStock> getMetaData() {
    //println(rates.keys());
    //Valuta v;
    SingleStock st;

    //Iterator it = rates.keys().iterator();
    Iterator it = intraday.keys().iterator();
    while (it.hasNext()) {
      //println("104",it.next());
      String s = it.next().toString();
      print(s," : ");
      String kur = intraday.getString(s);
      println(kur);
      
      
      //println("106",it.next().toString());
      //float kur = rates.getFloat(s);
      //print(it.next().toString());
      
      
      //v= new Valuta(kur, s);
      //st = new SingleStock();

      //valutaList.add(v);
      //stockList.add(st);
      //it.next();
    }
    //return valutaList;
    return stockList;
  }


  void fillArrayList() {
    Valuta v;    

    JSONObject values = this.jobj.getJSONObject("rates");
    for (String s : json ) {

      String[] tmp = split(s, ':');
      v=new Valuta(float(tmp[0]), tmp[1]);
      println  ("130", s  );
      //valutaList
    }
  }

  boolean succes() {
    // er success hvis det lykkedes at få data fra server
    return jobj.getBoolean("success");
  }

  void returnDate() {
    // brug https://www.epochconverter.com/ for at regne dato ud ;) det er et unix time stamp
    int timeStamp = jobj.getInt("timestamp");
    // konverter unix time stamp til en rigtig dato
    java.util.Date time=new java.util.Date((long)timeStamp*1000);
    // udskriv dato
    println("Kurserne er sidst opdateret: ", time);
  }



  String getDate() {
    // returnerer dato
    return jobj.getString("date");
  }


  String getBaseValuta() {
    // udskrive base valuta
    return jobj.getString("base");
  }


  float returnKurs(String v) {
    float rate = jobj.getJSONObject("rates").getFloat(v);
    return rate;
  }
}
