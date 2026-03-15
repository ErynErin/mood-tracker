class MoodEntry {
  DateTime dateTime;
  
  String name;
  String? nickname;
  int age;
  bool exercisedToday;
  String emotion;
  double emotionIntensity;
  String weather;

  int get year => dateTime.year;
  int get day => dateTime.day;
  
  String get month { // Converts month number to month name
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[dateTime.month - 1];
  }

  String get time {
    // Convert to 12-hour format
    int hour = dateTime.hour % 12;

    // Handle the case for 12 AM and 12 PM
    if (hour == 0){
      hour = 12; 
    }

    // Determine AM or PM
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    // Pad minutes with a leading zero if needed (e.g., 9:05 instead of 9:5)
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  MoodEntry(
    this.dateTime,
    this.name,
    this.nickname,
    this.age,
    this.exercisedToday,
    this.emotion,
    this.emotionIntensity,
    this.weather,
  );
}