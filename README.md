# BlinkTalk

**BlinkTalk** adalah aplikasi Flutter yang menggunakan **MediaPipe** untuk mendeteksi kedipan mata sebagai media komunikasi alternatif, khususnya untuk mendukung kelompok dengan keterbatasan bicara atau gerak.

## 🎯 Fitur Utama
- Deteksi kedipan mata real-time menggunakan kamera depan
- Konversi pola kedipan menjadi pesan komunikasi sederhana (misalnya: “Ya”, “Tidak”, “Butuh bantuan”)
- Output suara (Text-to-Speech) atau teks
- Penyimpanan riwayat pesan
- Pengaturan sensitivitas dan bahasa

## 🛠️ Teknologi
- Flutter
- MediaPipe (melalui integrasi native atau plugin Flutter)
- GetX (untuk state management)
- Text-to-Speech (TTS)
- Firebase (opsional, untuk penyimpanan cloud)

## 💻 Instalasi

1️⃣ Clone repositori:
```bash
git clone https://github.com/username/blinktalk.git
cd blinktalk

