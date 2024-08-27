import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //bunu koyarsak runapp den önce
  //alttaki kodu çalıştırmaya izin veriyor.
  //bunu çalıştır ve bu olup bitene kadar her şeyi beklet.
  await ThemeColorData().createSharedPrefencesObject();
  runApp(
    //ChangeNotifierProvider-->yayın yapmak
    //themeColorData sınıfını yayın yapacak.
    ChangeNotifierProvider<ThemeColorData>(
      //yapacağın yayını yapmak içinde bir inctance lazım.
      // create: (BuildContext context) => ThemeColorData()
      // => bu sınıftan oluştur. (themeColorData sınıfından oluşturduk.)
      create: (BuildContext context) => ThemeColorData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //burada load theme ulaşacam
    //widget inşa olurken return dan önce bu bilgiyi gidip
    Provider.of<ThemeColorData>(context, listen: false)
        .loadThemeFromSharePrefences();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: --->burada bu yapılan yayını okuyacağız.
      theme: Provider.of<ThemeColorData>(context).themeColor,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Center(child: Text('Tema Seçimi')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              title: Provider.of<ThemeColorData>(context).isGreen
                  ? Text("Yeşil Tema")
                  : Text("Kırmızı Tema"),
              onChanged: (_) {
                //onChanged (_) --> bu parantez içine aldığımız değeri
                // scope lar içinde kullanmıyorsak
                //bu parantez içini boş olarak yani
                // _ olarak geçebiliriz.
                // parantez içi boş kalmaması gerektiği için _ bunu kullanıyoruz.
                Provider.of<ThemeColorData>(context, listen: false)
                    .toogleTheme();
              },
              //value --> ekranda true mu false mı olarak gözükmesini
              //listen --> false olmayacak çünkü dinleme yapmamız gerekiyor.
              value: Provider.of<ThemeColorData>(context).isGreen,
            ),
            Card(
              child: ListTile(
                title: Text("Yapılacaklar"),
                trailing: Icon(Icons.check_box),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              child: Text("Ekle"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
