import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

class SignupPreferencesSearch extends StatelessWidget {
  const SignupPreferencesSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupPreferencesSearchController>(
        init: SignupPreferencesSearchController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                toolbarHeight: Sizing.blockSizeVertical * 1.5,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF001A35),
                    padding: const EdgeInsets.fromLTRB(18, 0, 5, 0),
                    height: Sizing.blockSizeVertical * 28.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pick your own topics',
                              style: TextStyle(
                                  fontSize: Sizing.blockSize * 7.25,
                                  color: Colors.white),
                            ),
                            SizedBox(width: Sizing.blockSize * 14.85),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                controller.closeSearchPage();
                              },
                              icon: const Icon(Icons.close),
                              color: Colors.blue,
                            )
                          ],
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 1.5),
                        Text(
                          'Didn\'t find what you wanted? Add it below.',
                          style: TextStyle(
                              fontSize: Sizing.blockSize * 4.4,
                              color: Colors.white),
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 3),
                        TextField(
                          onChanged: (query) {
                            controller.searchQueryChanged();
                          },
                          controller: controller.searchBarController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (topicName) {
                            controller.addSearchedTopic(topicName);
                          },
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: Sizing.blockSize * 3.715,
                              color: Colors.black),
                          decoration: InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                  minHeight: Sizing.blockSizeVertical * 3,
                                  minWidth: Sizing.blockSize * 8.65),
                              prefixIcon: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: Sizing.blockSize * 3.7,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Sizing.blockSize * 12.35),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(
                                  0,
                                  Sizing.blockSize * 1.2,
                                  Sizing.blockSize,
                                  Sizing.blockSize * 1.2),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Sizing.blockSize * 12.35),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: 'Add topic',
                              fillColor: Colors.white),
                        ),
                        SizedBox(height: Sizing.blockSize * 3.75),
                        Text(controller.searchIndicatorString,
                            style: TextStyle(
                                fontSize: Sizing.blockSize * 5.8,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListView.builder(
                        itemCount: controller.currentlyShownTopics.length,
                        itemBuilder: (context, index) {
                          return buildSearchResultTile(controller, index);
                        }),
                  )),
                ],
              ),
            ));
  }

  /// This builds the search list view tile widget (a tile is used to show one
  /// search result)
  Widget buildSearchResultTile(
      SignupPreferencesSearchController controller, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Sizing.blockSize * 7.45, 0, Sizing.blockSize * 2.5, 0),
      child: InkWell(
        onTap: () {
          controller.addSearchedTopic(controller.currentlyShownTopics[index]);
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: Sizing.blockSizeVertical * 7.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: Sizing.blockSize * 1.24,
              ),
              Text(
                controller.currentlyShownTopics[index],
                style: TextStyle(
                    color: Colors.white, fontSize: Sizing.blockSize * 4.2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
