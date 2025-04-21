void ifElseStatement() {
  int now = 17;

  if (now > 8 && now < 21) {
    print("Halo, kami sudah buka");
  } else {
    print("Maaf, kamu tutup");
  }
}

void conditionalExpression() {
  int now = 8;
  print(now > 8 && now < 21 ? "Halo, kami sudah buka" : "Maaf, kamu tutup");
}
