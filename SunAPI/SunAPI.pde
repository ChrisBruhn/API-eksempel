Weather w = new Weather();


void setup() {
   size(400,600); //<>//
  // hent vejr
  w.setdateFrom("2022-03-01");
  w.setdateTo("2022-03-18");
  println("de sidste 7 dage: "+w.getLastWeek()+"Timers solskin");

}

void draw() {
  
}
