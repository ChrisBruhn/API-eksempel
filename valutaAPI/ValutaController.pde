class ValutaController { //<>// //<>// //<>// //<>//

  JSONObject rates;
  JSONObject jobj;
  String[] json;
  ArrayList<Valuta> valutaList = new ArrayList<Valuta>();


  ValutaController() {
    // henter datafra fil 
    loadJsonData();
  }



  void getJasonData() {
    // har kun 250 pr måned så jeg bruger gemte data
    // String[] json = loadStrings("http://data.fixer.io/api/latest?access_key=de0b27c2424c52cd42c240e790573903&format=1");
    this.json = loadStrings("http://data.fixer.io/api/latest?access_key=de0b27c2424c52cd42c240e790573903&format=1");
    //this.jobj = parseJSONObject(this.json);
  }

  void saveJsonData() {
    // Gem data på disk med filnavn data.json
    saveStrings ("data.json", this.json);
  }

  void loadJsonData() {
    // har kun 250 pr måned så jeg bruger gemte data
    // indlæs data igen, denne gang som objekt

    this.jobj = loadJSONObject("data.json");
    this.rates = jobj.getJSONObject("rates");

    //hvis jeg hellere vil have de som string
    //this.json = loadStrings("data.json");

    //String n = this.jobj.getString("rates");
    //this.jobj = parseJSONObject(this.json);
  }

  void printAll() {
    //println(rates.keys());
    Valuta v;

    Iterator it = rates.keys().iterator();

    while (it.hasNext()) {
      //println(it.next());
      String s = it.next().toString();

      float kur = rates.getFloat(s);
      v= new Valuta(kur, s);

      valutaList.add(v);
      it.next();
    }



    for (Valuta val : valutaList) {
      val.display();
    }
    /*
    // udskriver alle data til consol men fra en string[] og ikke json obj 
     for (String s : json ) {
     println  ( s  );
     }
     */
  }


  ArrayList<Valuta> getAllValuta() {
    //println(rates.keys());
    Valuta v;

    Iterator it = rates.keys().iterator();

    while (it.hasNext()) {
      //println(it.next());
      String s = it.next().toString();

      float kur = rates.getFloat(s);
      v= new Valuta(kur, s);

      valutaList.add(v);
      it.next();
    }
    return valutaList;
  }


  void fillArrayList() {
    Valuta v;    

    JSONObject values = this.jobj.getJSONObject("rates");
    for (String s : json ) {

      String[] tmp = split(s, ':');
      v=new Valuta(float(tmp[0]), tmp[1]);
      println  ( s  );
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
