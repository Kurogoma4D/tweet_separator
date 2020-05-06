import 'package:tweet_separator/models/twitter_status.dart';

final testData = [
  TwitterStatus(
    id: 6432,
    text:
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
    user: User(
      id: 312874123,
      idStr: '312874123',
    ),
    entities: Entities(media: [
      Media(
          id: 3453545,
          mediaUrlHttps: 'https://source.unsplash.com/random/1280x720'),
      Media(
          id: 3289080,
          mediaUrlHttps: 'https://source.unsplash.com/random/1980x1080'),
      Media(
          id: 8979342,
          mediaUrlHttps: 'https://source.unsplash.com/random/720x1280'),
      Media(
          id: 4530787,
          mediaUrlHttps: 'https://source.unsplash.com/random/640x480'),
    ]),
  ),
  TwitterStatus(
    id: 3254362,
    text: '''Lorem Ipsum is simply dummy text of the printing and typesetting 
        industry. Lorem Ipsum has been the industry's standard dummy text ever 
        since the 1500s, when an unknown printer took a galley of type and 
        scrambled it to make a type specimen book. ''',
    user: User(
      id: 312874123,
      idStr: '312874123',
    ),
    entities: Entities(media: [
      Media(
          id: 32108,
          mediaUrlHttps: 'https://pbs.twimg.com/media/EXTrewTUYAI1xBl.jpg'),
    ]),
  ),
  TwitterStatus(
    id: 5432654,
    text: 'hoge',
    user: User(
      id: 129018452,
      idStr: '129018452',
    ),
    entities: Entities(media: [
      Media(
          id: 3525,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
      Media(
          id: 32987,
          mediaUrlHttps: 'https://pbs.twimg.com/media/EXTrewTUYAI1xBl.jpg'),
    ]),
  ),
  TwitterStatus(
    id: 432582058,
    text: 'hoge',
    user: User(
      id: 129018452,
      idStr: '129018452',
    ),
    entities: Entities(media: [
      Media(
          id: 345642,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
      Media(
          id: 76863,
          mediaUrlHttps: 'https://pbs.twimg.com/media/EXTrewTUYAI1xBl.jpg'),
      Media(
          id: 3676545,
          mediaUrlHttps: 'https://pbs.twimg.com/media/EXTrewTUYAI1xBl.jpg'),
    ]),
  ),
  TwitterStatus(
    id: 453280,
    text: 'huga',
    user: User(
      id: 12381045,
      idStr: '12381045',
    ),
    entities: Entities(media: [
      Media(
          id: 325563,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
      Media(
          id: 32453256987,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
      Media(
          id: 353462,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
      Media(
          id: 432634,
          mediaUrlHttps:
              'https://pbs.twimg.com/ext_tw_video_thumb/1257619108297752579/pu/img/GnZwtpj1WIlXOfhW.jpg'),
    ]),
  ),
];

final testUsers = [
  UserDetail(
    id: 32458,
    name: 'John Doe',
    screenName: 'screen_name',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
  UserDetail(
    id: 4326,
    name: 'John Doe',
    screenName: 'screenname',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
  UserDetail(
    id: 35243,
    name: 'John Doe',
    screenName: 'awesome_screen_name',
    profileImageUrlHttps:
        'https://pbs.twimg.com/profile_images/1045579977067024384/S0luKMwQ_normal.jpg',
  ),
];
