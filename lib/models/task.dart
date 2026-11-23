
class Task {
  final int? id;
  final String title;
  final String description;
  final String deadline;
  final int isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    this.isCompleted = 0,
  });

  // Mengubah objek Task menjadi Map untuk disimpan ke SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'isCompleted': isCompleted,
    };
  }

  // Mengubah data Map dari SQLite menjadi objek Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: map['deadline'],
      isCompleted: map['isCompleted'],
    );
  }
}
