import 'dart:io';

// Kelas Kas untuk merepresentasikan transaksi kas
class Kas {
  String type; 
  String deskripsi; 
  double jumlah; 
  DateTime tanggal; 

  // Konstruktor untuk kelas Kas
  Kas(this.type, this.deskripsi, this.jumlah, this.tanggal);

  // Override method toString untuk representasi string dari objek Kas
  @override
  String toString() {
    return 'type: $type, Deskripsi: $deskripsi, Jumlah: $jumlah, Tanggal: $tanggal';
  }

  // Method untuk mengubah objek Kas menjadi format CSV
  List<dynamic> toCsv() {
    return [type, deskripsi, jumlah, tanggal];
  }
}

// Kelas ManajemenKas untuk mengelola daftar transaksi kas
class ManajemenKas {
  final List<Kas> _kasList = []; // Daftar transaksi kas

  // Method untuk menambah transaksi kas ke dalam daftar
  void tambahKas(Kas kas) {
    _kasList.add(kas);
  }

  // Method untuk melihat isi file CSV
  void melihatTransaksi(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) { // cek file
      print('File tidak ditemukan.');
      return;
    }
    print('Isi file CSV:');
    List<String> lines = file.readAsLinesSync(); // Baca semua baris dalam file
    for (var line in lines) {
      print(line); // Cetak setiap baris
    }
  }

  // Method untuk menyimpan daftar transaksi kas ke dalam file CSV
  void simpanKeCsv(String filePath) {
    final file = File(filePath);
    final sink = file.openWrite(mode: FileMode.append); // Buka file dalam mode append
    
    // sink.writeln('type,Deskripsi,Jumlah,Tanggal');   // Uncomment jika ingin menambahkan header CSV

    for (var kas in _kasList) {
      sink.writeln(kas.toCsv()); // menulis transaksi formatcsv
    }
    sink.close(); // Tutup sink
  }

  // Method untuk mencari transaksi berdasarkan deskripsi menggunakan sequential search
  void sequentialSearchByDescription(String filePath, String description) {
    final file = File(filePath);
    if (!file.existsSync()) { // Cek apakah file ada
      print('File tidak ditemukan.');
      return;
    }
    List<String> lines = file.readAsLinesSync(); // Baca semua baris dalam file
    bool found = false; // Flag untuk menandai apakah deskripsi ditemukan
    for (var line in lines) {
      if (line.contains(description)) { // Cek apakah baris mengandung deskripsi
        print('Data ditemukan: $line');
        found = true;
        // break; // uncomment jika hanya 1 data tampil
      }
    }
    if (!found) {
      print('Deskripsi tidak ditemukan dalam file.');
    }
  }
}


