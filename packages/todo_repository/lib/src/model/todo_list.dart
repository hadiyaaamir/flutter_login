part of 'model.dart';

class TodoList extends Equatable {
  TodoList({
    String title = '',
    required this.userId,
    String? id,
    DateTime? dateCreated,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        dateCreated = dateCreated ?? DateTime.now(),
        title = title.isEmpty ? DateTime.now().toString() : title,
        id = id ?? const Uuid().v4();

  final String id;
  final String userId;
  final String title;
  final DateTime dateCreated;

  TodoList copyWith({
    String? id,
    String? userId,
    String? title,
    DateTime? dateCreated,
  }) {
    return TodoList(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  static TodoList fromJson(Map<String, dynamic> json) => TodoList(
        title: json['title'] as String,
        id: json['id'] as String?,
        userId: json['userId'] as String,
        dateCreated: json['dateCreated'].toDate(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'title': title,
        'dateCreated': dateCreated,
      };

  @override
  List<Object> get props => [id, title, dateCreated];
}
