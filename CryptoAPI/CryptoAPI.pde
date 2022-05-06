APIController ac;


void setup() {
  size(600, 400);
  // data controller
  ac = new APIController(); // opret en instans af klassen
  ac.setStockCode("BTC"); // Bestemmer hvilken kurs som skal hentes
  ac.initAPIController(); 
  fill(0);
}

void draw() {
  background(225);
  // udskriv aktie koden til skærm som overskrift
  textSize(24);
  text(ac.getStockCode(),width/2,20);
  textSize(16);
  // udskriv fra objekt
  ac.printAll();
  
  // udskriv herfra 
  udskriv();
}

void udskriv(){
  println("stockCode "+ac.stockCode);
  println("currencyCode "+ac.currencyCode);
  println("from "+ac.from);
  println("fromName "+ac.fromName);
  println("toCurrency "+ac.toCurrency);
  println("toCurrencyName "+ac.toCurrencyName);
  println("exchangeRate "+ac.exchangeRate);
  println("fromDate "+ac.fromDate);

}
