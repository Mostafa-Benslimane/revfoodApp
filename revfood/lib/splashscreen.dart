import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:revfood/SignOrLog.dart';
import 'package:revfood/mainPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class OnBoarding {
  String title = 'he';
  String script = 'he';
  String animation = 'he';

  OnBoarding(
      {required this.title, required this.script, required this.animation});
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController(initialPage: 0);
  bool _isvisible = false;
  int _activePage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _activePage);
  }

  final List<Map<String, OnBoarding>> _pages = [
    {
      '1': OnBoarding(
          title: 'WELCOME',
          script:
              "Discover the world of culinary delights with our app. Whether you're a foodie, a frequent diner, or someone seeking new dining experiences, we've got you covered.",
          animation: 'assets/animation/welcome.json')
    },
    {
      '2': OnBoarding(
          title: 'DISCOVER',
          script:
              "But it doesn't stop there. We believe in the power of community, which is why we encourage you to read and share reviews from fellow food enthusiasts. Let their experiences guide you in making the perfect dining decisions.",
          animation: 'assets/animation/discover.json')
    },
    {
      '3': OnBoarding(
          title: 'RATE AND REVIEW',
          script:
              "Your opinions matter too! By leaving your own reviews, you can help others discover hidden gems and elevate their dining experiences. Together, let's create a vibrant community of culinary enthusiasts sharing their passion for good food.",
          animation: 'assets/animation/review.json')
    },
    {
      '4': OnBoarding(
          title: 'NEARBY',
          script:
              "With our app, tracking down the nearest restaurants is as easy as pie. we pinpoint the best-rated dining spots in your area. Whether you're in a new city or your hometown.",
          animation: 'assets/animation/nearby.json')
    },
    {
      '5': OnBoarding(
          title: '',
          script:
              "So, are you ready to embark on a gastronomic adventure? Let's get started and indulge in unforgettable dining experiences with RevFood!",
          animation: 'assets/animation/empty.json')
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              /*body*/
              children: [
                /*1*/ const SizedBox(
                  /*RevFood Script*/
                  height: 100,
                  child: Text(
                    'RevFood',
                    style: TextStyle(
                      color: Color(0xFFb22222),
                      fontSize: 40.0,
                      fontFamily: 'lol',
                    ),
                  ),
                ),
                /*2*/ Row(
                  /*the whole Box*/
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        /*The Box*/ Stack(
                          children: [
                            /*Slider*/ Container(
                              margin: const EdgeInsets.only(top: 50),
                              height: 500.0,
                              width: 330,
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (int page) {
                                  setState(() {
                                    _activePage = page;
                                    page == 4
                                        ? _isvisible = true
                                        : _isvisible = false;
                                  });
                                },
                                itemCount: _pages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      Text(
                                        _pages[index].values.first.title,
                                        style: const TextStyle(
                                            fontFamily: "bigpoppins",
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 300,
                                        child: Visibility(
                                          visible: !_isvisible,
                                          child: Lottie.asset(_pages[index]
                                              .values
                                              .first
                                              .animation),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          _pages[index].values.first.script,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "poppins",
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: _isvisible,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 15, top: 30),
                                height: 300,
                                child: Lottie.asset(
                                    'assets/animation/loc_ay.json'),
                              ),
                            ),
                            /*get started butn*/ Visibility(
                              visible: _isvisible,
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(83, 570, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignOrLog()),
                                    );
                                  },
                                  style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(160, 40)),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xffb22222))),
                                  child: const Text(
                                    'Get Started',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*  ElevatedButton(
                            //Login Button
                            onPressed: () {
                              Navigator.push(
                                this.context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 3,
                                fixedSize: const Size(270, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 252, 248, 248)),
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 57),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 150),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )
                              ],
                            )),*/
                        /*Slider Dots*/ Visibility(
                          visible: !_isvisible,
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Row(
                              children: List<Widget>.generate(
                                _pages.length,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: _activePage == index
                                        ? const Color(0xffb22222)
                                        : const Color.fromARGB(
                                            255, 180, 180, 180),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
