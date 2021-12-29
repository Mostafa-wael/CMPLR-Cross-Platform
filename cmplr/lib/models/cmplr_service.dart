// ignore_for_file: prefer_single_quotes, unnecessary_string_escapes,
// no_duplicate_case_values

import 'dart:async';
import 'dart:convert';

import '../utilities/user.dart';
import 'package:get/get_connect.dart';
import 'package:flutter/foundation.dart';

import 'package:get_storage/get_storage.dart';

import '../backend_uris.dart';

import '../flags.dart';
import 'package:http/http.dart' as http;
import '../routes.dart';
import 'notes_mock_data.dart';

/// Our interface to the backend OR our mock data
class CMPLRService {
  static final Map<String, Set> users = {
    'emails': {
      'tarek@cmplr.org',
      'jimbo@cmprl.cum',
      'wael@bekes.net',
      'gendy@cmplr.eg',
      'mock@cmplr.com',
    },
    'passwords': {
      '12345678',
      'hey12345',
      'sad43210',
      'Anime6420',
      'mock',
    },
    'names': {'burh', 'nerd', 'kak', 'AAA'}
  };

  /// Puts both emails and passwords into a map where the key is the email
  /// and the value is the password.
  // I just didn't want to repeat the same data in a different structure just
  // for 1 case
  static Map getEmailPassMap() {
    final emailPass = {};
    assert(users['emails']!.length == users['passwords']!.length);
    final mailIter = users['emails']!.iterator;
    final passIter = users['passwords']!.iterator;

    do {
      emailPass[mailIter.current] = passIter.current;
    } while (mailIter.moveNext() && passIter.moveNext());

    return emailPass;
  }

