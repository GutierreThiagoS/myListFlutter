
import 'package:intl/intl.dart';

String formatDateNumber(String input) {

  String cleanInput = input.replaceAll(RegExp("[^0-9]"), "");
  DateFormat yearFormat = DateFormat('yyyy');
/*  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateFormat timerFormat = DateFormat('yyyyMMdd');*/
  DateTime date = DateTime.now();

  String day = cleanInput.substring(0, getValueLength(2, cleanInput.length));
  String moth = "";

  if (cleanInput.length <= 2 && cleanInput.isNotEmpty) {
    return getDayInMoth(day, "12");
  } else {
    moth = cleanInput.substring(2, getValueLength(4, cleanInput.length));
    if (int.parse(moth) > 12) {
      moth = "12";
    } else if (moth == "00"){
      moth= "01";
    }
    day = getDayInMoth(day, moth);
  }
  if (cleanInput.length > 4) {
    String yearMoment = yearFormat.format(date);
    String year = cleanInput.substring(4, getValueLength(8, cleanInput.length));
    print("year $year, yearMoment $yearMoment");
    if (year.length == 4) {
      if (int.parse(year) < int.parse(yearMoment)) {
        return '$day/$moth/$yearMoment';
      } else if ((int.parse(yearMoment) + 5) < int.parse(year))
        return "$day/$moth/${int.parse(yearMoment) + 5}";
      else {
        return '$day/$moth/$year';
      }
    } else {
      return '$day/$moth/$year';
    }
  } else if (cleanInput.length > 2) {
    return '$day/$moth';
  }
  else {
    return day;
  }
}

int getValueLength(int limit, int length) {
  if (length >= limit) {
    return limit;
  } else {
    return length;
  }
}

String getDayInMoth(String day ,String moth) {

  print(day);
  int dayInt= int.parse(day);
  int mothInt = int.parse(moth);

  if (mothInt == 2 && dayInt > 29) {
    return  "29";
  } else if ([1, 3, 5, 7, 8, 10, 12].contains(mothInt) && dayInt > 31) {
    return "31";
  } else if ([4, 6, 9, 11].contains(mothInt) && dayInt > 30) {
    return "30";
  } else if (day == "00") {
    return "01";
  }
  else {
    return day;
  }
}

/*
private fun formatHourNumber(input: String): String {

val cleanInput = input.replace(Regex("[^0-9]"), "")

return buildString {
Log.e("buildString", this.toString())
if (cleanInput.length >= 2) {
val hour = cleanInput.substring(0, 2)
append(if (hour.toIntNotNull() < 24) hour else "00")
if (cleanInput.length >= 3) append(":")
if (cleanInput.length >= 4) {
val minutes = cleanInput.substring(2, 4)
append(if (minutes.toIntNotNull() < 60) minutes else "00")
} else append(cleanInput.substring(2, cleanInput.length))
} else append(input)
}
}*/

String formatHourNumber(String input) {
  String cleanInput = input.replaceAll(RegExp("[^0-9]"), "");
  print("cleanInput $cleanInput");
  String hour = "";

  if (cleanInput.length >= 2 && cleanInput.isNotEmpty) {
    hour = cleanInput.substring(0, getValueLength(2, cleanInput.length));
    if(int.parse(hour) > 23) {
      hour = "00";
    }
  } else {
    hour = cleanInput;
  }

  if (cleanInput.length >= 4) {
    print("length >= 4  $cleanInput");
    String minutes = cleanInput.substring(2, getValueLength(4, cleanInput.length));
    if (int.parse(minutes) >= 60) {
      String minutes = "00";
      return "$hour:$minutes";
    } else {
      return "$hour:$minutes";
    }
  } else {
    if(cleanInput.length == 3) {
      print("length >= 3  $cleanInput");

      return "$hour:${cleanInput.substring(2, 3)}";
    } else {
      return hour;
    }
  }
}

// format your given time
getFormattedDateFromFormattedString(String value) {
  DateFormat currentDateFormat = DateFormat('dd/MM/yyyy HH:mm');
  DateFormat newDateFormat = DateFormat('yyy-MM-dd HH:mm:ss');
  var dateTime = "";
  if (value.isNotEmpty) {
    try {
      var parse = currentDateFormat.parse(value);
      dateTime = newDateFormat.format(parse);
    } catch (e) {
      print("$e");
    }
  }
  print(dateTime);

  return dateTime;
}