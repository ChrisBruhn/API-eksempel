class SingleStock{

  String date="";
  float open,
      high,
      low,
      close;
  
  int volumen = 0;

SingleStock(){}

String getDate(){
  return this.date;
}
float getOpen(){
  return this.open;
}
float getHigh(){
  return this.high;
}
float getLow(){
  return this.low;
}
float getClose(){
  return this.close;
}


void getDate(String date){
  this.date=date;
}
void getOpen(float open){
  this.open=open;
}
void getHigh(float high){
  this.high = high;
}
void getLow(float low){
  this.low = low;
}
void getClose(float close){
  this.close = close;
}

  void display(){
   println(date);
   println("open",open);
   println("high",high);
   println("low",low);
   println("close",close);
  }




}
