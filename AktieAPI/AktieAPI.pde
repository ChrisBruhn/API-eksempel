APIController ac; //<>//


void setup() {
  size(1800, 1200);
  
  // data controller
  ac = new APIController();
  ac.setStockCode("GOOGL");
     
  fill(0);
  
}

void draw() {
  background(225);
  
  
  // udskriv aktie koden til skærm som overskrift
  textSize(24);
  text(ac.getStockCode(),width/2,20);
  textSize(16);
  // udskriv alle
  ac.printAll();
  
  // find kurs fra en bestemt dato
  
  // bed ac om at finde den 
  Bubble b = ac.getBubbleByDate("2022-03-11");
  // udskriv
  text(b.getDate().toString()+" "+b.getClose()+" searched and found on date only", 50, height-20 );
}
