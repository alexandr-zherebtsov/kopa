import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/core/bloc/user_register_bloc/user_register_event.dart';
import 'package:kopa/core/bloc/user_register_bloc/user_register_state.dart';
import 'package:kopa/data/database.dart';
import 'package:kopa/data/repositories/user_repositories.dart';
import 'package:kopa/domain/user.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {

  Database db;
  UserRepositories userRepositories;
  RegisterUserBloc(this.db) : super(RegisterInitialState());
  RegisterUserState get initialState => RegisterInitialState();

  @override
  Stream<RegisterUserState> mapEventToState(RegisterUserEvent event) async* {
    if (event is RegisterInitialEvent) {
      yield RegisterLoading();
      try{
        print("HERE");
        final userRef = await db.getUser();
        print("${userRef.exists}");
        if(userRef.exists)
          {
            yield RegisterSuccessState(User( name: userRef.data['name']?? '',
              surname: userRef.data['surname']?? '',
              city: userRef.data['city']?? '',
              phoneNumber: userRef.data['phoneNumber']?? 'Номер не вказаний',));}
       else{
         yield RegisterInitialState();
       }
      }
      catch(e){
        print(e.runtimeType);
        yield RegisterExceptionState(error: e.toString());
      }

        }
    if (event is RegisterCreateUser) {
        try{
          final currentUser = await UserRepositories().getCurrentUser();
          User userdb = User(name: event.name,
              surname: event.surname,
              phoneNumber: currentUser.phoneNumber == null ? 'Номер не вказано' : currentUser.phoneNumber,
              city: event.city);
          await db.createUser(userdb);
            yield RegisterSuccessState(userdb);
        }
        catch(e){
          yield RegisterExceptionState(error: e.toString());
        }

      }
    }

  Future<User> toUser(DocumentSnapshot documentSnapshot)async{
    return  await User(name: documentSnapshot.data['name'],
        city: documentSnapshot.data['city'],
        surname: documentSnapshot.data['surname'],
        phoneNumber: documentSnapshot.data['phoneNumber']);
  }
}


