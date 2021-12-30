class PostURIs {
  // Blog requests
  // Split into 2 halfs, the first half is used to call the proper function
  // which contains mock/api logic. This has to be constant since we use a switch
  // case.
  // The second half are helper functions that help construct the real URI we
  // will send the request to.

  // Real URIs you can use
  static const String createBlog = '/blog';
  static const String signup = '/register/insert';
  static const String login = '/login';

  static const String reblog = '/posts/reblog';
  static const String post = '/posts';
  static const String signupGoogle = '/google/signup';
  static const String postReply = '/user/post/reply';
  static const String followBlog = '/user/follow';
  static const String likePost = '/user/like';
  static const String sendMessage = '/messaging/conversation';

  // URIs just for the switch case.
  // To get the real URI, use the help functions below.
  static const String askBlog = '/blog/ask';
  static const String blockBlog = 'blog/block';
  static const String submitPost = '/blog/submit';
  static const String subscribeBlog = '/blog/subscribe';
  static const String addTagsToPost = '/add_tags_to_posts';
  static const String loginGoogle = '/google/login';
  // Helper functions
  static String getAskBlog(String blogId) => '/blog' + blogId + '/ask';
  static String getBlockBlog(String blogId) => '/blog' + blogId + '/block';
  static String getSubmitPost(String blogId) => '/blog' + blogId + '/submit';
  static String getSubscribeBlog(String blogId) =>
      '/blog' + blogId + '/subscription';
  static String getAddTagsToPost(String blogID) =>
      '/' + blogID + '/add_tags_to_posts';
  static const String imgUpload = '/base64image_upload';
}

class GetURIs {
  // FIXME: Replace the URI when the back implements this
  static const String getSuggestedTags = '/recommended/tags';

  static const String activityNotifications = '/notifications';

  static String getActivityNotifications(String blogName) =>
      '/blog/' + blogName + '/notifications';

  static String getGetTagsForPosts(String blogID) =>
      '/' + blogID + '/get_tags_for_posts';

  static const String getTagsForPosts = '/get_tags_for_posts';
  static const String postFollowing = '/user/dashboard';
  static const String trendingPosts = '/trending/posts';
  static const String postStuff = '/user/dashboard';
  static const String hashtagPosts = '/post/tagged';
  static const String tagInfo = '/tag/info';
  static const String notes = '/post/notes';

  static const String tagsYouFollow = '/following/tags';
  static const String checkOutTheseTags = '/recommended/tags';
  static const String checkOutTheseBlogs = '/recommended/blogs';
  static const String tryThesePosts = '/recommended/posts';

  static const String recommendedSearchQueries = '/search_bar';
  static const String blogInfo = 'blog/info';
  static String getBlogInfo(String blogId) => '/blog/' + blogId + '/info';
  static const String userTheme = '/user_theme';
  static const String followingBlogs = '/user/followings';
  static const String postByName = '/posts/view';
  static const String userLikes = '/user/likes';
  static const String conversationsList = '/blog/messaging';
  static const String conversationMessages = '/messaging/conversation';
}

class PutURIs {
  static const String userTheme = '/user_theme';
  static const String saveBlogSettings = '/blog/ /settings/save';
}

class DeleteURIs {
  static const String unfollowBlog = '/user/follow';
  static const String unlikePost = '/user/unlike';
}
