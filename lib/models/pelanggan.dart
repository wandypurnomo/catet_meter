class Pelanggan {
  final String id;
  final String kode;
  final String nama;
  final String status;
  final String flag;
  final String lat;
  final String lng;

  Pelanggan({this.id, this.kode, this.nama, this.status,this.flag,this.lat,this.lng});

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    print(json);
    return Pelanggan(
      id: json["id_pelanggan"],
      kode: json["kode_pelanggan"],
      nama: json["nama_pelanggan"],
      status: json["status_data"],
      flag: json["flag"],
      lat: json["latitude"],
      lng: json["longitude"],
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
  final String kondisiMeteranTerakhir;
  final String lat;
  final String lng;

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
    this.kondisiMeteranTerakhir,
    this.lat,
    this.lng,
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
      kondisiMeteranTerakhir: json["kondisi_meteran_terakhir"],
      lat: json["latitude"],
      lng: json["longitude"],
    );
  }
}

class InputData{
  String kode;
  String angkaAwal;
  String angkaAkhir;
  String statusMeteran;
  String fotoMeteran;
  String latitude;
  String longitude;

  toMap(){
    return {
      "kode_pelanggan":kode,
      "angka_awal":angkaAwal,
      "angka_akhir":angkaAkhir,
      "status_meteran":statusMeteran,
      "foto_meteran":fotoMeteran,
      "latitude":latitude,
      "longitude":longitude,
    };
  }
}
