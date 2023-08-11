import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/api_controller.dart';
import '../model/surat.dart';
import 'home_page.dart';

class AyatPage extends StatelessWidget {
  final Surat surat; // Terima objek Surat dari halaman sebelumnya

  const AyatPage({Key? key, required this.surat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiQuran>();

    controller.fetchAyatData(surat.nomor!);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(surat.namaLatin!,
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage('assets/Baner.png'),
          fit: BoxFit.cover,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: secondary,
            )),
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        gradient: bgGradient,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(surat.namaLatin!,
                            style: GoogleFonts.poppins(
                                fontSize: 22, color: light)),
                        Text(surat.arti!,
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: light)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${surat.tempatTurun} - ${surat.jumlahAyat} ayat',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: light)),
                        Text('بسم الله الرحمن الرحيم',
                            style: GoogleFonts.poppins(
                                fontSize: 24, color: light)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Play Audio',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: light)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await controller.playAudioFromAyat(
                                          surat, '01');
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: light,
                                      size: 50,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.pauseAudio();
                                    },
                                    icon: const Icon(
                                      Icons.pause,
                                      color: light,
                                      size: 50,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      controller.stopAudio();
                                    },
                                    icon: const Icon(
                                      Icons.stop,
                                      color: light,
                                      size: 50,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 2,
                    child: Opacity(
                      opacity: 0.8,
                      child: Opacity(
                        opacity: 0.15,
                        child: Image(
                          image: const AssetImage('assets/book.png'),
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.ayatList.length,
                itemBuilder: (context, index) {
                  final ayat = controller.ayatList[index];
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primary // Warna lingkaran
                                  ),
                              child: Center(
                                child: Text(
                                  ayat.nomorAyat
                                      .toString(), // Nomor ayat di tengah lingkaran
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.play_arrow_outlined,
                                  color: primary,
                                ), // Contoh ikon pertama
                                SizedBox(width: 10),
                                Icon(
                                  Icons.pause,
                                  color: primary,
                                ), // Contoh ikon kedua
                                SizedBox(width: 10),
                                Icon(
                                  Icons.bookmark_outline_outlined,
                                  color: primary,
                                ), // Contoh ikon ketiga
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ayat.teksArab,
                            style:
                                GoogleFonts.poppins(fontSize: 23, color: dark),
                            softWrap: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ayat.teksIndonesia,
                            style:
                                GoogleFonts.poppins(fontSize: 18, color: dark),
                            softWrap: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
