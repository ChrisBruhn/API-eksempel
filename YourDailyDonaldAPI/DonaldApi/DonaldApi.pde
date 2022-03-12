class Donald { //<>// //<>// //<>// //<>//

  JSONObject jobj;
  //JSONObject json;
  String direction;
  PImage img;

  Donald() {
  }


  void setupData() {
    getData();
    setDonaldData();
  }

  void getData() {
    String txt=getData("https://api.tronalddump.io/random/quote?format=json");  
    jobj = parseJSONObject(txt);
  }

  void loadData() {
    this.jobj = loadJSONObject("donald.json");
  }


  void setDonaldData() {
    String ds = jobj.getString("value");
    String[] list = split(ds, ' ');  
    String s="";
    int x=10; // xpos
    int y=50;  // ypos
    int sum=0;  // til at lave en linjo som ikke er længre end skærmen 


    for (int i =0; i<list.length; i++)
    {
      if(sum < (width/16)){ //<>//
        s = s+list[i] +" ";
        sum = list[i].length()+1+sum;
      
      }
      else{
        text(s+list[i], x, y);  //<>//
        y=y+25; //ny linje;
        x=10;
        s="";
        sum=0;
      }
    }  //<>//
    // printer sidste linje
    text(s, x, y);  
  }



  String getData(String urlsite) {
    //lånt fra https://discourse.processing.org/t/cant-open-an-url-with-loadjsonobject-but-it-works-with-http-library/19293/3

    String htmlText="";
    ;

    try {
      // Create a URL object
      URL url = new URL(urlsite);
      URLConnection conn = url.openConnection();
      conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");
      // Read all of the text returned by the HTTP server
      BufferedReader in = new BufferedReader
        (new InputStreamReader(conn.getInputStream(), "UTF-8"));

      String readLine;

      while ( (readLine = in.readLine ()) != null) {
        // Keep in mind that readLine() strips the newline characters
        //println(readLine);
        htmlText = htmlText+'\n'+readLine;
      }
      in.close();
    } 
    catch (MalformedURLException e) {
      e.printStackTrace();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }

    return htmlText;
  }
}
