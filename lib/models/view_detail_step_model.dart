class ViewDetailStepModel {
  final int id;
  final String title;
  final String script;

  const ViewDetailStepModel(
      {required this.id, required this.title, required this.script});

  factory ViewDetailStepModel.fromJson(Map<String, dynamic> json) {
    return ViewDetailStepModel(
      id: json['id'],
      title: 'title',
      script: json['description'],
    );
  }
}
