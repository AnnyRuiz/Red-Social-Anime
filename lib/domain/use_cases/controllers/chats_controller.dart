import 'package:get/get.dart';
import 'package:max_anime/ui/widges/chat_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication_controller.dart';

class ChatsController extends GetxController{

  final _listChats = [ChatRow(pathImage: '', nombre: '', ultima_conexion: '', chat_visto: false,listener_id: '',)].obs;
  final _listUsers = [ChatRow(pathImage: '', nombre: '', ultima_conexion: '', chat_visto: false,listener_id: '',)].obs;
  List<ChatRow> get listChats => _listChats;
  List<ChatRow> get listUsers => _listUsers;
  List<Map> chatsData = [];
  static List<String> listaListeners = [];

//--------------------------------------------------------------------------------------------------------
//------------------------------------------------OBTENER LAS SALAS---------------------------------------
//--------------------------------------------------------------------------------------------------------
  Future<bool> getSalas() async{
    _listChats.clear();
    chatsData.clear();
    listaListeners.clear();
    try{
      String uid = AuthController.uid;
      CollectionReference interactions = await FirebaseFirestore.instance.collection('interactions');
      CollectionReference users = await FirebaseFirestore.instance.collection('users');

      await interactions.orderBy('last_change',descending: true).where('user_id', isEqualTo: uid).get()
          .then((QuerySnapshot querySnapshot){
            querySnapshot.docs.forEach((docu) async{
              //print('maxanime: tipo de variable timestamp: ${docu['last_change'].runtimeType} ${docu['user_id']}');

              Timestamp last_change = docu['last_change'];
              Timestamp last_seen = docu['last_seen'];
              bool visto = true;

              if(last_change.compareTo(last_seen)>0){
                visto = false;
              }
              chatsData.add({'sala_id':docu['sala_id'], 'visto':visto});
            });
          });

      //print('maxanime: Obteneindo datos de chats en chatcontroller');
      for(final chat in chatsData){

        String sala_id = chat['sala_id'];

        await interactions.where('sala_id', isEqualTo: sala_id).where('user_id', isNotEqualTo: uid ).get()
            .then((QuerySnapshot querySnapshot){
              querySnapshot.docs.forEach((docu) async{
                chat['listener_id']= docu['user_id'];
              });
            });

        String uid_listener = await chat['listener_id'];
        listaListeners.add(uid_listener);

        await users.doc(uid_listener).get()
            .then((DocumentSnapshot snapshot){
              if(snapshot.exists){
                chat['nombre'] = '${snapshot['name']} ${snapshot['last_name']}';
                chat['path_image'] = snapshot.get('path_image');
                Timestamp last_connected = snapshot['last_connected'];
                DateTime now = DateTime.now();
                chat['last_connected'] = calcularDiferencia(now,last_connected.toDate());
              }
            });

        _listChats.add(
            ChatRow(
              pathImage: chat['path_image'],
              nombre: chat['nombre'],
              ultima_conexion: chat['last_connected'],
              chat_visto: chat['visto'],
              interaction_id: sala_id,
              listener_id: uid_listener,
            ));

      }

      //print('maxanime: la lista de posts en feed es 2: $postsData');*/
      return true;

    }catch(e){
      print('maxanime: error en chats controller getchats  $e }');
      return false;
    }
  }

//--------------------------------------------------------------------------------------------------------
//--------------------------------------CALCULAR DIFERENCIA DE FECHAS------------------------------------
//--------------------------------------------------------------------------------------------------------

  String calcularDiferencia(DateTime fecha1, DateTime fecha2){
    String mensaje = '';
    int diferencia = fecha1.difference(fecha2).inMinutes;
    if(diferencia>60){
      diferencia = fecha1.difference(fecha2).inHours;
      if(diferencia>24) {
        mensaje = 'hace mas de un dia';
      }else{
        mensaje = 'hace $diferencia horas';
      }
    }else{
      if(diferencia < 1){
        mensaje = 'ahora';
      }else {
        mensaje = 'hace $diferencia minutos';
      }
    }
    return mensaje;
  }

//--------------------------------------------------------------------------------------------------------
//---------------------------------------ACTUALIZAR ULTIMA CONEXION DE CHATS---------------------------------
//--------------------------------------------------------------------------------------------------------

