void switchStatement() {
  final hari = 'Senin';

  switch (hari) {
    case 'Senin':
      print('Mulai kerja!');
      break;
    case 'Sabtu':
    case 'Minggu':
      print('Waktunya libur!');
      break;
    default:
      print('Hari biasa.');
  }
}

void switchExpression() {
  final hari = 'Sabtu';

  final pesan = switch (hari) {
    'Senin' => 'Mulai kerja!',
    'Sabtu' && 'Minggu' => 'Waktunya libur!',
    _ => 'Hari biasa.',
  };

  print(pesan);
}
