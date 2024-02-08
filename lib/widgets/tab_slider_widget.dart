import 'package:audio_player/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/recommended_music_page.dart';

class TabSliderWidget extends StatefulWidget {
  const TabSliderWidget({Key? key}) : super(key: key);

  @override
  State<TabSliderWidget> createState() => _TabSliderWidgetState();
}

class _TabSliderWidgetState extends State<TabSliderWidget> {
  List<Widget> pages = [
    const RecentData(),
    const RecentData(),
    const RecentData(),
    const RecentData(),
    const RecentData(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  List<String> pageTitle = ["Recent", " Top 50", "Chill", "R&B", 'Festival'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60.h,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: pageTitle.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(left: 8.0.w, top: 20.w),
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                  onTap: () {
                    _onItemTapped(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        pageTitle[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: pageIndex == index
                                ? AppColors.white
                                : AppColors.lightGrey),
                      ),
                      pageIndex == index
                          ? Container(
                              width: 40.w,
                              height: 2,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                    Color(0xFFC22BB7),
                                    Color(0xFF922FF5)
                                  ])),
                            )
                          : const SizedBox(
                              height: 2,
                            )
                    ],
                  )),
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => pageIndex = index);
            },
            children: pages,
          ),
        ),
      ],
    );
  }
}

class RecentData extends StatelessWidget {
  const RecentData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(top: 20.h, left: 10 + 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecommendedMusicpage()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/music2.png'),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'R&B Playlist',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          fontSize: 18.sp),
                    ),
                    Text(
                      'Chill your mind',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightGrey,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ));
  }
}
