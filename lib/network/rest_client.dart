import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:todo_mobile/models/task_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://my-json-server.typicode.com/wsh-startup/mock-api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<TaskModel>> getTasks();

  @PUT("/tasks/{id}")
  Future<TaskModel> updateTask(@Path() String id, @Body() TaskModel task);

  @POST("/tasks")
  Future<TaskModel> addTask(@Body() TaskModel task);

  @DELETE("/tasks/{id}")
  Future<void> deleteTask(@Path() String id);

  @GET("/tasks/{id}")
  Future<TaskModel> getTask(@Path("id") String id);
}
