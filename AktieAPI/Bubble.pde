// A Bubble class

class Bubble implements Comparable<Bubble> {
  float open, high, low, close, vol;
  Date date;

  // Create  the Bubble
  Bubble(String name, float open, float high, float low, float close, float vol) {
    this.open = open;
    this.high = high;
    this.low = low;
    this.close = close;
    this.vol = vol;

    StringToDateTime stdt = new StringToDateTime(name);
    this.date = stdt.date;
  }

  float getOpen() {
    return this.open;
  }
  float getHigh() {
    return this.high;
  }
  float getLow() {
    return this.low;
  }
  float getClose() {
    return this.close;
  }
  float getVol() {
    return this.vol;
  }

  String getOpenString() {
    return String.valueOf(open);
  }
  Date getDate() {
    return date;
  }






  void display() {
    println (date, "", open, "", high, "", low, "", close, "", vol);
  }

  // har implementeret comparable for at kunne sortere på datoen
  @Override
    public int compareTo(Bubble b) {
    return this.date.compareTo(b.date);
  }
}
