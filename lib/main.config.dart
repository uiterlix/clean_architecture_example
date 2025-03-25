// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture_example/user/controller/user_controller.dart'
    as _i60;
import 'package:clean_architecture_example/user/datasource/user_datasource.dart'
    as _i372;
import 'package:clean_architecture_example/user/usecase/add_user_usecase.dart'
    as _i682;
import 'package:clean_architecture_example/user/usecase/delete_user_usecase.dart'
    as _i837;
import 'package:clean_architecture_example/user/usecase/get_users_usecase.dart'
    as _i638;
import 'package:clean_architecture_example/user/usecase/update_password_usecase.dart'
    as _i1051;
import 'package:clean_architecture_example/user/usecase/user_repository.dart'
    as _i830;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i830.UserRepository>(() => _i372.UserLocalDataSource());
    gh.singleton<_i638.GetUsers>(
        () => _i638.GetUsers(gh<_i830.UserRepository>()));
    gh.singleton<_i837.DeleteUser>(
        () => _i837.DeleteUser(gh<_i830.UserRepository>()));
    gh.singleton<_i682.AddUser>(
        () => _i682.AddUser(gh<_i830.UserRepository>()));
    gh.singleton<_i1051.UpdateUserPassword>(
        () => _i1051.UpdateUserPassword(gh<_i830.UserRepository>()));
    gh.singleton<_i60.UserController>(() => _i60.UserController(
          gh<_i682.AddUser>(),
          gh<_i638.GetUsers>(),
          gh<_i837.DeleteUser>(),
          gh<_i1051.UpdateUserPassword>(),
        ));
    return this;
  }
}
