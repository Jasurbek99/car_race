import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/shop_mock_datasource.dart';
import '../../data/repositories/shop_repository_impl.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/usecases/get_shop_packages.dart';
import '../state/shop_state.dart';

part 'shop_providers.g.dart';

@riverpod
ShopMockDataSource shopMockDataSource(
    // ignore: deprecated_member_use_from_same_package
    ShopMockDataSourceRef ref) {
  return ShopMockDataSourceImpl();
}

@riverpod
ShopRepository shopRepository(
    // ignore: deprecated_member_use_from_same_package
    ShopRepositoryRef ref) {
  final dataSource = ref.watch(shopMockDataSourceProvider);
  return ShopRepositoryImpl(dataSource);
}

@riverpod
GetShopPackages getShopPackages(
    // ignore: deprecated_member_use_from_same_package
    GetShopPackagesRef ref) {
  final repository = ref.watch(shopRepositoryProvider);
  return GetShopPackages(repository);
}

@riverpod
class ShopNotifier extends _$ShopNotifier {
  @override
  ShopState build() {
    loadPackages();
    return const ShopState.initial();
  }

  Future<void> loadPackages() async {
    state = const ShopState.loading();

    final useCase = ref.read(getShopPackagesProvider);
    final result = await useCase();

    result.when(
      success: (packages) {
        if (packages.isEmpty) {
          state = const ShopState.empty();
        } else {
          state = ShopState.loaded(packages);
        }
      },
      failure: (failure) {
        state = ShopState.error(failure.message);
      },
    );
  }

  Future<void> retry() async {
    await loadPackages();
  }
}
