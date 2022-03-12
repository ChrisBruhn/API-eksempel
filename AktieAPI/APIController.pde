class APIController {  //<>// //<>// //<>// //<>//


  JSONObject intraday; 
  JSONObject jobj;
  
  String[] json;
  //ArrayList<Valuta> valutaList = new ArrayList<Valuta>();
  //ArrayList<SingleStock> stockList = new ArrayList<SingleStock>();
  ArrayList<Bubble> bubbleList = new ArrayList<Bubble>();


  APIController() {
    // henter datafra fil 
    while (!loadJsonData()); //<>//
        loadData();
  }


  void updateData() {
    getJasonData();     // hent fra internetserver //<>//
    saveJsonData();     // gen som json fil

  }

  void getJasonData() {
    this.json = loadStrings("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=9BT0NSQQSBCTYQUR");
  }

  void saveJsonData() {
    // Gem data på disk med filnavn data.json
    saveStrings ("data.json", this.json);
  }

  boolean loadJsonData() {
    // indlæs data igen, denne gang som objekt
    // hvis filen ikke findes så henter jeg nye data fra nettet

    //hvis jeg hellere vil have de som string
    //this.json = loadStrings("data.json");
    //  this.jobj = loadJSONObject("data.json");
 //<>//

    try {
      //this.jobj = loadJSONObject("data.json"); //<>//
      jobj = loadJSONObject("data.json");
      //this.rates = jobj.getJSONObject("Meta Data");
      //this.intraday = jobj.getJSONObject("Meta Data");
      return true;
    }
    catch (Exception e) {
      updateData();
      return false;
    }
  }


void loadData() {
  //  JSONArray bubbleData = json.getJSONArray("Meta Data");
  JSONObject bubbleData = jobj.getJSONObject("Time Series (Daily)"); //<>//

  // The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  
  bubbles = new Bubble[bubbleData.size()]; // sætter størrelsen på array efter hvor mange der er

  int i=0;// counter for array
  Iterator it = bubbleData.keys().iterator();
  while (it.hasNext()) {
    String str = it.next().toString();

    JSONObject b = bubbleData.getJSONObject(str);

    float open = b.getFloat("1. open");
    float high = b.getFloat("2. high");
    float low =  b.getFloat("3. low");
    float close =  b.getFloat("4. close");
    int vol =  b.getInt("5. volume");

    Bubble bu = new Bubble(str, open, high, low, close, vol);

    bubbles[i]=bu;
    i++;
  }
}


}
  
