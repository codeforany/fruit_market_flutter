import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List pageArray = [
    {
      "img": "assets/img/in_1.png",
      "title": "E Shopping",
      "subtitle": "Explore  top organic fruits & grab them"
    },
    {
      "img": "assets/img/in_2.png",
      "title": "Delivery on the way",
      "subtitle": "Get your order by speed delivery"
    },
    {
      "img": "assets/img/in_3.png",
      "title": "Delivery Arrived",
      "subtitle": "Order is arrived at your Place"
    },
  ];

  int selectPage = 0;
  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    // controller?.addListener(() {
    //   selectPage = (controller?.page)?.toInt() ?? 0;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (newVal) {
              setState(() {
                selectPage = newVal;
              });
            },
            itemBuilder: (context, index) {
              var pObj = pageArray[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: context.width * 0.25),
                child: Column(
                  children: [
                    Image.asset(
                      pObj["img"],
                      fit: BoxFit.fitWidth,
                      width: context.width,
                      height: context.width,
                    ),
                    Text(
                      pObj["title"],
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      pObj["subtitle"],
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: pageArray.length,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (selectPage != pageArray.length - 1)
                      TextButton(
                          onPressed: () {
                            loadNextScreen();
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 14,
                            ),
                          ))
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pageArray.map((pObj) {
                    var index = pageArray.indexOf(pObj);

                    return Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: selectPage == index
                              ? TColor.active
                              : Colors.transparent,
                          border: Border.all(color: TColor.active, width: 1),
                          borderRadius: BorderRadius.circular(6)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: context.width * 0.22,
                ),
                RoundButton(
                    title: selectPage == pageArray.length - 1
                        ? "Get Started"
                        : "Next",
                    width: 150,
                    onPressed: () {
                      if (selectPage == pageArray.length - 1) {
                        loadNextScreen();
                      } else {
                        setState(() {
                          selectPage += 1;
                        });

                        controller?.animateToPage(selectPage,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.bounceInOut);
                      }
                    }),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //TODO: Action

  void loadNextScreen() {
    context.push( const LoginScreen() );
  }
}
