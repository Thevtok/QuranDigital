import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_digital/view/ayat.dart';

import '../controller/api_controller.dart';

final ApiQuran controller = Get.put(ApiQuran());
const Color dark = Color.fromARGB(255, 66, 60, 41);
const Color light = Colors.white;
const Color primary = Color.fromARGB(255, 156, 119, 8);
const Color secondary = Color.fromARGB(255, 90, 69, 5);
const Gradient bgGradient = LinearGradient(
  colors: [Color.fromARGB(255, 156, 119, 8), Color.fromARGB(255, 90, 69, 5)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 254, 251),
        appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Text(
                'Quran App', // Teks menggunakan font Poppins sesuai dengan konfigurasi theme
                style: GoogleFonts.poppins(
                    fontSize: 20, // Ukuran font
                    fontWeight: FontWeight.bold,
                    color: primary)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: const Image(
              image: AssetImage('assets/Baner.png'),
              fit: BoxFit.cover,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: primary,
                  )),
            ]),
        body: Obx(() {
          if (controller.suratList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Assalamualaikum',
                      style: GoogleFonts.poppins(
                          fontSize: 20, // Ukuran font

                          color: dark)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Ya ahlul jannah',
                      style: GoogleFonts.poppins(
                          fontSize: 24, // Ukuran font
                          fontWeight: FontWeight.bold,
                          color: secondary)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            gradient: bgGradient,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Positioned(
                        top: -25,
                        right: 2,
                        child: Opacity(
                          opacity: 0.8,
                          child: Image(
                            image: const AssetImage('assets/book.png'),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 10,
                        child: Column(
                          children: [
                            Text('Bacaan Terakhir',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, // Ukuran font

                                    color: light)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Al-Fatihah',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, // Ukuran font
                                    fontWeight: FontWeight.bold,
                                    color: light)),
                            Text('Ayat No 1',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, // Ukuran font

                                    color: light))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(
                      child: Text('Surah',
                          style: GoogleFonts.poppins(
                              fontSize: 16, // Ukuran font

                              color: dark)),
                    ),
                    Tab(
                      child: Text('Deskripsi',
                          style: GoogleFonts.poppins(
                              fontSize: 16, // Ukuran font

                              color: dark)),
                    ),
                  ],
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: dark,
                        width: 2.0,
                      ),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                ),

                // Bagian bawah (TabBarView)
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                          itemCount: controller.suratList.length,
                          itemBuilder: (context, index) {
                            final surat = controller.suratList[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Get.to(() => AyatPage(
                                        surat: controller
                                            .findSuratByNomor(surat.nomor!)));
                                  },
                                  child: ListTile(
                                    leading: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage('assets/star.png'),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Text(
                                          surat.nomor.toString(),
                                          style: const TextStyle(color: dark),
                                        )
                                      ],
                                    ),
                                    title: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: dark,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: surat.namaLatin,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          TextSpan(
                                              text: ' (${surat.arti})',
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                        '${surat.tempatTurun}  ${surat.jumlahAyat} ayat',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: secondary)),
                                    trailing: Text(surat.nama!,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: primary)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          }),
                      const Center(child: Text('Konten Tab 2')),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
