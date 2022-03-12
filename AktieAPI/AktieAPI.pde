import java.util.Iterator;  //<>// //<>// //<>//
import java.util.Arrays;   


// An Array of Bubble objects
Bubble[] bubbles;

APIController ac;

ArrayList<Bubble> bubbleList = new ArrayList<Bubble>();


// A JSON object
JSONObject json;

void setup() {
  size(640, 800);
  ac = new APIController();

  Arrays.sort(bubbles);   
  fill(0);
  textSize(16);
  
  
}

void draw() {
  background(225);
  
  int i =0;  
  // Display all bubbles
  for (Bubble b : bubbles) {
    //b.display();
    text(b.getDate().getHours()+":"+b.getDate().getMinutes()+" "+b.getHigh(),50,50+i*20 );
    
    i++;
    
  }
  
}




  
