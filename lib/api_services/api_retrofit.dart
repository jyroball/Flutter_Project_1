import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_entity.dart';

part 'api_retrofit.g.dart';

@RestApi(baseUrl: "https://us-central1-bootcamp-dev-8f3ed.cloudfunctions.net")
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @POST("/registerUser")
  Future<dynamic> registerUser(@Body() UserEntity user);

  @GET("/getUsers")
  Future<dynamic> getUsers();

  @GET("/errorEndpoint")
  Future<void> triggerError();
}
