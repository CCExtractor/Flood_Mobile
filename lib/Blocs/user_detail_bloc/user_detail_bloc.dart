import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  String token = '';
  String username = '';
  List<CurrentUserDetailModel> usersList = [];

  UserDetailBloc() : super(UserDetailInitial()) {
    on<UserDetailEvent>(_handleUserDetailEvent);
    on<SetUserDetailsEvent>(_setUserDetails);
    on<SetUsersListEvent>(_setUsersList);
  }

  // Handle the UserDetailEvent
  void _handleUserDetailEvent(
      UserDetailEvent event, Emitter<UserDetailState> emit) {
    emit(UserDetailInitial());
  }

  // Set the user details (token and username)
  void _setUserDetails(
      SetUserDetailsEvent event, Emitter<UserDetailState> emit) {
    token = event.token;
    username = event.username;
    emit(UserDetailLoaded(
        token: token, username: username, usersList: usersList));
  }

  // Set the users list
  void _setUsersList(SetUsersListEvent event, Emitter<UserDetailState> emit) {
    usersList = event.usersList;
    emit(UserDetailLoaded(
        token: token, username: username, usersList: usersList));
  }
}
