import 'package:equatable/equatable.dart';


class ApiEvent extends Equatable{
  @override
  List<Object> get props => const [];

}


class RequestApi extends ApiEvent{
  final data;
  final type;

  RequestApi(this.data,this.type);

}

class ReloadApi extends ApiEvent{}

class StopApiRequest extends ApiEvent{}

class ViewApiData extends ApiEvent{
  final data;

  ViewApiData(this.data);
}
