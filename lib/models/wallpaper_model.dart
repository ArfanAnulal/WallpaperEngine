import 'package:wallpaper_app/res/enums/enums.dart';


class Basicdata {
    int? total;
    int? totalHits;
    List<Hit>? hits;

    Basicdata({
        this.total,
        this.totalHits,
        this.hits,
    });

    factory Basicdata.fromJson(Map<String, dynamic> json) => Basicdata(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: json["hits"] == null ? [] : List<Hit>.from(json["hits"]!.map((x) => Hit.fromJson(x))),
    );
}


class Hit {
    final int? id;
    final String? pageUrl;
    final Type? type;
    final String? tags;
    final String? previewUrl;
    final int? previewWidth;
    final int? previewHeight;
    final String? webformatUrl;
    final int? webformatWidth;
    final int? webformatHeight;
    final String? largeImageUrl;
    final int? imageWidth;
    final int? imageHeight;
    final int? imageSize;
    final int? views;
    final int? downloads;
    final int? collections;
    final int? likes;
    final int? comments;
    final int? userId;
    final String? user;
    final String? userImageUrl;
    final bool? noAiTraining;

    Hit({
        this.id,
        this.pageUrl,
        this.type,
        this.tags,
        this.previewUrl,
        this.previewWidth,
        this.previewHeight,
        this.webformatUrl,
        this.webformatWidth,
        this.webformatHeight,
        this.largeImageUrl,
        this.imageWidth,
        this.imageHeight,
        this.imageSize,
        this.views,
        this.downloads,
        this.collections,
        this.likes,
        this.comments,
        this.userId,
        this.user,
        this.userImageUrl,
        this.noAiTraining,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: typeValues.map[json["type"]]!,
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
        noAiTraining: json["noAiTraining"],
    );

}

