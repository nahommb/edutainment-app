class StoryModel {
  final int id;
  final String title;
  final String image;
  final String slug;
  final int status;
  final String description;
  final DateTime createdAt;
  final List<StoryContent> contents;

  StoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.slug,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.contents,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    id: int.parse(json['id'].toString()),
    title: json['title'],
    image: json['image'],
    slug: json['slug'],
    status: int.parse(json['status'].toString()),
    description: json['description'],
    createdAt: DateTime.parse(json['created_at']),
    contents: List<StoryContent>.from(
      json['contents'].map((x) => StoryContent.fromJson(x)),
    ),
  );


  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'slug': slug,
        'status': status,
        'description': description,
        'created_at': createdAt.toIso8601String(),
        'contents': contents.map((x) => x.toJson()).toList(),
      };
}

class StoryContent {
  final int id;
  final int storyId;
  final String story;
  final String? image;
  final int order;

  StoryContent({
    required this.id,
    required this.storyId,
    required this.story,
    this.image,
    required this.order,
  });

  factory StoryContent.fromJson(Map<String, dynamic> json) => StoryContent(
    id: int.parse(json['id'].toString()),
    storyId: int.parse(json['story_id'].toString()),
    story: json['story'],
    image: json['image'],
    order: int.parse(json['order'].toString()),
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'story_id': storyId,
        'story': story,
        'image': image,
        'order': order,
      };
}
