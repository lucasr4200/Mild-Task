class Group {
  String title;
  String location;
  //To Add: date class
  int date;
  String day;
  int groupSize;
  String time;

  Group(this.title, this.location, this.date, this.day, this.groupSize,
      this.time);
}

class Person {
  String name;

  Person(this.name);
}

class GroupChat {
  Group event;
  List<Person> attendees;

  GroupChat(this.event, this.attendees);
}
