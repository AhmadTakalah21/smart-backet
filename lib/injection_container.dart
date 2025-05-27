import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/layers/bloc/add_bill/add_bill_cubit.dart';
import 'package:fresh_shelf/layers/bloc/address/address_cubit.dart';
import 'package:fresh_shelf/layers/bloc/auth/auth_cubit.dart';
import 'package:fresh_shelf/layers/bloc/bill_detail/bill_detail_cubit.dart';
import 'package:fresh_shelf/layers/bloc/category/category_cubit.dart';
import 'package:fresh_shelf/layers/bloc/get_bills/get_bills_cubit.dart';
import 'package:fresh_shelf/layers/bloc/product/product_cubit.dart';
import 'package:fresh_shelf/layers/data/data_provider/address_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/auth_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/bill_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/cart_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/category_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/product_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/wishlist_provider.dart';
import 'package:fresh_shelf/layers/data/repository/address_repository.dart';
import 'package:fresh_shelf/layers/data/repository/auth_repository.dart';
import 'package:fresh_shelf/layers/data/repository/bill_repository.dart';
import 'package:fresh_shelf/layers/data/repository/cart_repository.dart';
import 'package:fresh_shelf/layers/data/repository/category_repository.dart';
import 'package:fresh_shelf/layers/data/repository/product_repository.dart';
import 'package:fresh_shelf/layers/data/repository/wishlist_repository.dart';
import 'package:get_it/get_it.dart';

import 'core/dio/factory.dart';
import 'l10n/local_provider.dart';
import 'layers/bloc/sub_category/sub_category_cubit.dart';

final sl = GetIt.instance;

void initInjection() {
  sl.registerLazySingleton(() => DioFactory.create());

  //cubit
  sl.registerLazySingleton(() => AuthCubit());
  sl.registerLazySingleton(() => CategoryCubit());
  sl.registerLazySingleton(() => SubCategoryCubit());
  sl.registerLazySingleton(() => ProductCubit());
  sl.registerLazySingleton(() => AddressCubit());
  sl.registerLazySingleton(() => AddBillCubit());
  sl.registerLazySingleton(() => GetBillsCubit());
  sl.registerLazySingleton(() => BillDetailCubit());

  //Provider
  sl.registerLazySingleton(() => LocaleProvider());
  sl.registerLazySingleton(() => AppState());

  //data_provider
  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton(() => CategoryProvider());
  sl.registerLazySingleton(() => ProductProvider());
  sl.registerLazySingleton(() => WishListProvider());
  sl.registerLazySingleton(() => CartProvider());
  sl.registerLazySingleton(() => AddressProvider());
  sl.registerLazySingleton(() => BillProvider());

  //repos
  sl.registerLazySingleton(() => AuthRepository(sl()));
  sl.registerLazySingleton(() => CategoryRepository(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() => WishListRepository(sl()));
  sl.registerLazySingleton(() => CartRepository(sl()));
  sl.registerLazySingleton(() => AddressRepository(sl()));
  sl.registerLazySingleton(() => BillRepository(sl()));
}
