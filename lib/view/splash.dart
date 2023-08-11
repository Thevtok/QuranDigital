import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_digital/view/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double paddingHeight = screenHeight * 0.04;
    double paddingTop = screenHeight * 0.08;
    double paddingWidth = screenWidth * 0.2;
    Future.delayed(const Duration(seconds: 4), () {
      // Navigasi ke halaman berikutnya setelah splash screen selesai
      Get.off(
          const HomePage()); // Ganti '/home' dengan nama rute halaman berikutnya
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/splashqu.png'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.only(top: paddingTop),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Quran App', // Teks menggunakan font Poppins sesuai
                style: GoogleFonts.poppins(
                    fontSize: 20, // Ukuran font
                    fontWeight: FontWeight.bold,
                    color: primary),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                paddingWidth, 0, paddingWidth, paddingHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '"Dan sesungguhnya Kami telah mendatangkan sebuah Kitab (Al Quran) kepada mereka yang Kami telah menjelaskannya atas dasar pengetahuan Kami; menjadi petunjuk dan rahmat bagi orang-orang yang beriman."', // Teks menggunakan font Poppins sesuai dengan konfigurasi theme
                style: GoogleFonts.poppins(
                  fontSize: 14, // Ukuran font

                  fontStyle:
                      FontStyle.italic, // Gaya font (misalnya: normal, italic)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
