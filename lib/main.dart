import 'package:cosmos/cosmos.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FirebaseEgitimleri());
}

class FirebaseEgitimleri extends StatelessWidget {
  const FirebaseEgitimleri({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopluVeriCekme(),
    );
  }
}

class TopluVeriCekme extends StatefulWidget {
  const TopluVeriCekme({super.key});

  @override
  State<TopluVeriCekme> createState() => _TopluVeriCekmeState();
}

class _TopluVeriCekmeState extends State<TopluVeriCekme> {
  String veriler = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(veriler),
              const SizedBox(height: 8),
              CosmosButton.button(
                text: "Veri AL",
                onTap: () async {
                  List ogrenci = await CosmosFirebase.getOnce('ogrenci');
                  for (var element in ogrenci) {
                    veriler = "${veriler + element[element.length - 1]}\n";
                  }
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VeriCekme extends StatefulWidget {
  const VeriCekme({super.key});

  @override
  State<VeriCekme> createState() => _VeriCekmeState();
}

class _VeriCekmeState extends State<VeriCekme> {
  TextEditingController veriKutusu = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CosmosTextBox(
                "Verinin Bilgisi",
                controller: veriKutusu,
              ),
              const SizedBox(height: 8),
              CosmosButton.button(
                text: "Veri AL",
                onTap: () async {
                  List ogrenci = await CosmosFirebase.get(
                      'ogrenci/"29032024043011"', true);

                  veriKutusu.text = ogrenci[0].toString();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VeriEkleme extends StatefulWidget {
  const VeriEkleme({super.key});

  @override
  State<VeriEkleme> createState() => _VeriEklemeState();
}

class _VeriEklemeState extends State<VeriEkleme> {
  TextEditingController veriKutusu = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CosmosTextBox(
                "Verinin Bilgisi",
                controller: veriKutusu,
              ),
              const SizedBox(height: 8),
              CosmosButton.button(
                text: "Veri Ekle",
                onTap: () async {
                  try {
                    await CosmosFirebase.add(
                      reference: "ogrenci",
                      tag: CosmosRandom.randomTag(),
                      value: [
                        veriKutusu.text,
                      ],
                    ).then(
                      (value) {
                        veriKutusu.clear();
                        CosmosAlert.showMessage(
                          context,
                          "Başarılı",
                          "Veri Eklendi.",
                        );
                      },
                    );
                  } catch (error) {
                    CosmosAlert.showMessage(
                      // ignore: use_build_context_synchronously
                      context,
                      "Hata",
                      error.toString(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CosmosTextBox(
                "Eposta",
                controller: email,
              ),
              const SizedBox(height: 8),
              CosmosTextBox(
                "Parola",
                controller: password,
              ),
              const SizedBox(height: 8),
              CosmosButton.button(
                text: "Giriş Yap",
                onTap: () async {
                  await CosmosFirebase.signIn(
                    email: email.text,
                    password: password.text,
                    trError: true,
                    onError: (error) {
                      CosmosAlert.showMessage(context, "HATA", error);
                    },
                    onSuccess: () {
                      CosmosAlert.showMessage(context, "Başarılı",
                          "Giriş başarılı bir şekilde yapıldı.");
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CosmosTextBox(
                "Eposta",
                controller: email,
              ),
              const SizedBox(height: 8),
              CosmosTextBox(
                "Parola",
                controller: password,
              ),
              const SizedBox(height: 8),
              CosmosButton.button(
                text: "Kayıt Ol",
                onTap: () async {
                  await CosmosFirebase.signUp(
                    email: email.text,
                    password: password.text,
                    //USERDATAS: firebase realtime database'e gider.
                    userDatas: [
                      email.text,
                      password.text,
                    ],
                    trError: true,
                    onError: (error) {
                      CosmosAlert.showMessage(context, "HATA", error);
                    },
                    onSuccess: () {
                      CosmosAlert.showMessage(
                          context, "BAŞARI", "Başarıyla kayıt olundu.");
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
