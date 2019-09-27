class User {
  final String id;
  final String nama;
  final String wilayah;
  final String totalPelanggan;
  final String telahDicatat;
  final String progressCatat;

  User({
    this.id,
    this.nama,
    this.wilayah,
    this.progressCatat,
    this.telahDicatat,
    this.totalPelanggan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json["nama_petugas"],
      wilayah: json["wilayah_tugas"],
      totalPelanggan: json["total_pelanggan"],
      telahDicatat: json["telah_dicatat"],
      progressCatat: json["progress_catat"],
    );
  }
}
