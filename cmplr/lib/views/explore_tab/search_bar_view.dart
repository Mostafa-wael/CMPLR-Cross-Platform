import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) => Scaffold(
                body: SafeArea(
                    child: Column(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.closeSearchPage();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      )),
                  SizedBox(
                    width: Sizing.blockSize * 2.5,
                  ),
                  SizedBox(
                    width: Sizing.blockSize * 74,
                    child: TextField(
                      onChanged: (query) {
                        controller.searchQueryChanged();
                      },
                      controller: controller.searchBarController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (searchQuery) {
                        controller.search(searchQuery);
                      },
                      cursorColor: Colors.blue,
                      style: TextStyle(
                          fontSize: Sizing.fontSize * 5,
                          color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIconConstraints: BoxConstraints(
                              minHeight: Sizing.blockSizeVertical * 6,
                              minWidth: Sizing.blockSize * 8.65),
                          contentPadding: EdgeInsets.fromLTRB(
                              Sizing.blockSize,
                              Sizing.blockSize * 1.2,
                              Sizing.blockSize,
                              Sizing.blockSize * 1.2),
                          isDense: true,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: 'Search CMPLR',
                          fillColor: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  Obx(() => Visibility(
                      visible: controller.showClearSearchBarIcon.value,
                      child: IconButton(
                        splashRadius: 24,
                        onPressed: () {
                          controller.searchBarController.text = '';
                        },
                        icon: Icon(Icons.close,
                            color: Theme.of(context).primaryColor),
                      )))
                ],
              ),
              FutureBuilder(
                  future: controller.searchModel.getRecommendedSearchQueries(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      controller.recommendedQueries = snapshot.data ?? [];
                      return Expanded(
                          child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListView.builder(
                            itemCount: controller.recommendedQueries.length,
                            itemBuilder: (context, index) {
                              return buildSearchResultTile(
                                  context, controller, index);
                            }),
                      ));
                    } else {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      );
                    }
                  }),
            ]))));
  }

  /// This builds the search list view tile widget (a tile is used to show one
  /// search result)
  Widget buildSearchResultTile(
      BuildContext context, SearchController controller, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Sizing.blockSize * 3, 0, Sizing.blockSize * 2.5, 0),
      child: InkWell(
        onTap: () {
          controller.search(controller.recommendedQueries[index]);
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: Sizing.blockSizeVertical * 7.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: Sizing.blockSize * 5.5,
              ),
              Text(
                controller.recommendedQueries[index],
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizing.fontSize * 4.2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
