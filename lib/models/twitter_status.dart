/// generated from https://javiercbk.github.io/json_to_dart/

class TwitterStatus {
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
    createdAt = json['created_at'];
    id = json['id'];
    idStr = json['id_str'];
    text = json['text'];
    truncated = json['truncated'];
    entities = json['entities'] != null
        ? new Entities.fromJson(json['entities'])
        : null;
    source = json['source'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isQuoteStatus = json['is_quote_status'];
    quotedStatusId = json['quoted_status_id'];
    quotedStatusIdStr = json['quoted_status_id_str'];
    quotedStatus = json['quoted_status'] != null
        ? new QuotedStatus.fromJson(json['quoted_status'])
        : null;
    retweetCount = json['retweet_count'];
    favoriteCount = json['favorite_count'];
    favorited = json['favorited'];
    retweeted = json['retweeted'];
    possiblySensitive = json['possibly_sensitive'];
    possiblySensitiveAppealable = json['possibly_sensitive_appealable'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    data['text'] = this.text;
    data['truncated'] = this.truncated;
    if (this.entities != null) {
      data['entities'] = this.entities.toJson();
    }
    data['source'] = this.source;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['is_quote_status'] = this.isQuoteStatus;
    data['quoted_status_id'] = this.quotedStatusId;
    data['quoted_status_id_str'] = this.quotedStatusIdStr;
    if (this.quotedStatus != null) {
      data['quoted_status'] = this.quotedStatus.toJson();
    }
    data['retweet_count'] = this.retweetCount;
    data['favorite_count'] = this.favoriteCount;
    data['favorited'] = this.favorited;
    data['retweeted'] = this.retweeted;
    data['possibly_sensitive'] = this.possiblySensitive;
    data['possibly_sensitive_appealable'] = this.possiblySensitiveAppealable;
    data['lang'] = this.lang;
    return data;
  }
}

class Entities {
  List<Urls> urls;
  // TODO: mediaに対応する

  Entities({this.urls});

  Entities.fromJson(Map<String, dynamic> json) {
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urls {
  String url;
  String expandedUrl;
  String displayUrl;
  List<int> indices;

  Urls({this.url, this.expandedUrl, this.displayUrl, this.indices});

  Urls.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    expandedUrl = json['expanded_url'];
    displayUrl = json['display_url'];
    indices = json['indices'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['expanded_url'] = this.expandedUrl;
    data['display_url'] = this.displayUrl;
    data['indices'] = this.indices;
    return data;
  }
}

class User {
  int id;
  String idStr;

  User({this.id, this.idStr});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idStr = json['id_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    return data;
  }
}

class QuotedStatus {
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
  int retweetCount;
  int favoriteCount;
  bool favorited;
  bool retweeted;
  bool possiblySensitive;
  bool possiblySensitiveAppealable;
  String lang;

  QuotedStatus(
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
      this.retweetCount,
      this.favoriteCount,
      this.favorited,
      this.retweeted,
      this.possiblySensitive,
      this.possiblySensitiveAppealable,
      this.lang});

  QuotedStatus.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    idStr = json['id_str'];
    text = json['text'];
    truncated = json['truncated'];
    entities = json['entities'] != null
        ? new Entities.fromJson(json['entities'])
        : null;
    source = json['source'];

    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isQuoteStatus = json['is_quote_status'];
    quotedStatusId = json['quoted_status_id'];
    quotedStatusIdStr = json['quoted_status_id_str'];
    retweetCount = json['retweet_count'];
    favoriteCount = json['favorite_count'];
    favorited = json['favorited'];
    retweeted = json['retweeted'];
    possiblySensitive = json['possibly_sensitive'];
    possiblySensitiveAppealable = json['possibly_sensitive_appealable'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    data['text'] = this.text;
    data['truncated'] = this.truncated;
    if (this.entities != null) {
      data['entities'] = this.entities.toJson();
    }
    data['source'] = this.source;

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['is_quote_status'] = this.isQuoteStatus;
    data['quoted_status_id'] = this.quotedStatusId;
    data['quoted_status_id_str'] = this.quotedStatusIdStr;
    data['retweet_count'] = this.retweetCount;
    data['favorite_count'] = this.favoriteCount;
    data['favorited'] = this.favorited;
    data['retweeted'] = this.retweeted;
    data['possibly_sensitive'] = this.possiblySensitive;
    data['possibly_sensitive_appealable'] = this.possiblySensitiveAppealable;
    data['lang'] = this.lang;
    return data;
  }
}
