class Valuta {

  float kurs;
  String valuta;

  Valuta(float k, String v) {

    kurs=k;
    valuta=v;
  }

  float getKurs() {
    return kurs;
  }

  String getValuta() {
    return valuta;
  }
  
  void setKurs(float k){
  this.kurs=k;
  
  }
  
  void setString(String v){
  this.valuta =v; 
  }
  
  void display(){
   println(valuta+','+kurs);
  }
}
