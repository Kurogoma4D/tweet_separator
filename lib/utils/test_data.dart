import 'package:tweet_separator/models/twitter_status.dart';

final testData = [
  TwitterStatus(
      id: 3254362,
      text: 'test',
      user: User(
        id: 312874123,
        idStr: '312874123',
      )),
  TwitterStatus(
      id: 432582058,
      text: 'hoge',
      user: User(
        id: 129018452,
        idStr: '129018452',
      )),
  TwitterStatus(
      id: 453280,
      text: 'huga',
      user: User(
        id: 12381045,
        idStr: '12381045',
      )),
];

final testUsers = [
  UserDetail(
    id: 32458,
    name: 'name',
    screenName: 'scrname',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
  UserDetail(
    id: 4326,
    name: 'name',
    screenName: 'scrname',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
  UserDetail(
    id: 35243,
    name: 'name',
    screenName: 'scrname',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
];
