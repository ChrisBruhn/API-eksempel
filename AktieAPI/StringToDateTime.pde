// https://www.w3schools.blog/string-to-date-java
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

class StringToDateTime {
    
    Date date;
    //SimpleDateFormat dateFormatter;
    
      StringToDateTime(String date_time){ //<>//
        
        //String date_time = "11/27/2020 05:35:00";
        SimpleDateFormat dateParser = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
        {
            try {
                date = dateParser.parse(date_time);
                //System.out.println(date);

                //SimpleDateFormat dateFormatter = new SimpleDateFormat("yy-MM-dd");
                //System.out.println(dateFormatter.format(date));

            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
    }
}
