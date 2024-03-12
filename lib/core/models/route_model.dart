import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
class RouteModel with _$RouteModel {
  factory RouteModel({
    required String path,
    required String name,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
}
