import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

class HiveSource {
  final String? id;
  final String name;

  HiveSource({this.id, required this.name});
}

class HiveSourceAdapter extends TypeAdapter<HiveSource> {
  @override
  final int typeId = 1;

  @override
  HiveSource read(BinaryReader reader) {
    return HiveSource(
      id: reader.readBool() ? reader.readString() : null,
      name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveSource obj) {
    if (obj.id != null) {
      writer.writeBool(true);
      writer.writeString(obj.id!);
    } else {
      writer.writeBool(false);
    }
    writer.writeString(obj.name);
  }
}

class HiveArticle {
  final HiveSource source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  HiveArticle({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });
}

class HiveArticleAdapter extends TypeAdapter<HiveArticle> {
  @override
  final int typeId = 0;

  @override
  HiveArticle read(BinaryReader reader) {
    return HiveArticle(
      source: HiveSourceAdapter().read(reader),
      author: reader.readBool() ? reader.readString() : null,
      title: reader.readString(),
      description: reader.readBool() ? reader.readString() : null,
      url: reader.readString(),
      urlToImage: reader.readBool() ? reader.readString() : null,
      publishedAt: DateTime.parse(reader.readString()),
      content: reader.readBool() ? reader.readString() : null,
    );
  }

  @override
  void write(BinaryWriter writer, HiveArticle obj) {
    HiveSourceAdapter().write(writer, obj.source);

    if (obj.author != null) {
      writer.writeBool(true);
      writer.writeString(obj.author!);
    } else {
      writer.writeBool(false);
    }

    writer.writeString(obj.title);

    if (obj.description != null) {
      writer.writeBool(true);
      writer.writeString(obj.description!);
    } else {
      writer.writeBool(false);
    }

    writer.writeString(obj.url);

    if (obj.urlToImage != null) {
      writer.writeBool(true);
      writer.writeString(obj.urlToImage!);
    } else {
      writer.writeBool(false);
    }

    writer.writeString(obj.publishedAt.toIso8601String());

    if (obj.content != null) {
      writer.writeBool(true);
      writer.writeString(obj.content!);
    } else {
      writer.writeBool(false);
    }
  }
}

extension HiveArticleFromArticle on HiveArticle {
  static HiveArticle fromArticle(Article article) {
    return HiveArticle(
      source: HiveSource(id: article.source.id, name: article.source.name),
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }

  Article toArticle() {
    return Article(
      source: Source(id: source.id, name: source.name),
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
