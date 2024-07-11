import 'package:flutter/material.dart';

class MailItem {
  final String nama;
  final String isi;
  final String kategori;
  final bool approved;

  MailItem({
    required this.nama,
    required this.isi,
    this.kategori = 'Personal',
    this.approved = false,
  });
}

class MailProvider with ChangeNotifier {
  List<MailItem> _mailss = [];

  List<MailItem> get mailss => _mailss;

  MailProvider() {
    // Add default mails
    _mailss = [
      MailItem(
        nama: 'Surat Selamat Ultah',
        isi: 'Selamat Ultah',
        kategori: 'Personal',
        approved: true,
      ),
      MailItem(
        nama: 'Surat izin',
        isi: 'Surat izin sakit karyawan A',
        kategori: 'Work',
        approved: false,
      ),
      MailItem(
        nama: 'Surat pengunduran diri',
        isi: 'Surat pengunduran diri karyawan B',
        kategori: 'Work',
        approved: false,
      ),
    ];
  }

  void addMail(MailItem mail) {
    _mailss.add(mail);
    notifyListeners();
  }

  void deleteMail(String nama) {
    _mailss.removeWhere((mail) => mail.nama == nama);
    notifyListeners();
  }
}
