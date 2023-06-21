class Seker {
  final int id;
  final String isim;
  final String aciklama;
  final int fiyat;

  Seker({required this.id, required this.isim, required this.aciklama, required this.fiyat});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isim': isim,
      'aciklama': aciklama,
      'fiyat': fiyat,
    };
  }

// Implement toString to make it easier to see information about
// each dog when using the print statement.
  @override
  String toString() {
    return 'Seker{id: $id, isim: $isim, aciklama: $aciklama, fiyat: $fiyat}';
  }
}