import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../views/views.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              controller.goBack();
                            },
                          ),
                          title: Text(
                            'Edit appearance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizing.fontSize * 5,
                            ),
                          ),
                          backgroundColor: controller.currentColor,
                          expandedHeight: Sizing.blockSizeVertical * 60,
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
                                      Sizing.blockSizeVertical * 6,
                                      Sizing.blockSize * 4,
                                      0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            controller
                                                .saveEdits(visibleKeyboard);
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    Sizing.fontSize * 4.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  top: Sizing.blockSizeVertical * 36,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          controller:
                                              controller.titleController,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 7,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                (controller.backgroundColor ==
                                                        Colors.white)
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          controller:
                                              controller.descCrontroller,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 3.5,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                (controller.backgroundColor ==
                                                        Colors.white)
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: Sizing.blockSizeVertical * 42,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: Sizing.blockSize * 25,
                                            height:
                                                Sizing.blockSizeVertical * 2.5,
                                            decoration: BoxDecoration(
                                                color: (controller
                                                            .backgroundColor ==
                                                        Colors.blue)
                                                    ? Colors.grey
                                                    : Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Sizing.blockSize * 2))),
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  constraints: BoxConstraints(
                                                    maxHeight: Sizing
                                                            .blockSizeVertical *
                                                        20,
                                                  ),
                                                  builder: (context) {
                                                    return Center(
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          for (var i
                                                              // ignore: lines_longer_than_80_chars
                                                              in ProfileController
                                                                  .clrs.keys)
                                                            InkWell(
                                                              child:
                                                                  // ignore: lines_longer_than_80_chars
                                                                  TwoNestedCircles(
                                                                Colors.white,
                                                                // ignore: lines_longer_than_80_chars
                                                                ProfileController
                                                                    .clrs[i],
                                                                // ignore: lines_longer_than_80_chars
                                                                Sizing.blockSize *
                                                                    5,
                                                                // ignore: lines_longer_than_80_chars
                                                                Sizing.blockSize *
                                                                    4,
                                                              ),
                                                              onTap: () {
                                                                controller
                                                                    // ignore: lines_longer_than_80_chars
                                                                    .changeColor(
                                                                        i);
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Background',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: (controller
                                                                // ignore: lines_longer_than_80_chars
                                                                .backgroundColor ==
                                                            Colors.white)
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Sizing.blockSize * 25,
                                            height:
                                                Sizing.blockSizeVertical * 2.5,
                                            decoration: BoxDecoration(
                                                color: (controller
                                                            .backgroundColor ==
                                                        Colors.blue)
                                                    ? Colors.grey
                                                    : Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Sizing.blockSize * 2))),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                'Accent',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: (controller
                                                                // ignore: lines_longer_than_80_chars
                                                                .backgroundColor ==
                                                            Colors.white)
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          forceElevated: innerBoxIsScrolled,
                          bottom: TabBar(
                            indicatorColor:
                                (controller.backgroundColor == Colors.blue)
                                    ? Colors.black
                                    : Colors.blue,
                            tabs: <Tab>[
                              Tab(
                                child: Text(
                                  'Posts',
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Likes',
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Following',
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
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
