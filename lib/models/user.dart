class User {
  final String id;
  final String nama;
  final String kecamatan;
  final String kabupaten;
  final String totalPelanggan;
  final String telahDicatat;
  final String progressCatat;

  User({
    this.id,
    this.nama,
    this.kecamatan,
    this.kabupaten,
    this.progressCatat,
    this.telahDicatat,
    this.totalPelanggan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json["nama_petugas"],
      kecamatan: json["kecamatan_tugas"],
      kabupaten: json["kabupaten_tugas"],
      totalPelanggan: json["total_pelanggan"],
      telahDicatat: json["telah_dicatat"],
      progressCatat: json["progress_catat"],
    );
  }
}
