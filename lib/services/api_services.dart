
import 'package:buyitnow/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiServices{
 final _dio = Dio(BaseOptions(
  baseUrl: 'http://127.0.0.1:5000/api/v1',
 ))..interceptors.add(PrettyDioLogger());


    Future<User?> register(String name,String email,String password) async {
    final prefs = await SharedPreferences.getInstance();
    Response response;
    response = await _dio.post('/auth/register',
    data: {
      "name" : name,
      "email" : email,
      "password" : password
    });
    if(response.statusCode==200){
      if(response.data['status'] == true){
        final user= User.fromJson(response.data['user']);
        prefs.setString("token", user.token);
        prefs.setString("id", user.id);
        prefs.setString("name", user.name);
      }
    }else{
      print('Falid');
    }
    print(response.statusCode);
    print(response.data.toString());

}
Future<User?> login(String email,String password) async {
    final prefs = await SharedPreferences.getInstance();
    Response response;
    response = await _dio.post('/auth/login',
    data: {
      "email" : email,
      "password" : password
    });
    if(response.statusCode==200){
      if(response.data['status'] == true){
        final user= User.fromJson(response.data['user']);
        prefs.setString("token", 'user.token');
        return user;
      }
    }else{
      print('Falid');
    }
    print(response.statusCode);
    print(response.data.toString());

}
}