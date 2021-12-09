import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_icons/custom_icons.dart';
import '../../utilities/sizing/sizing.dart';

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
            onPressed: () {
              controller.closeNotesScreen();
            },
            splashRadius: Sizing.blockSize * 4.95,
          ),
          // centerTitle: true,
          title: Text(
            '${Get.arguments} notes',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
              icon: Icon(controller.postSubscribed.value
                  ? Icons.notifications
                  : Icons.notifications_off_outlined),
<<<<<<< HEAD
              color: Theme.of(context).primaryColor,
              iconSize: 30,
=======
              color: Colors.white,
              iconSize: Sizing.blockSize * 7.415,
>>>>>>> 774efb8b030d60e184ad05effe3c4db057de336f
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
                      color: Theme.of(context).primaryColor,
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
                                  height: Sizing.blockSizeVertical * 7.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CustomIcons.comment,
                                        // color: Colors.black,
                                      ),
                                      SizedBox(width: Sizing.blockSize * 3.71),
                                      Text(
                                        '${notesCount[0]}',
                                        style: const TextStyle(
                                            // color: Colors.black
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: Sizing.blockSizeVertical * 7.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CustomIcons.reblog,
                                        // color: Colors.black,
                                      ),
                                      SizedBox(width: Sizing.blockSize * 3.71),
                                      Text('${notesCount[1]}',
                                          style: const TextStyle(
                                              // color: Colors.black
                                              ))
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: Sizing.blockSizeVertical * 7.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CustomIcons.heart,
                                        size: Sizing.blockSize * 5.44,
                                        // color: Colors.black,
                                      ),
                                      SizedBox(width: Sizing.blockSize * 3.71),
                                      Text('${notesCount[2]}',
                                          style: const TextStyle(
                                              // color: Colors.black
                                              ))
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
          height: Sizing.blockSizeVertical * 9.75,
          padding: EdgeInsets.fromLTRB(
              Sizing.blockSize * 3.71,
              Sizing.blockSizeVertical * 1.5,
              Sizing.blockSize * 1.24,
              Sizing.blockSizeVertical * 1.5),
          child: Stack(children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData.avatarURL),
                  radius: Sizing.blockSize * 4.45,
                ),
                SizedBox(width: Sizing.blockSize * 3.71),
                SizedBox(
                  width: Sizing.blockSize * 55.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.tumblrName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        userData.profileTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizing.blockSize * 4.2,
                          fontWeight: FontWeight.w400,
                          // color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Sizing.blockSize * 6.2),
              ],
            ),
            Positioned(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: Sizing.blockSizeVertical * 6.75,
                        padding: EdgeInsets.fromLTRB(Sizing.blockSize * 2.5, 0,
                            Sizing.blockSize * 2.5, 0),
                        child: Center(
                            child: Text(
                          'Follow',
                          style: TextStyle(
                              fontSize: Sizing.blockSize * 4.65,
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
