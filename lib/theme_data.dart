import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData green = ThemeData(
    buttonTheme: ButtonThemeData(buttonColor: Colors.green[900]),
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green.shade400);

ThemeData red = ThemeData(
    buttonTheme: ButtonThemeData(buttonColor: Colors.red[900]),
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.red.shade900);

//
class ThemeColorData with ChangeNotifier {
  //sharedPrefences ile cihaz üzerinde bilgiyi kalıcı saklama işi yaparız.
  // bize iki fonk lazım biri sharedprefences sınıfına gidip yazma yapacak.
  // diğer fonk ise yazılı veriyi okuma yapacak,

  //datayı bu sınıf tanımladığı için prefencesı da bu sınıfta tanımlayacağız.
  //boş bir prefences OBJESİ tanımlamak
  static SharedPreferences? _sharedPreferencesObject;
  //static olunca şu demek --> elimde bir sınıf var bundan hiç bir obje oluşturmasamda
  //kullanabileceğim bir örnek inctenceFile ver.
  ////............../////////////////////
  //yeşil mi kontrolü
  //bunu kullanarak temayı kırmızı veya yeşil olarak çevireceğiz.
  //yana kaydırmalı olan butonu aktif hale getirip bu fonk ile kullanacağız
  bool _isGreen = false;
  //bu üstteki değer private olduğu için başka sınıftan ulaşmak ve
  // kullanmak için get atamamız gerekiyor.
  bool get isGreen => _isGreen;

  //themdata döndüren bir getter -->themeColor adında
  ThemeData get themeColor {
    return _isGreen ? green : red;
  }

  //uygulamanın rengini değiştiren bir fonk
  void toogleTheme() {
    //true ise false - false ise true ya çevirmek
    _isGreen = !_isGreen;
    //bunu yaptıktan sonra bunu kendisini dinleyen herkese yayınlatmak
    notifyListeners();
    //kullanıcı kırmızdan yeşile-yeşilden kırmızıya tema değiştirdiği zaman çalışacak.
    // void saveThemeToSharedPrefences --- bu metod çağrılacak.
    saveThemeToSharedPrefences(_isGreen);
  }

  //bu objeyi başlatacak-insilaze edecek bir fonk oluşturmamız lazım
  // ki bunu geri kullanabilelim.
  Future<void> createSharedPrefencesObject() async {
    //bunu async-await olarak girdik çünkü
    //gidecek dosyayı bulacak açacak okuyacak ve bunlar zaman alacak.
    //future olarak tanımladık çünkü bu işlem asenkron olduğu için
    //uygulama ilk açıldığında da veri çektiğimiz için bu sıkıntı çıkarmaması için.

    _sharedPreferencesObject = await SharedPreferences.getInstance();
  }

  //yazıcı fonk.
  //temayı sharedprefences a kaydet.

  void saveThemeToSharedPrefences(bool value) {
    //bool değer kaydet --isGreen o an kki değeri
    _sharedPreferencesObject?.setBool("themeData", value);
  }

  //uygulama ilk yüklenirken hemen veriyi getirecek load fonk.
  void loadThemeFromSharePrefences() async {
    //load fonk ilk çalıştığı zaman kendine ihtiyacı olan veriyi ilk önce oluştursun.
    //artık alttaki koda gerek kalmadı çünkü runapp den önce bu kısımı tamamladık.
    //await createSharedPrefencesObject(); //bunun ilk oluşturmasını beklemek gerekiyor.
    _isGreen = _sharedPreferencesObject?.getBool("themeData") ?? true;

    /* yukarıda ki kontrol kodunun uzun hali
    if (_isGreen = _sharedPreferencesObject!.getBool("themeData") == null) {
      _isGreen = true;
    } else {
      / sonra veriyi çekip isGreen e atayacak
      _isGreen = _sharedPreferencesObject!.getBool("themeData")!;
    }
  
  */
  }
}
