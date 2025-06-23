import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/buttom_navigation_bar.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 14, height: 1.5);
    const boldStyle = TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 28.0,
              right: 28.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo/blinktalk.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                const SizedBox(height: 34),
                const Text(
                  'BlinkTalk adalah aplikasi inovatif yang dirancang untuk membantu komunikasi alternatif melalui deteksi kedipan mata. Dengan fokus utama pada membantu pengguna dengan keterbatasan bicara, BlinkTalk berkomitmen untuk mendukung komunikasi yang lebih mudah, inklusif, dan berdaya.',
                  style: textStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Misi Kami',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Memberikan solusi digital yang mempermudah komunikasi bagi penyandang disabilitas, serta mendorong inklusivitas melalui teknologi yang mudah diakses.',
                  style: textStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Fitur Utama',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '1. Deteksi Kedipan Mata\n',
                          style: boldStyle,
                        ),
                        TextSpan(
                          text:
                              'Dengan bantuan teknologi terkini, BlinkTalk memungkinkan pengguna berkomunikasi hanya dengan kedipan mata. Aplikasi ini mendeteksi pola kedipan dan menerjemahkannya menjadi perintah atau pesan.',
                          style: textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '2. Pesan Kustom\n', style: boldStyle),
                        TextSpan(
                          text:
                              'BlinkTalk memungkinkan pengguna membuat dan menyimpan pesan-pesan kustom untuk digunakan dalam situasi sehari-hari, sehingga komunikasi menjadi lebih personal dan efisien.',
                          style: textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '3. Integrasi Suara\n', style: boldStyle),
                        TextSpan(
                          text:
                              'Aplikasi ini dapat mengonversi teks hasil deteksi kedipan menjadi suara, membantu pengguna menyampaikan pesan mereka secara verbal kepada orang lain.',
                          style: textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '4. Antarmuka Ramah Pengguna\n',
                          style: boldStyle,
                        ),
                        TextSpan(
                          text:
                              'BlinkTalk dirancang dengan antarmuka yang sederhana, bersih, dan intuitif, sehingga mudah digunakan oleh siapa saja, termasuk mereka yang baru pertama kali mencoba.',
                          style: textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Mari bergabung dengan BlinkTalk untuk menciptakan masa depan komunikasi yang lebih inklusif dan berdaya! ',
                        ),
                        TextSpan(text: '✨', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
              top: 40,
              left: 10,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/user-history');
                },
                child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(19)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.manage_history),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'login history',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
