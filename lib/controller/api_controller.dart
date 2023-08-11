import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/ayat.dart';
import '../model/surat.dart';

class ApiQuran extends GetxController {
  final Dio _dio = Dio();
  final AudioPlayer audioPlayer = AudioPlayer();
  final _suratList = <Surat>[].obs;
  final _ayatList = <Ayat>[].obs;

  List<Surat> get suratList => _suratList;
  List<Ayat> get ayatList => _ayatList;

  @override
  void onInit() {
    super.onInit();
    fetchSuratData();
  }

  Future<void> playAudioFromAyat(Surat surat, String audioNumber) async {
    String? audioUrl = surat.getAudioUrl(audioNumber);
    if (audioUrl != null) {
      await audioPlayer.play(UrlSource(audioUrl));

      print('Audio dimainkan');
      print(audioUrl);
    } else {
      print("Audio URL tidak ditemukan untuk nomor '$audioNumber'");
    }
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  Future<void> fetchSuratData() async {
    try {
      final response = await _dio.get('https://equran.id/api/v2/surat');

      if (response.statusCode == 200) {
        final data = response.data;
        List<Surat> suratList = [];

        for (var suratJson in data['data']) {
          suratList.add(Surat.fromJson(suratJson));
        }

        _suratList.assignAll(suratList);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAyatData(int nomor) async {
    try {
      final response = await _dio.get('https://equran.id/api/v2/surat/$nomor');

      if (response.statusCode == 200) {
        final data = response.data['data']; // Dapatkan data ayat dari 'data'
        List<Ayat> ayatList = [];

        for (var ayatJson in data['ayat']) {
          // Akses array 'ayat' di dalam 'data'
          ayatList.add(Ayat.fromJson(ayatJson));
        }

        _ayatList.assignAll(ayatList);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data');
    }
  }

  Surat findSuratByNomor(int nomorSurat) {
    return _suratList.firstWhere((surat) => surat.nomor == nomorSurat,
        orElse: () => Surat());
  }
}
