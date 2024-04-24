class TaskModel {
  static const String collectionName="Tasks";
  String? id;
  String? title;
  String? description;
  int? date;
  bool? isDone;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.userId,
    required this.date,
    this.isDone = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json) :this(
      title: json["title"],
      description: json["description"],
      date: json["date"],
      id: json['id'],
      isDone: json['isDone'],
      userId: json['userId'],
  );

  Map<String,dynamic> toJson(){
    return{
      "title":title,
      "description":description,
      "date":date,
      "id":id,
      "isDone":isDone,
      "userId":userId,
    };
  }
}
