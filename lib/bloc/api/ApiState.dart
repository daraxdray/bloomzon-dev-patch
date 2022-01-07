import 'package:equatable/equatable.dart';


class ApiState extends Equatable{
  @override
  List<Object> get props => const [];
}

class ApiInitials extends ApiState{}

class ApiRequesting extends ApiState{}

class NetworkFailure extends ApiState{}

class ApiFailed extends ApiState{
  final error;

  ApiFailed(this.error);
}

class ApiNotFound extends ApiState{}

class ApiSuccess extends ApiState{
  final data;
  ApiSuccess(this.data);
}

class ViewingApiData extends ApiState{
  final data;

  ViewingApiData(this.data);

}