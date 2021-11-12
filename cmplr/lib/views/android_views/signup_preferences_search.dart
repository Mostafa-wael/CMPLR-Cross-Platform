import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';

class SignupPreferencesSearch extends StatelessWidget {
  const SignupPreferencesSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupPreferencesSearchController>(
        init: SignupPreferencesSearchController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: const Color(0xFF001A35),
                toolbarHeight: 40,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    color: Color(0xFF001A35),
                    padding: EdgeInsets.fromLTRB(18, 0, 5, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pick your own topics',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            SizedBox(width: 60),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                controller.closeSearchPage();
                              },
                              icon: Icon(Icons.close),
                              color: Colors.blue,
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Didn\'t find what you wanted? Add it below.',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          onChanged: (query) {
                            controller.searchQueryChanged();
                          },
                          controller: controller.searchBarController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            // print(value);
                          },
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minHeight: 20, minWidth: 35),
                              prefixIcon: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 15,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(0, 8, 4, 8),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: 'Add topic',
                              fillColor: Colors.white),
                        ),
                        SizedBox(height: 25),
                        Text(controller.searchIndicatorString,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: const Color(0xFF001A35),
                    child: ListView.builder(
                        itemCount: controller.mock.length,
                        itemBuilder: (context, index) {
                          return buildSearchResultTile(controller, index);
                        }),
                  )),
                ],
              ),
            ));
  }

  Widget buildSearchResultTile(
      SignupPreferencesSearchController controller, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
      child: InkWell(
        onTap: () {
          print('yes');
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                controller.mock[index],
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
