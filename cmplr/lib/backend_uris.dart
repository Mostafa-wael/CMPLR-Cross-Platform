class PostURIs {
  // Blog requests
  // Split into 2 halfs, the first half is used to call the proper function
  // which contains mock/api logic. This has to be constant since we use a switch
  // case.
  // The second half are helper functions that help construct the real URI we
  // will send the request to.

  // Real URIs you can use
  static const String createBlog = '/blog';
  static const String signup = '/signup';
  static const String login = '/login';

  // URIs just for the switch case.
  // To get the real URI, use the help functions below.
  static const String askBlog = '/blog/ask';
  static const String blockBlog = 'blog/block';
  static const String submitPost = '/blog/submit';
  static const String subscribeBlog = '/blog/subscribe';
  static const String addTagsToPost = '/add_tags_to_posts';
  static const String posts = '/posts';

  // Helper functions
  static String getAskBlog(String blogId) => '/blog' + blogId + '/ask';
  static String getBlockBlog(String blogId) => '/blog' + blogId + '/block';
  static String getSubmitPost(String blogId) => '/blog' + blogId + '/submit';
  static String getSubscribeBlog(String blogId) =>
      '/blog' + blogId + '/subscription';
  static String getAddTagsToPost(String blogID) =>
      '/' + blogID + '/add_tags_to_posts';

  // TODO: Add the remaining post request URIS
}

class GetURIs {
  static String getGetTagsForPosts(String blogID) =>
      '/' + blogID + '/get_tags_for_posts';

  static const String getTagsForPosts = '/get_tags_for_posts';
  // TODO: Add the remaining get request URIS

}

class PutURIs {
  // TODO: Add the remaining put request URIS

}

class DeleteURIs {
  // TODO: Add the remaining delete request URIS

}
