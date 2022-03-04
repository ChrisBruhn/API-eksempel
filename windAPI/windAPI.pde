Weather w = new Weather();


void setup() {
  
  // hent vejr
  w.setupData();
  print(w.getDirection()+" ");
  println(w.getWindspeed()+" m/s");
  
  
  
}

void draw() {
}
