import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:gift_memo/core/networks/network_info.dart';
import 'package:gift_memo/features/gift_memo/data/datasources/giftmemo_remotedata_source.dart';
import 'package:gift_memo/features/gift_memo/data/repos/giftmemo_repos_impl.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/add_gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/delete_gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/get_gift_memos.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/update_gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//features

//bloc
  sl.registerFactory(
    () => GiftMemoBloc(
        addGiftMemo: sl(),
        getGiftMemos: sl(),
        deleteGiftMemo: sl(),
        updateGiftMemo: sl()),
  );

//usecases
  sl.registerLazySingleton(() => AddGiftMemo(repos: sl()));
  sl.registerLazySingleton(() => GetGiftMemos(repos: sl()));
  sl.registerLazySingleton(() => UpdateGiftMemo(repos: sl()));
  sl.registerLazySingleton(() => DeleteGiftMemo(repos: sl()));

//repos
  sl.registerLazySingleton<GiftMemoRepos>(() =>
      GiftMemoReposImpl(networkInfo: sl(), giftMemoRemoteDataSource: sl()));
//datasources
  sl.registerLazySingleton<GiftMemoRemoteDataSource>(
      () => GiftMemoRemoteDataSourcesImpl());
  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //external
  final firebaseinit = await Firebase.initializeApp();
  sl.registerLazySingleton(() => firebaseinit);
}
