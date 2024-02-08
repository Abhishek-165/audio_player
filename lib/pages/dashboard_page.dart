import 'package:audio_player/constants/app_colors.dart';
import 'package:audio_player/pages/recommended_music_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/tab_slider_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              AppColors.dark,
              AppColors.purple2,
              AppColors.purple2,
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h + MediaQuery.of(context).viewPadding.top,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'What do you feel like today?',
                  style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 60.h,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.lightGrey,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Search song, playslist, artist...',
                      style: TextStyle(
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightGrey,
                          fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(height: 400.h, child: const TabSliderWidget()),
              Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "Your favourites",
                    style: TextStyle(
                        fontFamily: GoogleFonts.openSans().fontFamily,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: 18.sp),
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RecommendedMusicpage()));
                        },
                        child: ListTile(
                          leading: Container(
                            height: 56,
                            width: 56,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/music2.png')),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          title: Text(
                            'You Right',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: 18.sp,
                              fontFamily: GoogleFonts.openSans().fontFamily,
                            ),
                          ),
                          subtitle: Text(
                            'Doja Cat, The Weeknd',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightGrey,
                              fontSize: 14.sp,
                              fontFamily: GoogleFonts.openSans().fontFamily,
                            ),
                          ),
                          trailing: Text(
                            '3:58',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: AppColors.white,
                              fontFamily: GoogleFonts.openSans().fontFamily,
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
