// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:safeher3/auth/signupPage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  static const routeName = 'onboarding';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  late PageController _controller;

  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];
  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: Colors.pink.shade600,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: height / 100 * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 16 : 24,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  SignUpPage.routeName, (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20)
                                  : EdgeInsets.symmetric(
                                      horizontal: width * 0.2, vertical: 25),
                              textStyle:
                                  TextStyle(fontSize: (width <= 550) ? 13 : 17),
                            ),
                            child: const Text("START"),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: Text(
                                  "SKIP",
                                  style: TextStyle(color: Colors.pink.shade600),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                                child: const Text("NEXT"),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Autonomous Threat Detection",
    image: "assets/onboard_1.png",
    desc:
        "No need to press any button in case of any threat, SafeHer can automatically detect them and generate SOS.",
  ),
  OnboardingContents(
    title: "Easy to configure",
    image: "assets/onboard_2.png",
    desc:
        "You can quickly add or remove whom you want to share alert in case of any threat.",
  ),
  OnboardingContents(
    title: "One tap service activator",
    image: "assets/onboard_3.png",
    desc:
        "You can easily start or stop services of SafeHer with just one click.",
  ),
];
