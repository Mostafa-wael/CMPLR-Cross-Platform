import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../../controllers/controllers.dart';
import 'master_page.dart';

class SignupPreferences extends StatelessWidget {
  const SignupPreferences({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      return await showDialog(
              context: context,
              builder: (context) => Dialog(
                  insetPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  backgroundColor: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 145,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                              'Aw. If you leave now,'
                              ' you\'ll lose all your progress.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 21)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 200),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'CONTINUE',
                                  style: TextStyle(fontSize: 16),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text('LEAVE',
                                    style: TextStyle(fontSize: 16)))
                          ],
                        )
                      ],
                    ),
                  ))) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GetBuilder<SignupPreferencesController>(
        init: SignupPreferencesController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: const Color(0xFF001A35),
              actions: [
                (controller.isLoading)
                    ? CollectionScaleTransition(
                        children: [
                          const Icon(Icons.crop_square_outlined),
                          const Icon(Icons.crop_square_outlined),
                          const Icon(Icons.crop_square_outlined),
                        ],
                      )
                    : Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: const Color(0x33f2f2f2),
                          onTap: () {
                            controller.nextButtonPressed();
                          },
                          child: Center(
                            child: Text(
                              '  ${controller.buttonText}  ',
                              style: TextStyle(
                                  color: Color(controller.buttonTextColor),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ))
              ],
            ),
            body: Column(children: [
              Container(
                width: double.infinity,
                height: 115,
                color: const Color(0xFF001A35),
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What do you like?',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Whatever you\'re into, you\'ll find it here. '
                      'Follow some of the tags below to start filling '
                      'your dashboard with the things you love.',
                      style: TextStyle(color: Color(0xFF7F8D9C), fontSize: 19),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                      color: const Color(0xFF001A35),
                      child: GridView.builder(
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.width / 3) /
                                          150,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 2),
                          itemCount:
                              controller.availablePreferenceCards.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return buildCustomCard(controller);
                            }
                            return buildPreferencesCard(controller, index - 1);
                          }))),
            ])),
      ),
    );
  }

  Widget buildCustomCard(SignupPreferencesController controller) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Material(
          color: const Color(0xFF001A35),
          child: InkWell(
            splashColor: const Color(0xaa00689b),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onTap: () {
              controller.chooseNewPreference();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Stack(
                children: [
                  const Positioned(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    bottom: 60,
                    left: 10,
                  ),
                  Positioned(
                    child: Container(
                      width: 125,
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: const Text(
                        'Choose your own',
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    bottom: 10,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildPreferencesCard(
      SignupPreferencesController controller, int index) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.tapPreferenceCard(index);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: Color(controller.availablePreferenceCards[index].color)),
          child: Stack(
            children: [
              Positioned(
                child: Visibility(
                  visible: controller.availablePreferenceCards[index].isChosen,
                  child: IconButton(
                    icon: const Icon(
                      Icons.verified,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ),
                top: 0,
                right: 0,
              ),
              Positioned(
                child: Container(
                  width: 125,
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Text(
                    controller.availablePreferenceCards[index].preferenceName,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                bottom: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
