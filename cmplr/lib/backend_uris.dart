class PostURIs {
  // Blog requests
  static String askBlog(String blogId) => '/blog' + blogId + '/ask';
  static String blockBlog(String blogId) => '/blog' + blogId + '/block';
  static String submitPost(String blogId) => '/blog' + blogId + '/submit';
  static String subscribeBlog(String blogId) =>
      '/blog' + blogId + '/subscription';
  static String addTagsToPost(String blogID) =>
      '/' + blogID + '/add_tags_to_posts';

  static String createBlog = '/blog';
  static String signup = '/signup';
  static String login = '/login';

  // TODO: Add the remaining post request URIS
}

class GetURIs {
  static String getTagsForPosts(String blogID) =>
      '/' + blogID + '/get_tags_for_posts';
  // TODO: Add the remaining get request URIS

}

class PutURIs {
  // TODO: Add the remaining put request URIS

}

class DeleteURIs {
  // TODO: Add the remaining delete request URIS

}
