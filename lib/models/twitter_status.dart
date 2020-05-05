/// generated from https://javiercbk.github.io/json_to_dart/

class TwitterStatus {
  TwitterStatus({
    this.id,
    this.idStr,
    this.text,
    this.truncated,
    this.entities,
    this.user,
    this.isQuoteStatus,
    this.quotedStatusId,
    this.quotedStatusIdStr,
    this.quotedStatus,
  });

  TwitterStatus.fromJson(Map<String, dynamic> json) {
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
  }

  int id;
  String idStr;
  String text;
  bool truncated;
  Entities entities;
  User user;
  bool isQuoteStatus;
  int quotedStatusId;
  String quotedStatusIdStr;
  QuotedStatus quotedStatus;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_str'] = idStr;
    data['text'] = text;
    data['truncated'] = truncated;
    if (entities != null) {
      data['entities'] = entities.toJson();
    }
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['is_quote_status'] = isQuoteStatus;
    data['quoted_status_id'] = quotedStatusId;
    data['quoted_status_id_str'] = quotedStatusIdStr;
    if (quotedStatus != null) {
      data['quoted_status'] = quotedStatus.toJson();
    }
    return data;
  }
}

class Entities {
  Entities({this.urls});

  Entities.fromJson(Map<String, dynamic> json) {
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((dynamic v) {
        urls.add(new Urls.fromJson(v as Map<String, dynamic>));
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

class UserDetail {
  UserDetail({
    this.id,
    this.idStr,
    this.name,
    this.screenName,
    this.location,
    this.description,
    this.profileImageUrlHttps,
  });

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    idStr = json['id_str'] as String;
    name = json['name'] as String;
    screenName = json['screen_name'] as String;
    location = json['location'] as String;
    description = json['description'] as String;
    profileImageUrlHttps = json['profile_image_url_https'] as String;
  }

  int id;
  String idStr;
  String name;
  String screenName;
  String location;
  String description;
  String profileImageUrlHttps;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_str'] = idStr;
    data['name'] = name;
    data['screen_name'] = screenName;
    data['location'] = location;
    data['description'] = description;
    data['profile_image_url_https'] = profileImageUrlHttps;
    return data;
  }
}