  /// Maps a route to the mock data it's supposed to receive
  static final Map<String, dynamic> _mockData = {
    // Extra signup whenever the user signups with their email
    // and they want to open their activity or profile screen.
    // each set is used to check whether a given email or username
    // is inside it or not.
    PostURIs.signup: {
      // set of registered emails
      'emails': users['emails'],
      // set of used usernames
      'names': users['names']
    },
    PostURIs.login: {
      'google_acount': {
        'email': 'cmplr.mock@gmail.com',
        'password': 'cmplr_mock_flutter'
      },
      'users': getEmailPassMap(),
    },
    // Doesn't use post()
    Routes.signupPreferencesScreen: {
      'preference_names': [
        'Trending',
        'Art',
        'Writing',
        'Books & Libraries',
        'Streaming',
        'Positivity',
        'Aesthetic',
        'Television',
        'Funny',
        'Gaming',
        'Movies',
        'Music',
        'Comics',
        'Fashion'
      ]
    },
    GetURIs.postFollowing: {
      "meta": {"status_code": 200, "msg": "Success"},
      "response": {
        "post": [
          {
            "post": {
              "post_id": 1,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<img src='https://avatars.githubusercontent.com/u/56788883?v=4'><h1>Alice called after it; and while she was peering.<\/h1><p>In ut sed voluptatum aut vitae eum. Iste ut quo consequatur dolorem ratione quae. Ipsum ut velit esse voluptatem voluptas ipsum non deleniti.<\/p><p>Error sunt veritatis optio ut tenetur. Sunt accusamus tenetur voluptatem totam omnis aut eum.<\/p><p>Praesentium itaque autem dolorem reiciendis. Quasi qui illum cum asperiores dolorum ex similique dolor. Hic aut odio alias quibusdam optio. Expedita eligendi dolorem dolore dolorem.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "BCAkeGl4zX",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 5,
              "type": "videos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Alice, very loudly and decidedly, and he checked.<\/h1><p>Nihil quia aspernatur qui voluptatem architecto dicta debitis. Quas qui modi error molestiae autem debitis. Quia doloribus error et tempore libero voluptatibus.<\/p><p>Sunt autem amet voluptatum doloribus. Facilis quis non voluptas voluptatum. Tempora dolores praesentium officia eum aut nam et.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "HqQeXGEuJp",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 8,
              "type": "chats",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>While the Panther were sharing a pie--' [later.<\/h1><p>Dolore facilis ut voluptate omnis consequatur. Eius iusto quam dolores sint. Est laboriosam nam numquam voluptas sunt blanditiis quia. Non mollitia et ipsa veritatis.<\/p><p>Minima aut laboriosam ut omnis accusantium dolores alias. Rerum in cupiditate doloribus libero eum. Atque velit dolorem ea deleniti voluptas ut corrupti.<\/p><p>Officia provident impedit hic saepe. Sapiente occaecati maiores iste. Fugiat quia tenetur fugit. Rem dolores officiis libero facilis magni ut veniam.<\/p><p>Quaerat nihil a sunt inventore dolores. Aperiam laborum facilis ipsum consectetur sunt. Excepturi autem consequatur ut sed. Iste fugit iure molestias. Sequi exercitationem ea voluptatibus corrupti unde recusandae pariatur.<\/p><p>Nihil laboriosam non eaque sequi. Iusto veniam minus eum commodi consequatur. Quam eos doloremque optio nisi eum similique. At in qui ea officia a vel provident.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "xlfsmD2x3H",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 12,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Alice, 'a great girl like you,' (she might well.<\/h1><p>Quis velit veniam explicabo ducimus repellendus quia vel. Eveniet dicta velit nesciunt sit officiis. Aliquid soluta necessitatibus reiciendis aut. Commodi et sunt nesciunt rerum.<\/p><p>Sed voluptas assumenda est. Est quos est quas fugit. Consectetur qui sapiente dicta neque mollitia vero.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "LFyeAIKqW8",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 13,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Dormouse went on, half to itself, half to.<\/h1><p>Aut eveniet dolorem error qui possimus. Accusantium quasi aperiam at sunt aspernatur provident. Culpa sunt harum et eum quia quae rerum quod. Et facilis nisi voluptas architecto.<\/p><p>Ut at aut eaque voluptas. Ut rerum iure eaque aut itaque ut non. Vel qui fugiat quisquam. Tempora asperiores magnam similique dolorum illo vero. Explicabo excepturi repellendus occaecati sit repudiandae provident.<\/p><p>Aut libero ex sit odit accusantium magnam. Possimus exercitationem recusandae animi doloribus. Et dignissimos labore id dolores nihil recusandae ea. Labore odio reiciendis consectetur nihil consequuntur cupiditate doloremque.<\/p><p>Facilis nulla quos nihil ullam eius animi quisquam. Et quaerat enim quia culpa aut. Ipsa qui facere blanditiis dolores perspiciatis nemo debitis harum. Voluptas saepe eum et qui. Soluta non autem dignissimos atque non perferendis vitae.<\/p><p>Omnis est et qui eum vel dolores. Similique nihil laborum incidunt corporis ea sit. Voluptatem deserunt quo consequuntur ipsum. Voluptatem omnis et provident nam commodi voluptate culpa.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "RmM28BSiHQ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 14,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Alice replied, rather shyly, 'I--I hardly know.<\/h1><p>Quaerat reprehenderit mollitia sed dolores in aut rerum. Quas minus necessitatibus vel non aut vero quo.<\/p><p>Et provident ut in officiis provident officiis provident. Aut ut est dolorem recusandae est unde.<\/p><p>Omnis nisi et libero reiciendis veritatis adipisci laudantium. Nostrum repellat distinctio ea quibusdam et ut deserunt. Molestiae beatae tempore sed.<\/p><p>Et sunt vel ex. Nemo dicta quisquam et impedit non. Commodi omnis odio ut quia. Provident aut inventore aut possimus corrupti.<\/p><p>Eum ex dolores sit voluptas. Ducimus voluptate ad aut cumque. Qui aut ea atque quia et enim dolor. Libero aut suscipit optio assumenda placeat optio. Soluta autem quae ducimus corporis deleniti accusamus.<\/p><p>Dolore ut asperiores repellendus suscipit velit sit voluptas. Et eligendi suscipit nobis aut. Soluta consequuntur aut fuga excepturi et assumenda sint.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "p4Djf0ywSZ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 16,
              "type": "audio",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>I shall remember it in with a trumpet in one.<\/h1><p>Placeat sunt provident harum cupiditate. Sed quia asperiores non. Non ducimus pariatur eos atque ipsa numquam voluptatem labore. Hic est qui rem illum expedita molestias est.<\/p><p>Voluptatem cupiditate reiciendis sit cumque maxime molestiae. Cumque qui aut voluptas veritatis totam ut. Iste autem dolor aut quo voluptatum consequatur temporibus. Quis assumenda perferendis quisquam et non.<\/p><p>Molestiae aut aspernatur beatae dolorem est quas. Tempore id asperiores incidunt possimus. Voluptas quo veniam porro odit est modi. Sit ex sint exercitationem ea. Porro eius hic sunt voluptatem perspiciatis molestiae.<\/p><p>Deleniti voluptatem quaerat voluptas voluptates fuga. Eos dolorum deserunt saepe natus autem vero vero. Nulla eos molestias ab odio est.<\/p><p>Sed vel repellat delectus. Deleniti excepturi et nulla enim voluptas explicabo nostrum. Et fugiat voluptas expedita quod quos sit. Dolor iure quam unde.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "P7qx8ZqDQI",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 17,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>Mock Turtle's Story 'You can't think how glad I.<\/h1><p>Dolorem omnis ut autem rem totam possimus qui. Est qui expedita molestiae ex eaque. Amet voluptatem repudiandae in in. Impedit in placeat consequuntur quam iusto.<\/p><p>Modi nam ea et qui fuga. Expedita temporibus quidem cum. Consequatur eos quia nulla est.<\/p><p>Nesciunt aut at aperiam unde. Et consectetur incidunt eius enim id quia molestias magnam. Similique beatae suscipit culpa ut fuga sequi. Itaque dicta soluta reprehenderit voluptatem quod quidem.<\/p><p>Sint sed eos numquam id veniam sed. Numquam modi minima ut earum velit autem. Aut qui qui voluptas quisquam possimus omnis.<\/p><p>Nihil odio harum natus iure nemo aut assumenda. At et ut quod tempora. Quasi quia nihil omnis ad dicta et. Blanditiis sed fugit ad officia molestias qui.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "FQIgIPyCiV",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 19,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>I don't keep the same size: to be seen: she.<\/h1><p>Voluptas itaque ratione voluptatem beatae. Iure aut qui animi libero et et. Tempora alias impedit sapiente nobis veniam quia occaecati.<\/p><p>Officiis et accusamus nobis ut distinctio fuga. Cum aut officiis commodi sed facere nihil sed. Fuga accusantium aut veniam quia consequatur.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "NOGX1jppnV",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 21,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Queen say only yesterday you deserved to be.<\/h1><p>Molestiae pariatur ut rerum. Est expedita molestias qui. Quas voluptatibus dignissimos nobis est assumenda minima tempora.<\/p><p>Praesentium quia laudantium qui ut voluptates. Quidem consectetur molestiae occaecati saepe ipsam dolor ducimus. Eum natus consequatur labore a officiis odio reprehenderit. Labore nostrum est cumque labore.<\/p><p>Autem ut sunt esse aut nihil. Id facilis assumenda explicabo eius ut et. Molestiae delectus et quo et. Nulla fugiat in iste consequatur.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "nK304kfDiW",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 23,
              "type": "videos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>He trusts to you to sit down without being.<\/h1><p>Veniam consectetur et eos est ex repellendus aliquam et. Animi assumenda animi sed. Dicta voluptatem unde autem qui. Quisquam quos tempora incidunt dolores.<\/p><p>Aut eos placeat necessitatibus porro. Eos consequatur eum illum quam reprehenderit quas. Et et neque blanditiis odit.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "O6HYTGpTIJ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 29,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Duchess's knee, while plates and dishes crashed.<\/h1><p>Quia beatae nam laboriosam et dolorem modi. Placeat necessitatibus quasi magni et est est laborum. Amet eum architecto mollitia laborum.<\/p><p>Voluptatem quae voluptatem repudiandae doloremque ut omnis. Rerum quis animi qui neque sint deserunt nisi. Fugiat ullam aut aliquid aliquam voluptatem.<\/p><p>Voluptas quos omnis velit id iure aut molestias. Autem atque quae alias unde rerum quos deleniti. Nam perspiciatis et eos reiciendis sunt.<\/p><p>Fugit voluptatem saepe dolorem ad. Unde cumque quos totam amet. Accusamus veniam sunt ab inventore.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "nFfU3WfQT1",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 47,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Why, it fills the whole she thought it would,'.<\/h1><p>Voluptas voluptatum molestias voluptas aut. Sed ut non necessitatibus dicta impedit dignissimos. Dolores aut dignissimos qui et nihil voluptatem magni sunt.<\/p><p>Fugiat incidunt tempore at unde officia esse consectetur placeat. Ut dolor cumque minima velit dolores amet magnam. Aut occaecati laborum corrupti.<\/p><p>Eos incidunt sint suscipit beatae quisquam est provident et. Ipsa voluptate repellendus a facere. Ut fuga omnis ipsa error ipsam in.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "cZtZZkfI1I",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 57,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<img src=\"https:\/\/cmplrserver.s3.eu-west-2.amazonaws.com\/images\/1640121921_17_Screenshot(10).png\"><div>hello from other server uploaded image successfulyy<\/div>",
              "date": "Tuesday, 21-Dec-21 21:26:29 UTC",
              "source_content": null,
              "tags": [],
              "is_liked": true,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 17,
              "blog_name": "sba7el5eer",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 58,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "skjnkjns kjsn <b>sjsns<\/b>&nbsp;<u style=\"\"><i>jnksjn<\/i><\/u>",
              "date": "Tuesday, 21-Dec-21 21:33:07 UTC",
              "source_content": null,
              "tags": ["hi", "bye"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 17,
              "blog_name": "sba7el5eer",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          }
        ],
        "next_url": "http:\/\/127.0.0.1:8000\/api\/user\/dashboard?page=2",
        "total": 22,
        "current_page": 1,
        "posts_per_page": 15
      }
    },
    GetURIs.postStuff: {
      "meta": {"status_code": 200, "msg": "Success"},
      "response": {
        "post": [
          {
            "post": {
              "post_id": 1,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Alice called after it; and while she was peering.<\/h1><p>In ut sed voluptatum aut vitae eum. Iste ut quo consequatur dolorem ratione quae. Ipsum ut velit esse voluptatem voluptas ipsum non deleniti.<\/p><p>Error sunt veritatis optio ut tenetur. Sunt accusamus tenetur voluptatem totam omnis aut eum.<\/p><p>Praesentium itaque autem dolorem reiciendis. Quasi qui illum cum asperiores dolorum ex similique dolor. Hic aut odio alias quibusdam optio. Expedita eligendi dolorem dolore dolorem.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "BCAkeGl4zX",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 5,
              "type": "videos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Alice, very loudly and decidedly, and he checked.<\/h1><p>Nihil quia aspernatur qui voluptatem architecto dicta debitis. Quas qui modi error molestiae autem debitis. Quia doloribus error et tempore libero voluptatibus.<\/p><p>Sunt autem amet voluptatum doloribus. Facilis quis non voluptas voluptatum. Tempora dolores praesentium officia eum aut nam et.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "HqQeXGEuJp",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 8,
              "type": "chats",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>While the Panther were sharing a pie--' [later.<\/h1><p>Dolore facilis ut voluptate omnis consequatur. Eius iusto quam dolores sint. Est laboriosam nam numquam voluptas sunt blanditiis quia. Non mollitia et ipsa veritatis.<\/p><p>Minima aut laboriosam ut omnis accusantium dolores alias. Rerum in cupiditate doloribus libero eum. Atque velit dolorem ea deleniti voluptas ut corrupti.<\/p><p>Officia provident impedit hic saepe. Sapiente occaecati maiores iste. Fugiat quia tenetur fugit. Rem dolores officiis libero facilis magni ut veniam.<\/p><p>Quaerat nihil a sunt inventore dolores. Aperiam laborum facilis ipsum consectetur sunt. Excepturi autem consequatur ut sed. Iste fugit iure molestias. Sequi exercitationem ea voluptatibus corrupti unde recusandae pariatur.<\/p><p>Nihil laboriosam non eaque sequi. Iusto veniam minus eum commodi consequatur. Quam eos doloremque optio nisi eum similique. At in qui ea officia a vel provident.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "xlfsmD2x3H",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 12,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Alice, 'a great girl like you,' (she might well.<\/h1><p>Quis velit veniam explicabo ducimus repellendus quia vel. Eveniet dicta velit nesciunt sit officiis. Aliquid soluta necessitatibus reiciendis aut. Commodi et sunt nesciunt rerum.<\/p><p>Sed voluptas assumenda est. Est quos est quas fugit. Consectetur qui sapiente dicta neque mollitia vero.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "LFyeAIKqW8",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 13,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Dormouse went on, half to itself, half to.<\/h1><p>Aut eveniet dolorem error qui possimus. Accusantium quasi aperiam at sunt aspernatur provident. Culpa sunt harum et eum quia quae rerum quod. Et facilis nisi voluptas architecto.<\/p><p>Ut at aut eaque voluptas. Ut rerum iure eaque aut itaque ut non. Vel qui fugiat quisquam. Tempora asperiores magnam similique dolorum illo vero. Explicabo excepturi repellendus occaecati sit repudiandae provident.<\/p><p>Aut libero ex sit odit accusantium magnam. Possimus exercitationem recusandae animi doloribus. Et dignissimos labore id dolores nihil recusandae ea. Labore odio reiciendis consectetur nihil consequuntur cupiditate doloremque.<\/p><p>Facilis nulla quos nihil ullam eius animi quisquam. Et quaerat enim quia culpa aut. Ipsa qui facere blanditiis dolores perspiciatis nemo debitis harum. Voluptas saepe eum et qui. Soluta non autem dignissimos atque non perferendis vitae.<\/p><p>Omnis est et qui eum vel dolores. Similique nihil laborum incidunt corporis ea sit. Voluptatem deserunt quo consequuntur ipsum. Voluptatem omnis et provident nam commodi voluptate culpa.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "RmM28BSiHQ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 14,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Alice replied, rather shyly, 'I--I hardly know.<\/h1><p>Quaerat reprehenderit mollitia sed dolores in aut rerum. Quas minus necessitatibus vel non aut vero quo.<\/p><p>Et provident ut in officiis provident officiis provident. Aut ut est dolorem recusandae est unde.<\/p><p>Omnis nisi et libero reiciendis veritatis adipisci laudantium. Nostrum repellat distinctio ea quibusdam et ut deserunt. Molestiae beatae tempore sed.<\/p><p>Et sunt vel ex. Nemo dicta quisquam et impedit non. Commodi omnis odio ut quia. Provident aut inventore aut possimus corrupti.<\/p><p>Eum ex dolores sit voluptas. Ducimus voluptate ad aut cumque. Qui aut ea atque quia et enim dolor. Libero aut suscipit optio assumenda placeat optio. Soluta autem quae ducimus corporis deleniti accusamus.<\/p><p>Dolore ut asperiores repellendus suscipit velit sit voluptas. Et eligendi suscipit nobis aut. Soluta consequuntur aut fuga excepturi et assumenda sint.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "p4Djf0ywSZ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 16,
              "type": "audio",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>I shall remember it in with a trumpet in one.<\/h1><p>Placeat sunt provident harum cupiditate. Sed quia asperiores non. Non ducimus pariatur eos atque ipsa numquam voluptatem labore. Hic est qui rem illum expedita molestias est.<\/p><p>Voluptatem cupiditate reiciendis sit cumque maxime molestiae. Cumque qui aut voluptas veritatis totam ut. Iste autem dolor aut quo voluptatum consequatur temporibus. Quis assumenda perferendis quisquam et non.<\/p><p>Molestiae aut aspernatur beatae dolorem est quas. Tempore id asperiores incidunt possimus. Voluptas quo veniam porro odit est modi. Sit ex sint exercitationem ea. Porro eius hic sunt voluptatem perspiciatis molestiae.<\/p><p>Deleniti voluptatem quaerat voluptas voluptates fuga. Eos dolorum deserunt saepe natus autem vero vero. Nulla eos molestias ab odio est.<\/p><p>Sed vel repellat delectus. Deleniti excepturi et nulla enim voluptas explicabo nostrum. Et fugiat voluptas expedita quod quos sit. Dolor iure quam unde.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "P7qx8ZqDQI",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 17,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>Mock Turtle's Story 'You can't think how glad I.<\/h1><p>Dolorem omnis ut autem rem totam possimus qui. Est qui expedita molestiae ex eaque. Amet voluptatem repudiandae in in. Impedit in placeat consequuntur quam iusto.<\/p><p>Modi nam ea et qui fuga. Expedita temporibus quidem cum. Consequatur eos quia nulla est.<\/p><p>Nesciunt aut at aperiam unde. Et consectetur incidunt eius enim id quia molestias magnam. Similique beatae suscipit culpa ut fuga sequi. Itaque dicta soluta reprehenderit voluptatem quod quidem.<\/p><p>Sint sed eos numquam id veniam sed. Numquam modi minima ut earum velit autem. Aut qui qui voluptas quisquam possimus omnis.<\/p><p>Nihil odio harum natus iure nemo aut assumenda. At et ut quod tempora. Quasi quia nihil omnis ad dicta et. Blanditiis sed fugit ad officia molestias qui.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "FQIgIPyCiV",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 19,
              "type": "quotes",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>I don't keep the same size: to be seen: she.<\/h1><p>Voluptas itaque ratione voluptatem beatae. Iure aut qui animi libero et et. Tempora alias impedit sapiente nobis veniam quia occaecati.<\/p><p>Officiis et accusamus nobis ut distinctio fuga. Cum aut officiis commodi sed facere nihil sed. Fuga accusantium aut veniam quia consequatur.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "NOGX1jppnV",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 21,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Queen say only yesterday you deserved to be.<\/h1><p>Molestiae pariatur ut rerum. Est expedita molestias qui. Quas voluptatibus dignissimos nobis est assumenda minima tempora.<\/p><p>Praesentium quia laudantium qui ut voluptates. Quidem consectetur molestiae occaecati saepe ipsam dolor ducimus. Eum natus consequatur labore a officiis odio reprehenderit. Labore nostrum est cumque labore.<\/p><p>Autem ut sunt esse aut nihil. Id facilis assumenda explicabo eius ut et. Molestiae delectus et quo et. Nulla fugiat in iste consequatur.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "nK304kfDiW",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 23,
              "type": "videos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<h1>He trusts to you to sit down without being.<\/h1><p>Veniam consectetur et eos est ex repellendus aliquam et. Animi assumenda animi sed. Dicta voluptatem unde autem qui. Quisquam quos tempora incidunt dolores.<\/p><p>Aut eos placeat necessitatibus porro. Eos consequatur eum illum quam reprehenderit quas. Et et neque blanditiis odit.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "O6HYTGpTIJ",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 29,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "draft",
              "content":
                  "<h1>Duchess's knee, while plates and dishes crashed.<\/h1><p>Quia beatae nam laboriosam et dolorem modi. Placeat necessitatibus quasi magni et est est laborum. Amet eum architecto mollitia laborum.<\/p><p>Voluptatem quae voluptatem repudiandae doloremque ut omnis. Rerum quis animi qui neque sint deserunt nisi. Fugiat ullam aut aliquid aliquam voluptatem.<\/p><p>Voluptas quos omnis velit id iure aut molestias. Autem atque quae alias unde rerum quos deleniti. Nam perspiciatis et eos reiciendis sunt.<\/p><p>Fugit voluptatem saepe dolorem ad. Unde cumque quos totam amet. Accusamus veniam sunt ab inventore.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "nFfU3WfQT1",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 7,
              "blog_name": "placeat",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 47,
              "type": "photos",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "private",
              "content":
                  "<h1>Why, it fills the whole she thought it would,'.<\/h1><p>Voluptas voluptatum molestias voluptas aut. Sed ut non necessitatibus dicta impedit dignissimos. Dolores aut dignissimos qui et nihil voluptatem magni sunt.<\/p><p>Fugiat incidunt tempore at unde officia esse consectetur placeat. Ut dolor cumque minima velit dolores amet magnam. Aut occaecati laborum corrupti.<\/p><p>Eos incidunt sint suscipit beatae quisquam est provident et. Ipsa voluptate repellendus a facere. Ut fuga omnis ipsa error ipsam in.<\/p>",
              "date": "Monday, 20-Dec-21 19:39:59 UTC",
              "source_content": "cZtZZkfI1I",
              "tags": ["summer", "winter"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 5,
              "blog_name": "quis",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 57,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "<img src=\"https:\/\/cmplrserver.s3.eu-west-2.amazonaws.com\/images\/1640121921_17_Screenshot(10).png\"><div>hello from other server uploaded image successfulyy<\/div>",
              "date": "Tuesday, 21-Dec-21 21:26:29 UTC",
              "source_content": null,
              "tags": [],
              "is_liked": true,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 17,
              "blog_name": "sba7el5eer",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          },
          {
            "post": {
              "post_id": 58,
              "type": "text",
              "notes_count": 200,
              "reblogKey": "sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU",
              "state": "publish",
              "content":
                  "skjnkjns kjsn <b>sjsns<\/b>&nbsp;<u style=\"\"><i>jnksjn<\/i><\/u>",
              "date": "Tuesday, 21-Dec-21 21:33:07 UTC",
              "source_content": null,
              "tags": ["hi", "bye"],
              "is_liked": false,
              "is_mine": false,
            },
            "blog": {
              "blog_id": 17,
              "blog_name": "sba7el5eer",
              "avatar":
                  "https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png",
              "avatar_shape": "circle",
              "replies": "everyone",
              "follower": true
            }
          }
        ],
        "next_url": "http:\/\/127.0.0.1:8000\/api\/user\/dashboard?page=2",
        "total": 22,
        "current_page": 1,
        "posts_per_page": 15
      }
    },
    GetURIs.recommendedSearchQueries: {
      'recommended_search_queries': [
        'Barcelona',
        'PSG',
        'Real Madrid',
        'Atletico Madrid',
        'Manchester City',
        'Manchester United',
        'Chelsea',
        'Liverpool',
        'Arsenal',
        'Borussia Dortmund',
        'Inter Milan',
        'Ac Milan',
        'Juventus'
      ]
    },
    // Doesn't use post()
    Routes.signupPreferencesSearchScreen: {
      'popular_searched_topics': [
        'Barcelona',
        'PSG',
        'Real Madrid',
        'Atletico Madrid',
        'Manchester City',
        'Manchester United',
        'Chelsea',
        'Liverpool',
        'Arsenal',
        'Borussia Dortmund',
        'Inter Milan',
        'Ac Milan',
        'Juventus'
      ],
      'searched_topics': [
        'Atletico Madrid',
        'Manchester City',
        'Manchester United',
        'Chelsea',
        'Borussia Dortmund',
        'Inter Milan',
        'Ac Milan',
      ]
    },
    GetURIs.blogInfo: {
      "meta": {"status": 200, "msg": "Success"},
      "response": {
        "blog_id": 1,
        "blog_name": "yousef",
        "title": "untitled",
        "avatar":
            "https://assets.tumblr.com/images/default_avatar/cone_closed_128.png",
        "avatar_shape": "circle",
        "header image":
            "https://assets.tumblr.com/images/default_header/optica_pattern_02_640.png?_v=b976ee00195b1b7806c94ae285ca46a7",
        "description": "Test",
        "background_color": "white",
        "url": "http://cmplr/1/info", // TODO: Check this
        "last_update": "2021-12-27T13:50:56.980364Z",
      }
    },
    GetURIs.followingBlogs: {
      'blogs': [
        {
          'blog_url': 'http:\/\/localhost:8000\/api\/blog\/ut',
          'avatar':
              'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
          'avatar_shape': 'circle',
          'blog_name': 'Mostafa',
          'title': 'Mohamed'
        },
      ],
    },
    GetURIs.conversationMessages: {
      "messages": [
        {
          "id": 5007,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "1",
          "is_read": true,
          "created_at": "2021-12-27T17:38:18.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5006,
          "from_blog_id": "11",
          "to_blog_id": "10",
          "content": "hola",
          "is_read": true,
          "created_at": "2021-12-27T17:33:50.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5005,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "hi",
          "is_read": true,
          "created_at": "2021-12-27T17:33:49.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5004,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "hi",
          "is_read": true,
          "created_at": "2021-12-27T17:28:06.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5003,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "hi",
          "is_read": true,
          "created_at": "2021-12-27T17:27:02.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5002,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "hi",
          "is_read": true,
          "created_at": "2021-12-27T17:26:26.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 5001,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "hi",
          "is_read": true,
          "created_at": "2021-12-27T17:24:29.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 4717,
          "from_blog_id": "11",
          "to_blog_id": "10",
          "content": "Repellendus enim fugiat.",
          "is_read": true,
          "created_at": "2021-12-25T22:44:50.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 4701,
          "from_blog_id": "10",
          "to_blog_id": "11",
          "content": "Quis esse incidunt reiciendis voluptates.",
          "is_read": true,
          "created_at": "2021-12-25T22:44:50.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        },
        {
          "id": 4779,
          "from_blog_id": "11",
          "to_blog_id": "10",
          "content": "Voluptatem quo ex aut sed tenetur.",
          "is_read": true,
          "created_at": "2021-12-25T22:44:50.000000Z",
          "updated_at": "2021-12-27T17:44:42.000000Z"
        }
      ],
      "blog_data": {
        "blog_id": "10",
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
    },
    GetURIs.conversationsList: [
      {
        "from_blog_id": "12",
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

  static const requestSuccess = 200;
  static const invalidData = 422;
  static const unauthenticated = 401;
  static const insertSuccess = 201;

  // static const String apiIp = 'https://www.cmplr.tech/api';
  // static const String apiIp = 'https://www.beta.cmplr.tech/api';
  //static const String apiIp = 'http://5717-197-46-249-92.ngrok.io/api';
  // static const String apiIp = 'http://c089-156-215-8-141.ngrok.io/api';
  static const String apiIp = 'http://c089-156-215-8-141.ngrok.io/api';
  static final Map<String, String> postHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',

    // TODO: Change this to the logged user's token
    'Authorization':
        // ignore: lines_longer_than_80_chars
        'Bearer ${GetStorage().read('token')}'
    //  TODO add authorization header
  };
  // getHeader = postHeader for now until we find a reason to split them
  static final Map<String, String> getHeader = postHeader;

  static Future<http.Response> post(String backendURI, Map params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (backendURI) {
      case PostURIs.signup:
        return signupMailNameVerification(backendURI, params);
      case PostURIs.login:
        return login(backendURI, params);
      case PostURIs.askBlog:
        return askBlog(backendURI, params);
      case PostURIs.post:
        return createPost(backendURI, params);
      case PostURIs.reblog:
        return reblogPost(backendURI, params);
      case PostURIs.loginGoogle:
        return loginWithGoogle(backendURI, params);
      case PostURIs.signupGoogle:
        return signupWithGoogle(backendURI, params);
      case PostURIs.imgUpload:
        return uploadImg(backendURI, params);
      case PostURIs.postReply:
        return postReply(backendURI, params);
      case PostURIs.resetPassword:
        return forgotPassword(backendURI, params);
      default:
        throw Exception('Invalid request route');
    }
  }

  static Future<http.Response> get(String route, Map params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case GetURIs.postFollowing:
        return getPosts(route, params);
      // ignore: no_duplicate_case_values
      case GetURIs.postStuff:
        return getPosts(route, params);
      case GetURIs.trendingPosts:
        return getPosts(route, params);
      case GetURIs.notes:
        return getNotes(route, params);
      case GetURIs.blogInfo:
        return getBlogInfo(
            '/blog/' +
                GetStorage().read('user')['primary_blog_id'].toString() +
                '/info',
            params);
      case GetURIs.userTheme:
        return getUserTheme(route, params);
      case GetURIs.activityNotifications:
        return getActivityNotifications(route, params);
      case GetURIs.postByName:
        return getPostByName(
            route + GetStorage().read('user')['blog_name'], params);
      case GetURIs.userLikes:
        return getUserLikes(route, params);
      case GetURIs.tagsYouFollow:
        return getTagsYouFollow(route);
      case GetURIs.checkOutTheseTags:
        return getCheckoutTheseTags(route);
      case GetURIs.checkOutTheseBlogs:
        return getCheckoutTheseBlogs(route);
      case GetURIs.conversationsList:
        return getConversationsList(route, params);
      case GetURIs.conversationMessages:
        return getConversationMessages(route, params);
      case GetURIs.tryThesePosts:
        return getTryThesePosts(route);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> put(
      String route, Map<String, dynamic> params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case PutURIs.userTheme:
        return putTheme(route, params);
      case GetURIs.activityNotifications:
        return getActivityNotifications(route, params);
      case PutURIs.saveBlogSettings:
        return putBlogSettings(
            route.split(' ')[0] +
                GetStorage().read('user')['blog_name'].toString() +
                route.split(' ')[1],
            params);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> delete(
      String route, Map<String, dynamic> params) async {
    switch (route) {
      case DeleteURIs.unfollowBlog:
        return unfollowBlog(route, params);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> signupWithGoogle(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> forgotPassword(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  // TODO: Rename this screen to 'extra signup'
  static Future<http.Response> signupMailNameVerification(
      String backendURI, Map params) async {
    if (Flags.mock) {
      final Set emails = _mockData[backendURI]['emails'];
      final Set names = _mockData[backendURI]['names'];

      final response = {};
      final errors = {};
      response['error'] = errors;

      final registeredEmail = emails.contains(params['email']);
      final registeredName = names.contains(params['blog_name']);

      if (registeredEmail) {
        errors['email'] = [];
        errors['email'].add('The email has already been taken');
      }
      if (registeredName) {
        errors['blog_name'] = [];
        errors['blog_name'].add('The blog name has already been taken');
      }

      final bothFree = !registeredName && !registeredEmail;
      if (bothFree) {
        emails.add(params['email']);
        names.add(params['blog_name']);
      }

      final responseCode = bothFree ? insertSuccess : invalidData;
      return http.Response(jsonEncode(response), responseCode);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> loginWithGoogle(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> login(String backendURI, Map params) async {
    if (Flags.mock) {
      final email = params['email'];
      final password = params['password'];

      final emailsPasswords = _mockData[backendURI]['users'];

      final matchingEmailPasswordCombination =
          emailsPasswords[email] == password;

      if (!matchingEmailPasswordCombination)
        return http.Response(
            jsonEncode({
              'error': ['UnAuthorized']
            }),
            unauthenticated);

      return http.Response(
          jsonEncode({
            'user': {
              'blog_name': 'mock', /* TODO: Add more user data? */
            },
          }),
          requestSuccess);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> getUserTheme(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final res = User.userMap['theme'];
      return http.Response(jsonEncode(res), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      return http.get(
          Uri.parse(apiIp +
              '/blog/' +
              GetStorage().read('user')['primary_blog_id'].toString() +
              '/info'),
          headers: tempHeader);
    }
  }

  static Future<http.Response> putBlogSettings(
      String backendURI, Map params) async {
    if (Flags.mock) {
      // TODO: Change theme
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.put(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> putTheme(String backendURI, Map params) async {
    if (Flags.mock) {
      // TODO: Change theme
      return http.Response(jsonEncode({}), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      return http.put(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> askBlog(String backendURI, Map param) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), 201));
    } else {
      return http.post(Uri(path: PostURIs.getAskBlog(param['BlogId'])),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // TODO add authorization header
          },
          body: jsonEncode(param)); /* e */
    }
  }

  static Future<http.Response> createNewPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), 201));
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
      );
    }
  }

  static Future<http.Response> reblogExistingPost(
      String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), 201));
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
      );
    }
  }

  // This functionality is not implemeted in the back-end
  static List initialPreferences(String route) {
    return _mockData[route]['preference_names'];
  }

  // This functionality is not implemeted in the back-end
  static List searchedTopics(String route, String topics) {
    return _mockData[route][topics];
  }

  static Future<http.Response> getPosts(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await _mockData[backendURI];
      return http.Response(jsonEncode(res), res['meta']['status_code']);
    } else {
      return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
    }
  }

  static Future<http.Response> getConversationsList(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await _mockData[backendURI];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      final uri = Uri.parse(apiIp + backendURI + '/' + params['me']);

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> getPostByName(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await _mockData[backendURI];
      return http.Response(jsonEncode(res), res['meta']['status_code']);
    } else {
      return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
    }
  }

  static Future<http.Response> getConversationMessages(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await _mockData[backendURI];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      return http.get(
          Uri.parse(
              apiIp + backendURI + '/' + params['me'] + '/' + params['me']),
          headers: getHeader);
    }
  }

  static Future<http.Response> getUserLikes(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
    } else {
      final tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      return http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
    }
  }

  static Future<http.Response> uploadImg(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      return http.Response(jsonEncode({}), 200);
    } else {
      // ignore: prefer_final_locals
      return http.post(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> getBlogInfo(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final res = await _mockData['/blog/info'];
      return http.Response(jsonEncode(res), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      return http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
    }
  }

  // ToDo: should be a Get request
  static Future<http.Response> getNotes(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(jsonEncode(notesMockData), requestSuccess);
    } else {
      //${params['post_id']}
      // TODO: change the 11
      final uri = Uri.parse(apiIp + backendURI)
          .replace(query: 'post_id=${params['post_id']}');

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> createPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
  }

  static Future<http.Response> reblogPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else
      return http.post(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
  }

  static Future<http.Response> getRecommendedSearchQueries(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(
          jsonEncode(_mockData[GetURIs.recommendedSearchQueries]
              ['recommended_search_queries']),
          requestSuccess);
    } else {
      return http.Response(
          jsonEncode(_mockData[GetURIs.recommendedSearchQueries]
              ['recommended_search_queries']),
          requestSuccess);
    }
  }

  static Future<http.Response> getFollowingBlogs(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(jsonEncode(_mockData[backendURI]), requestSuccess);
    } else {
      return http.Response(jsonEncode(_mockData[backendURI]), requestSuccess);
    }
  }

  static Future<http.Response> getActivityNotifications(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      return Future.value(http.Response(jsonEncode({}), invalidData));
    } else {
      return http.post(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> followBlog(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'blogName': params['blogName'],
          }));
    }
  }

  static Future<http.Response> unfollowBlog(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      final req = await http.delete(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'blogName': params['blogName'],
          }));
      final x = req.statusCode;
      return req;
    }
  }

  static Future<http.Response> postReply(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'post_id': params['post_id'],
            'reply_text': params['reply_text']
          }));
    }
  }

  static Future<http.Response> getTagsYouFollow(String backendURI) {
    // ignore: prefer_final_locals
    var tempHeader = getHeader;
    if (tempHeader['Authorization'] == 'Bearer null')
      tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
    return http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
  }

  static Future<http.Response> getCheckoutTheseTags(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }

  static Future<http.Response> getCheckoutTheseBlogs(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }

  static Future<http.Response> getTryThesePosts(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }
}
