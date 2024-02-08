import 'package:audio_player/constants/app_colors.dart';
import 'package:audio_player/pages/music_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedMusicpage extends StatefulWidget {
  const RecommendedMusicpage({super.key});

  @override
  State<RecommendedMusicpage> createState() => _RecommendedMusicpageState();
}

class _RecommendedMusicpageState extends State<RecommendedMusicpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
              AppColors.purple2,
              AppColors.purple1,
              AppColors.dark,
              AppColors.purple2
            ])),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 343.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/music2.png'))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  child: Column(children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                          ),
                        ),
                        const Icon(
                          Icons.more_horiz,
                          color: AppColors.white,
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'R&B Playlist',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                fontFamily: GoogleFonts.openSans().fontFamily,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              'Chill your mind',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.openSans().fontFamily,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.favorite_border,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MusicPage()));
                          },
                          child: Image.asset(
                            'assets/play_btn.png',
                            height: 56,
                            width: 56,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MusicPage()));
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
                          )),
                )
              ],
            ),
            // Container(
            //   height: 343.h,
            //   decoration: BoxDecoration(
            //       borderRadius: const BorderRadius.only(
            //           bottomLeft: Radius.circular(
            //             24,
            //           ),
            //           bottomRight: Radius.circular(24)),
            //       gradient: LinearGradient(
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //           colors: [
            //             const Color(0xff000000),
            //             const Color(0x00000000).withOpacity(0),
            //             const Color(0x00000000).withOpacity(0),
            //             const Color(0xff000000),
            //           ])),
            // )
          ],
        ),
      ),
    );
  }
}