  void actualizarUltimaConexion() async{
    String uid = AuthController.uid;
    CollectionReference users = await FirebaseFirestore.instance.collection('users');
    await users.doc(uid).update({
      'last_connected': DateTime.now()
    });
  }
//--------------------------------------------------------------------------------------------------------
//--------------------------------------CREAR UNA NUEVA CONVERSACION--------------------------------------
//--------------------------------------------------------------------------------------------------------

  Future<bool> newConversation() async{

    _listUsers.clear();
    try{
      String uid = AuthController.uid;
      CollectionReference users = await FirebaseFirestore.instance.collection('users');

      await users.get()
          .then((QuerySnapshot querySnapshot){
            querySnapshot.docs.forEach((docu) async {
              //print('maxanime: encontre user y relleno con datos ${docu.data()}');
              if(docu.id != uid && !listaListeners.contains(docu.id)){
                var nombre = '${docu['name']} ${docu['last_name']}';
                Timestamp last_connected = docu['last_connected'];
                DateTime now = DateTime.now();
                var lasConnected = calcularDiferencia(now,last_connected.toDate());

                _listUsers.add(
                    ChatRow(pathImage: docu['path_image'],
                      nombre: nombre, ultima_conexion:
                      lasConnected,
                      chat_visto: true,
                      listener_id: docu.id,
                    ));
              }
            });
          });

      return true;

    }catch(e){
      print('maxanime: error en chats controler nuevo chat  $e }');
      return false;
    }
  }

//--------------------------------------------------------------------------------------------------------
//----------------------------------------ENVIAR MENSAJES-------------------------------------------------
//--------------------------------------------------------------------------------------------------------

  Future<String> sendMessage(String interaction_id, String listener_id, String mensaje) async{
    CollectionReference salas = await FirebaseFirestore.instance.collection('salas');
    CollectionReference interactions = await FirebaseFirestore.instance.collection('interactions');
    CollectionReference mensajes = await FirebaseFirestore.instance.collection('mensajes');
    String uid = AuthController.uid;

    if(interaction_id == ""){
      try {
        String sala_id = '';
        await salas.add({'sala_id':''}).then((value) => sala_id = value.id);
        print('maxanime: entre e intente agregar sala');
        await interactions.add({
          'last_change': DateTime.now(),
          'last_seen': DateTime.now(),
          'sala_id': sala_id,
          'user_id': uid
        });
        await interactions.add({
          'last_change': DateTime.now(),
          'last_seen': DateTime.now(),
          'sala_id': sala_id,
          'user_id': listener_id
        });

        await mensajes.add({
          'date':DateTime.now(),
          'mensaje': mensaje,
          'sala_id': sala_id,
          'user_id': uid
        });

        return sala_id;

      }catch(e){
        print('maxanime: error en chatscontroller al agregar nueva interaccion: $e');
      }
    }else {
      try {
        await mensajes.add({
          'date': DateTime.now(),
          'mensaje': mensaje,
          'sala_id': interaction_id,
          'user_id': uid
        });

        await interactions.where('sala_id', isEqualTo: interaction_id).get().then((QuerySnapshot querySnapshot){
          querySnapshot.docs.forEach((docu) async{
            await interactions.doc(docu.id).update({'last_change': DateTime.now()});
          });
        });
      }catch(e){
        print('maxanime: Error al agregar mensaje: $e');
      }
    }
    return '';
  }

//-------------------------------GUARDAR LAST SEEN---------------------------------

  void guardarLastSeen(String sala_id) async{
    CollectionReference interactions = await FirebaseFirestore.instance.collection('interactions');
    String uid = AuthController.uid;
    try {
      print('maxanime: deberia actalizar last seen');
      await interactions.where('sala_id', isEqualTo: sala_id).get().then((QuerySnapshot querySnapshot){
        querySnapshot.docs.forEach((docu) async{
          if(docu['user_id'] == uid){
            await interactions.doc(docu.id).update({'last_seen':DateTime.now()});
          }
        });
      });
    }catch(e){
      print('maxanime: error al actulizar lastseen: $e');
    }
  }

}