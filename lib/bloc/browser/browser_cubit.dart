import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserCubit extends Cubit<int>{
  BrowserCubit(int state) : super(state);

  setState(arg){
    this.emit(arg);
  }
}