// ignore: lines_longer_than_80_chars
// ignore_for_file: non_constant_identifier_names, prefer_equal_for_default_values, prefer_single_quotes, unnecessary_string_escapes

class User {
  final int blog_id;
  final String blog_name;
  final String avatar;
  final String blog_url;

  User({
    required this.blog_id,
    required this.blog_name,
    required this.avatar,
    required this.blog_url,
  });
}

//----------------------------------------------------------------
class Message {
  final User sender;
  final String text;
  final bool isRead;

  Message({
    required this.sender,
    required this.text,
    required this.isRead,
  });

  factory Message.fromJson(
      {required Map<String, dynamic> json,
      required bool outOrIn,
      int index: 0}) {
    return outOrIn // out -> outside the chat, in -> inside the chat
        ? Message(
            sender: User(
              blog_id: int.parse(json['blog_data']['blog_id']),
              blog_url: json['blog_data']['blog_url'],
              blog_name: json['blog_data']['blog_name'],
              avatar: json['blog_data']['avatar'],
            ),
            text: json['content'],
            isRead: json['is_read'],
          )
        : Message(
            sender: User(
              blog_id: int.parse(json['messages'][0]['from_blog_id']),
              blog_url: json['blog_data']['url'],
              blog_name: json['blog_data']['blog_name'],
              avatar: json['blog_data']['avatar'],
            ),
            text: json['messages'][index]['content'],
            isRead: json['messages'][index]['is_read'],
          );
  }
}

// YOU - current user
final User currentUser = User(
  blog_id: 0,
  blog_url: '',
  blog_name: 'Current User',
  avatar:
      'https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png',
);

final Map<String, dynamic> messaging = {
  'responseBody': [
    {
      "from_blog_id": "10",
      "to_blog_id": "4",
      "content": "hi",
      "is_read": false,
      "blog_data": {
        "blog_id": "4",
        "blog_name": "eius",
        "blog_url": "http:\/\/localhost:8000\/api\/blog\/eius",
        "avatar":
            "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
        "avatar_shape": "circle"
      }
    },
    {
      "from_blog_id": "10",
      "to_blog_id": "5",
      "content": "Similique provident est.",
      "is_read": false,
      "blog_data": {
        "blog_id": "5",
        "blog_name": "incidunt",
        "blog_url": "http:\/\/localhost:8000\/api\/blog\/incidunt",
        "avatar":
            "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
        "avatar_shape": "circle"
      }
    },
    {
      "from_blog_id": "2",
      "to_blog_id": "10",
      "content": "Doloremque dolorem et alias.",
      "is_read": false,
      "blog_data": {
        "blog_id": "2",
        "blog_name": "impedit",
        "blog_url": "http:\/\/localhost:8000\/api\/blog\/impedit",
        "avatar":
            "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
        "avatar_shape": "circle"
      }
    },
  ]
};
// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message.fromJson(json: messaging['responseBody'][0], outOrIn: true),
  Message.fromJson(json: messaging['responseBody'][1], outOrIn: true),
  Message.fromJson(json: messaging['responseBody'][2], outOrIn: true),
];

final Map<String, dynamic> conversation = {
  'responseBody': {
    "messages": [
      {
        "id": 5007,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:38:18.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5006,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hola",
        "is_read": true,
        "created_at": "2021-12-27T17:33:50.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5005,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:33:49.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5004,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:28:06.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5003,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:27:02.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5002,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:26:26.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 5001,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "hi",
        "is_read": true,
        "created_at": "2021-12-27T17:24:29.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 4717,
        "from_blog_id": "4",
        "to_blog_id": "10",
        "content": "Repellendus enim fugiat.",
        "is_read": true,
        "created_at": "2021-12-25T22:44:50.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 4701,
        "from_blog_id": "10",
        "to_blog_id": "4",
        "content": "Quis esse incidunt reiciendis voluptates.",
        "is_read": true,
        "created_at": "2021-12-25T22:44:50.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      },
      {
        "id": 4779,
        "from_blog_id": "4",
        "to_blog_id": "10",
        "content": "Voluptatem quo ex aut sed tenetur.",
        "is_read": true,
        "created_at": "2021-12-25T22:44:50.000000Z",
        "updated_at": "2021-12-27T17:44:42.000000Z"
      }
    ],
    "blog_data": {
      "blog_name": "eius",
      "url": "http:\/\/localhost:8000\/api\/blog\/eius",
      "title": "Susanna Cummings",
      "avatar":
          "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
      "avatar_shape": "circle"
    },
    "next_url":
        "http:\/\/127.0.0.1:8000\/api\/messaging\/conversation\/10\/4?page=2",
    "total": 111,
    "current_page": 1,
    "messages_per_page": 10
  }
};
// EXAMPLE MESSAGES IN CHAT SCREEN
final messages = <Message>[
  Message.fromJson(
      json: conversation['responseBody'], outOrIn: false, index: 0),
  Message.fromJson(
      json: conversation['responseBody'], outOrIn: false, index: 1),
];
