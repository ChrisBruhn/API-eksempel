Weather w = new Weather();


void setup() {
   size(400,600);
  // hent vejr
  w.setupData();
//  print(w.getDirection()+" ");
//  println(w.getWindspeed()+" m/s");
  textAlign(CENTER);

}

void draw() {
  compasRose();
  
    drawArrow(width/2,height/2+50,100,w.calcDirection());

}


void compasRose(){
  
  fill(0);
  textSize(30);
  text(w.getDirection()+" "+w.getWindspeed()+" m/s",width/2,100);
  text("N",width/2,200);
  text("S",width/2,height-100);
  text("V",50,height/2+50);
  text("Ø",width-50,height/2+50);
}

void drawArrow(int cx, int cy, int len, float angle){
  strokeWeight(3);
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
  strokeWeight(1);
}
