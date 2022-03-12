import java.util.Iterator; 

APIController ac;
ArrayList<Valuta> valutaL = new ArrayList<Valuta>();
ArrayList<SingleStock> st = new ArrayList<SingleStock>();


void setup() {
  ac= new APIController();
  ac.getJasonData();
  size(400, 800);
  fill(0);
  textSize(28);
}


void draw() {
  background(225);
  textSize(28);

  // text(ac.getDate(), 100, 25);
  //v.printAll();
  //valutaL = v.getAllValuta();
  //st = ac.getAllValues();
  st = ac.getMetaData();


  int i =0;
  int x =50;
  int y =0;
  textSize(12);

  for (Valuta val : valutaL) {
    y=100+15*i;
    // rund af til 2 dec 
    float k =round(val.kurs*100)/100.0;
    text(val.valuta+" "+k, x, y);
  
    
    i++;
    if (y>=height-100) {
      x=x+100;
      i=0;
    }
  }
  
  // ryd arraylist så den ikke vokser 
  valutaL.clear();
}



/*
  // printer alle kurser ud 
 //println(jobj.getJSONObject("rates"));
 
 //Finder kursen for 1 EUR i DKK
 float rate = jobj.getJSONObject("rates").getFloat("DKK");
 // afrund til to decimaler og udskriv til skærm
 println(String.format("%.2f", rate), "i DKK ");
 
 //********** NOK *********************
 // udskrive base valuta
 print("1 ", jobj.getString("base"), " koster: ");
 //Finder kursen for 1 EUR i NOK
 rate = jobj.getJSONObject("rates").getFloat("NOK");
 // afrund til to decimaler og udskriv til skærm
 println(String.format("%.2f", rate), "i NOK ");
 
 */
