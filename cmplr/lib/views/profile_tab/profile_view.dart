import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../views/views.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => FutureBuilder(
          future: controller.getBlogInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: Sizing.blockSizeVertical * 50,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Stack(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/logo_icon.png',
                                  image: controller.headerImage,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: Sizing.blockSizeVertical * 24,
                                  left: Sizing.blockSize * 40,
                                  child:
                                      (controller.blogAvatarShape == 'circle')
                                          ? ClipOval(
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'lib/utilities/assets/logo/logo_icon.png',
                                                image: controller.blogAvatar,
                                                height: Sizing.blockSize * 20,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRect(
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'lib/utilities/assets/logo/logo_icon.png',
                                                image: controller.blogAvatar,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Sizing.blockSize * 4,
                                      Sizing.blockSizeVertical * 5,
                                      Sizing.blockSize * 4,
                                      0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          controller.blogName,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 3.5,
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.search),
                                              onPressed: () {
                                                Get.to(ProfileSearch());
                                              },
                                            ),
                                            IconButton(
                                              icon:
                                                  const Icon(Icons.color_lens),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.share),
                                              onPressed: () {
                                                controller.share(context);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.settings),
                                              onPressed: () {
                                                controller.goToSettings();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  top: Sizing.blockSizeVertical * 38,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          controller.blogTitle,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 7,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                Sizing.blockSizeVertical * 0.5),
                                        Text(
                                          controller.description,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 3.5,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          forceElevated: innerBoxIsScrolled,
                          bottom: const TabBar(
                            tabs: <Tab>[
                              Tab(
                                child: Text(
                                  'Posts',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Likes',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Following',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                        ),
                        Container(
                          color: Colors.red,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          }),
    );
  }
}
