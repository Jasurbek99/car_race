// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'7cd30c9640ca952d1bcf1772c709fc45dc47c8b3';

/// Provider for SharedPreferences instance
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$carSelectionRepositoryHash() =>
    r'8770db1ad4c99282157cdd4b67779e55338c65d0';

/// Provider for CarSelectionRepository
///
/// Copied from [carSelectionRepository].
@ProviderFor(carSelectionRepository)
final carSelectionRepositoryProvider =
    AutoDisposeFutureProvider<CarSelectionRepository>.internal(
      carSelectionRepository,
      name: r'carSelectionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$carSelectionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CarSelectionRepositoryRef =
    AutoDisposeFutureProviderRef<CarSelectionRepository>;
String _$carSelectionHash() => r'd53afa37ef67ffc5d8e9d5471fc64eecf099f039';

/// Notifier for managing the selected car configuration
///
/// Copied from [CarSelection].
@ProviderFor(CarSelection)
final carSelectionProvider =
    AutoDisposeAsyncNotifierProvider<CarSelection, CarConfig>.internal(
      CarSelection.new,
      name: r'carSelectionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$carSelectionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CarSelection = AutoDisposeAsyncNotifier<CarConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
