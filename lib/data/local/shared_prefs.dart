import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  Future<bool> getTema() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool temaOscuro = (prefs.getBool('tema_oscuro') ?? false);
    print('maxanime: obteniendo tema${temaOscuro}');
    return temaOscuro;
  }

  void setTema(modoOscuro) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tema_oscuro', modoOscuro);
    print('maxanime: seteando tema${modoOscuro}');
  }
}