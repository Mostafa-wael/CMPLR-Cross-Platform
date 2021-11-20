import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_icons/custom_icons.dart';

// This preserves the scroll state of the list view,
// It is used due to this issue in Getx: https://github.com/jonataslaw/getx/issues/822
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class Notes extends StatelessWidget {
  Notes({Key? key}) : super(key: key);

  var controller = Get.put(NotesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xFF001A35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
            onPressed: () {
              controller.closeNotesScreen();
            },
            splashRadius: 40,
          ),
          // centerTitle: true,
          title: const Text(
            'X notes',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(controller.postSubscribed.value
                  ? Icons.notifications
                  : Icons.notifications_off_outlined),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                controller.subscriptionButtonPressed();
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: controller.notesModel.getNotesCount(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final notesCount = snapshot.data ?? [];
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Material(
                        child: InkWell(
                            onTap: () {},
                            child: TabBar(
                              controller: controller.tabController,
                              onTap: (index) {
                                // controller.handleTabSelection();
                              },
                              indicatorColor: controller.tabBarIndicatorColor,
                              tabs: <Widget>[
                                Tab(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CustomIcons.comment,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        '${notesCount[0]}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CustomIcons.reblog,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 15),
                                      Text('${notesCount[1]}',
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CustomIcons.heart,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 15),
                                      Text('${notesCount[2]}',
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: <Widget>[
                          const Center(child: Text('Comments')),
                          const Center(
                            child: Text('Reblogs'),
                          ),
                          KeepAliveWrapper(
                            child: FutureBuilder(
                              future: controller.notesModel.getPostLikes(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  final postLikes = snapshot.data ?? [];
                                  return ListView.builder(
                                    itemCount: postLikes.length,
                                    itemBuilder: (context, index) {
                                      return buildLikesListTile(
                                          postLikes[index]);
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              }
            }));
  }

  Widget buildLikesListTile(var userData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 65,
          padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
          child: Stack(children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData.avatarURL),
                  radius: 18,
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 225,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.tumblrName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        userData.profileTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            Positioned(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: 45,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: const Center(
                            child: Text(
                          'Follow',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ))),
                  )),
              right: 0,
            )
          ]),
        ),
      ),
    );
  }
}
