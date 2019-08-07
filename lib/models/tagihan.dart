class Tagihan {
  final String tagihanBulanan;
  final String tagihanTahunan;

  final String jumlahPemakaian;

  final String biaya010;
  final String biaya1020;
  final String biaya2030;
  final String biayaUp30;
  final String biayaTetap;
  final String biayaAdmin;
  final String biayaPelayananAirKotor;
  final String biayaPemakaian;
  final String totalTagihan;
  final String kondisiMeteranTerakhir;
  final String statusTagihan;

  Tagihan({
    this.tagihanBulanan,
    this.tagihanTahunan,
    this.jumlahPemakaian,
    this.biaya010,
    this.biaya1020,
    this.biaya2030,
    this.biayaUp30,
    this.biayaTetap,
    this.biayaAdmin,
    this.biayaPelayananAirKotor,
    this.biayaPemakaian,
    this.totalTagihan,
    this.kondisiMeteranTerakhir,
    this.statusTagihan,
  });

  factory Tagihan.fromJson(Map<String, dynamic> json) {
    return Tagihan(
      tagihanBulanan: json["tagihan_bulanan"],
      tagihanTahunan: json["tagihan_tahunan"],
      jumlahPemakaian: json["jumlah_pemakaian"],
      biaya010: json["biaya_0_10"],
      biaya1020: json["biaya_10_20"],
      biaya2030: json["biaya_20_30"],
      biayaUp30: json["biaya_up_30"],
      biayaTetap: json["biaya_tetap"],
      biayaAdmin: json["biaya_admin"],
      biayaPelayananAirKotor: json["biaya_pelayanan_airkotor"],
      biayaPemakaian: json["biaya_pemakaian"],
      totalTagihan: json["total_tagihan"],
      kondisiMeteranTerakhir: json["kondisi_meteran_terakhir"],
      statusTagihan: json["status_tagihan"],
    );
  }
}

class DetailTagihan {
  final String id;
  final String kode;
  final String nama;
  final String status;
  final String alamat;
  final String desa;
  final String kecamatan;
  final String golongan;
  final List<Tagihan> tagihan;

  DetailTagihan({
    this.id,
    this.kode,
    this.nama,
    this.status,
    this.alamat,
    this.desa,
    this.kecamatan,
    this.golongan,
    this.tagihan,
  });

  factory DetailTagihan.fromJson(Map<String, dynamic> json) {
    final t = json["data"].map<Tagihan>((json) => Tagihan.fromJson(json)).toList();

    return DetailTagihan(
      id: json["id_pelanggan"],
      kode: json["kode_pelanggan"],
      nama: json["nama_pelanggan"],
      status: json["status_pelanggan"],
      alamat: json["alamat"],
      desa: json["nama_desa"],
      kecamatan: json["nama_kecamatan"],
      golongan: json["nama_golongan"],
      tagihan: t,
    );
  }
}
