import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_app/functions/firebase/firestore.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/screens/home/desktop.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetFamilyuserDetails>(_getFamilyuserDetails);
  }

  _getFamilyuserDetails(
      GetFamilyuserDetails event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    List<UserModel>? users = await FireStoreRepository().getAllusers();
    List<FamilyModel> family = await FireStoreRepository().getAllFamilys();
    if (users.isNotEmpty || family.isNotEmpty) {
      usersCount = users.length;
      familyCount = family.length;
      return emit(UsersFamilysDetailsLoaded(users: users, familys: family));
    } else {
      return emit(ErrorState(err: 'no users found'));
    }
  }
}
