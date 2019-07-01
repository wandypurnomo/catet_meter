class Pelanggan {
  final String id;
  final String kode;
  final String nama;
  final String status;

  Pelanggan({this.id, this.kode, this.nama, this.status});

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    print(json);
    return Pelanggan(
      id: json["id_pelanggan"],
      kode: json["kode_pelanggan"],
      nama: json["nama_pelanggan"],
      status: json["status_data"],
    );
  }
}

class DetailPelanggan {
  final String id;
  final String kode;
  final String nama;
  final String status;
  final String alamat;
  final String desa;
  final String kecamatan;
  final String golongan;
  final String wilayahKerja;
  final String tagihanBulanLalu;
  final String tagihanTahunLalu;
  final String angkaTerakhir;
  final String tagihanBayarTerakhir;
  final String kondisiMeteranTerakhir;

  DetailPelanggan({
    this.id,
    this.kode,
    this.nama,
    this.status,
    this.alamat,
    this.desa,
    this.kecamatan,
    this.golongan,
    this.wilayahKerja,
    this.tagihanBulanLalu,
    this.tagihanTahunLalu,
    this.angkaTerakhir,
    this.tagihanBayarTerakhir,
    this.kondisiMeteranTerakhir,
  });

  factory DetailPelanggan.fromJson(Map<String,dynamic> json){
    return DetailPelanggan(
      id: json["id_pelanggan"],
      kode: json["kode_pelanggan"],
      nama: json["nama_pelanggan"],
      status: json["status_pelanggan"],
      alamat: json["alamat"],
      desa: json["nama_desa"],
      kecamatan: json["nama_kecamatan"],
      golongan: json["nama_golongan"],
      wilayahKerja: json["wilayah_kerja"],
      tagihanBulanLalu: json["tagihan_bulan_lalu"],
      tagihanTahunLalu: json["tagihan_tahun_lalu"],
      angkaTerakhir: json["angka_terakhir"],
      tagihanBayarTerakhir: json["tagihan_bayar_terakhir"],
      kondisiMeteranTerakhir: json["kondisi_meteran_terakhir"],
    );
  }
}

class InputData{
  String kode;
  String wilayahKerja;
  String angkaAwal;
  String angkaAkhir;
  String latitude;
  String longitude;
  String statusMeteran;
  String fotoMeteran;

  toMap(){
    return {
      "kode_pelanggan":kode,
      "wilayah_kerja":wilayahKerja,
      "angka_awal":angkaAwal,
      "angka_akhir":angkaAkhir,
      "latitude":latitude,
      "longitude":longitude,
      "status_meteran":statusMeteran,
      "foto_meteran":fotoMeteran,
    };
  }
}
