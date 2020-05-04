/// generated from https://javiercbk.github.io/json_to_dart/

class TwitterStatus {
  TwitterStatus(
      {this.createdAt,
      this.id,
      this.idStr,
      this.text,
      this.truncated,
      this.entities,
      this.source,
      this.user,
      this.isQuoteStatus,
      this.quotedStatusId,
      this.quotedStatusIdStr,
      this.quotedStatus,
      this.retweetCount,
      this.favoriteCount,
      this.favorited,
      this.retweeted,
      this.possiblySensitive,
      this.possiblySensitiveAppealable,
      this.lang});

  TwitterStatus.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'] as String;
    id = json['id'] as int;
    idStr = json['id_str'] as String;
    text = json['text'] as String;
    truncated = json['truncated'] as bool;
    if (json['entities'] != null) {
      entities =
          new Entities.fromJson(json['entities'] as Map<String, dynamic>);
    } else {
      entities = null;
    }
    source = json['source'] as String;
    if (json['user'] != null) {
      user = new User.fromJson(json['user'] as Map<String, dynamic>);
    } else {
      user = null;
    }
    isQuoteStatus = json['is_quote_status'] as bool;
    quotedStatusId = json['quoted_status_id'] as int;
    quotedStatusIdStr = json['quoted_status_id_str'] as String;
    quotedStatus = json['quoted_status'] != null
        ? new QuotedStatus.fromJson(
            json['quoted_status'] as Map<String, dynamic>)
        : null;
    retweetCount = json['retweet_count'] as int;
    favoriteCount = json['favorite_count'] as int;
    favorited = json['favorited'] as bool;
    retweeted = json['retweeted'] as bool;
    possiblySensitive = json['possibly_sensitive'] as bool;
    possiblySensitiveAppealable = json['possibly_sensitive_appealable'] as bool;
    lang = json['lang'] as String;
  }

  String createdAt;
  int id;
  String idStr;
  String text;
  bool truncated;
  Entities entities;
  String source;
  User user;
  bool isQuoteStatus;
  int quotedStatusId;
  String quotedStatusIdStr;
  QuotedStatus quotedStatus;
  int retweetCount;
  int favoriteCount;
  bool favorited;
  bool retweeted;
  bool possiblySensitive;
  bool possiblySensitiveAppealable;
  String lang;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['id_str'] = idStr;
    data['text'] = text;
    data['truncated'] = truncated;
    if (entities != null) {
      data['entities'] = entities.toJson();
    }
    data['source'] = source;
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['is_quote_status'] = isQuoteStatus;
    data['quoted_status_id'] = quotedStatusId;
    data['quoted_status_id_str'] = quotedStatusIdStr;
    if (quotedStatus != null) {
      data['quoted_status'] = quotedStatus.toJson();
    }
    data['retweet_count'] = retweetCount;
    data['favorite_count'] = favoriteCount;
    data['favorited'] = favorited;
    data['retweeted'] = retweeted;
    data['possibly_sensitive'] = possiblySensitive;
    data['possibly_sensitive_appealable'] = possiblySensitiveAppealable;
    data['lang'] = lang;
    return data;
  }
}

class Entities {
  Entities({this.urls});

  Entities.fromJson(Map<String, dynamic> json) {
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((Map<String, dynamic> v) {
        urls.add(new Urls.fromJson(v));
      });
    }
  }

  // TODO(Kurogoma4D): mediaに対応する
  List<Urls> urls;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (urls != null) {
      data['urls'] = urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urls {
  Urls({this.url, this.expandedUrl, this.displayUrl, this.indices});

  Urls.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String;
    expandedUrl = json['expanded_url'] as String;
    displayUrl = json['display_url'] as String;
    indices = json['indices'].cast<int>() as List<int>;
  }

  String url;
  String expandedUrl;
  String displayUrl;
  List<int> indices;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['expanded_url'] = expandedUrl;
    data['display_url'] = displayUrl;
    data['indices'] = indices;
    return data;
  }
}

class User {
  User({this.id, this.idStr});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    idStr = json['id_str'] as String;
  }

  int id;
  String idStr;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_str'] = idStr;
    return data;
  }
}

class QuotedStatus {
  QuotedStatus({
    this.createdAt,
    this.id,
    this.idStr,
    this.text,
    this.entities,
    this.user,
  });

  QuotedStatus.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'] as String;
    id = json['id'] as int;
    idStr = json['id_str'] as String;
    text = json['text'] as String;
    entities = json['entities'] != null
        ? new Entities.fromJson(json['entities'] as Map<String, dynamic>)
        : null;
    user = json['user'] != null
        ? new User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
  }

  String createdAt;
  int id;
  String idStr;
  String text;
  Entities entities;
  User user;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['id_str'] = idStr;
    data['text'] = text;
    if (entities != null) {
      data['entities'] = entities.toJson();
    }
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}
