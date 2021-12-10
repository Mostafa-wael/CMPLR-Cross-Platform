import '../../../backend_uris.dart';
import '../../cmplr_service.dart';

class ReblogModel {
  const ReblogModel();

  // Note that all the parameters mentioned in the API are required
  Future<bool> reblogPost(
    String parentPostID,
    String reblogKey,
    String comment,
  ) async {
    final response = await CMPLRService.post(PostURIs.reblog, {
      'id': parentPostID,
      'reblog_key': reblogKey,
      'comment': comment,
    });

    // TODO: What to do with the other responses?
    // AKA: bad request & authenticated
    return response.statusCode == CMPLRService.insertSuccess;
  }
}
