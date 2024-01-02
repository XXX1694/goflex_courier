import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/profile/data/models/profile_model.dart';
import 'package:goflex_courier/features/profile/data/repositories/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repo;
  ProfileBloc({
    required this.repo,
    required ProfileState profileState,
  }) : super(ProfileInitial()) {
    on<GetProfile>(
      (event, emit) async {
        emit(GettingProfile());
        try {
          ProfileModel? res = await repo.getProfile();
          if (res != null) {
            emit(GotProfile(profile: res));
          } else {
            emit(
              GotProfile(
                profile: ProfileModel(
                  user: {
                    "phone": "+77777777777",
                  },
                  email: 'пусто',
                  first_name: 'Пусто',
                  id: 1,
                  iin: 'пусто',
                  image: '',
                  last_name: 'Пусто',
                  works: false,
                  deliveries: 0,
                  earnings: 0,
                ),
              ),
            );
            // emit(GetProfileError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(GetProfileError());
        }
      },
    );
  }
}
