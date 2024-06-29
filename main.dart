import 'dart:io';
import 'kas.dart'; // Pastikan kas.dart sudah sesuai dengan struktur yang diinginkan

// Fungsi untuk menampilkan menu aplikasi
void tampilMenu() {
  print('=== Aplikasi manajemen kas ===');
  print('1. Input Transaksi');
  print('2. Lihat History Transaksi');
  print('3. Mencari Data');
  print('4. Keluar');
  print('Pilih menu (1/2/3/4): ');
}

void main() {
  int pilihan;
  var manajemenKas = ManajemenKas(); // Membuat instance dari kelas ManajemenKas

  while (true) {
    tampilMenu(); // Menampilkan menu
    pilihan = int.parse(stdin.readLineSync()!); // bagian untuk pilihan menu

    switch (pilihan) {
      case 1:
        try {
          // Input transaksi baru
          stdout.write('Masukkan tipe transaksi: ');
          String? type = stdin.readLineSync(); 
          stdout.write('Masukkan deskripsi transaksi: ');
          String? deskripsi = stdin.readLineSync(); 
          stdout.write('Masukkan jumlah transaksi: ');
          double? jumlah = double.parse(stdin.readLineSync()!); 

          // Membuat objek Kas baru dan menambahkannya ke manajemenKas
          var isi = Kas(type!, deskripsi!, jumlah, DateTime.now());
          manajemenKas.tambahKas(isi);

          manajemenKas.simpanKeCsv('kas.csv'); // Simpan transaksi ke file CSV
          print('Data telah disimpan');

        } on FormatException {
          // muncul jika salah input jumlah
          print('Input harus berupa angka untuk jumlah transaksi.');
        } catch (e) {
          // muncul jika ada kesalahan lainnya
          print('Terjadi error: $e');
        }
        break;
      case 2:
        // Menampilkan transaksi
        manajemenKas.melihatTransaksi('kas.csv');
        break;
      case 3:
        // Mencari data memakai deskripsi
        stdout.write('Masukkan deskripsi/nama yang ingin dicari: ');
        String? dicari = stdin.readLineSync();

        manajemenKas.sequentialSearchByDescription('kas.csv', '$dicari');
        break;
      case 4:       //case untuk keluar program
        print('Terima kasih telah menggunakan aplikasi.');
        exit(0);
      default:
        // Menangani pilihan yang tidak valid
        print('Pilihan tidak tersedia. Silakan coba lagi.');
    }

    // konfirmasi pengulangan program
    stdout.write('Ulangi program? (y/t): ');
    String? ulangiProgram = stdin.readLineSync();
    if (ulangiProgram?.toLowerCase() != 'y') {
      break; // Keluar dari loop jika pengguna memilih 't'
    }
  }
}
