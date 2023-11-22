import 'package:atlanta_task/DatabaseHelper/user_data_helper.dart';
import 'package:atlanta_task/Models/user_model_class.dart';
import 'package:atlanta_task/Resources/api_call.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final Util _util;
  UserDataHelper userDataHelper = UserDataHelper.instance;

  UserBloc(this._util) : super (UserLoadingState()){
    on<UserLoadEvent>((event, emit) async{
      emit(UserLoadingState());
      try {
        final users = await _util.getUserList();

        /// inserting api response to database
        final allRows = await userDataHelper.queryAllUserData();
        if(allRows.isEmpty){
          for (int i = 0; i < users.length; i++) {
            Map<String, dynamic> row = {
              UserDataHelper.userId: users[i].id,
              UserDataHelper.username: users[i].name,
              UserDataHelper.userEmail: users[i].email,
              UserDataHelper.phoneNumber: users[i].phone,
            };
            await userDataHelper.insertUserData(row);
          }
        }
        /// to fetch the users
        // final allRows = await userDataHelper.queryAllUserData();
        // print(allRows[0]);  // for fetching first user
        // users.forEach((user) {
        //   print('User: ${user.name}'); // for fetching all the users name
        // });

        emit(UserLoadedState(users));  // Note: I used api calling response rather than database values as it'll increase the app processing time
      }
      catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}