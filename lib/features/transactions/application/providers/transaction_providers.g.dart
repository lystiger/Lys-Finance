// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transactionRepository)
final transactionRepositoryProvider = TransactionRepositoryProvider._();

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'78244cdf1f73d1d9dd6d0020e29608852925355e';

@ProviderFor(transactionService)
final transactionServiceProvider = TransactionServiceProvider._();

final class TransactionServiceProvider
    extends
        $FunctionalProvider<
          TransactionService,
          TransactionService,
          TransactionService
        >
    with $Provider<TransactionService> {
  TransactionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionServiceHash();

  @$internal
  @override
  $ProviderElement<TransactionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionService create(Ref ref) {
    return transactionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionService>(value),
    );
  }
}

String _$transactionServiceHash() =>
    r'7cadad6bf72b8bfb11132c043831ef35d2d194f9';

@ProviderFor(LedgerFilterController)
final ledgerFilterControllerProvider = LedgerFilterControllerProvider._();

final class LedgerFilterControllerProvider
    extends $NotifierProvider<LedgerFilterController, TransactionFilter> {
  LedgerFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ledgerFilterControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ledgerFilterControllerHash();

  @$internal
  @override
  LedgerFilterController create() => LedgerFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionFilter>(value),
    );
  }
}

String _$ledgerFilterControllerHash() =>
    r'0e26f4cc8c019139020531a11f753517b696bd1f';

abstract class _$LedgerFilterController extends $Notifier<TransactionFilter> {
  TransactionFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TransactionFilter, TransactionFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionFilter, TransactionFilter>,
              TransactionFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ledgerStream)
final ledgerStreamProvider = LedgerStreamProvider._();

final class LedgerStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<LedgerPage>,
          LedgerPage,
          Stream<LedgerPage>
        >
    with $FutureModifier<LedgerPage>, $StreamProvider<LedgerPage> {
  LedgerStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ledgerStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ledgerStreamHash();

  @$internal
  @override
  $StreamProviderElement<LedgerPage> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<LedgerPage> create(Ref ref) {
    return ledgerStream(ref);
  }
}

String _$ledgerStreamHash() => r'0b9bdb47f8220a76592aedd3b70c6766bdd35ff0';

@ProviderFor(transactionDetail)
final transactionDetailProvider = TransactionDetailFamily._();

final class TransactionDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Transaction?>,
          Transaction?,
          Stream<Transaction?>
        >
    with $FutureModifier<Transaction?>, $StreamProvider<Transaction?> {
  TransactionDetailProvider._({
    required TransactionDetailFamily super.from,
    required (String, {bool includeDeleted}) super.argument,
  }) : super(
         retry: null,
         name: r'transactionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionDetailHash();

  @override
  String toString() {
    return r'transactionDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Transaction?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Transaction?> create(Ref ref) {
    final argument = this.argument as (String, {bool includeDeleted});
    return transactionDetail(
      ref,
      argument.$1,
      includeDeleted: argument.includeDeleted,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionDetailHash() => r'55de357656228b48fa8078bed6282aa3ceb46068';

final class TransactionDetailFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Transaction?>,
          (String, {bool includeDeleted})
        > {
  TransactionDetailFamily._()
    : super(
        retry: null,
        name: r'transactionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TransactionDetailProvider call(String id, {bool includeDeleted = true}) =>
      TransactionDetailProvider._(
        argument: (id, includeDeleted: includeDeleted),
        from: this,
      );

  @override
  String toString() => r'transactionDetailProvider';
}

@ProviderFor(accountBalance)
final accountBalanceProvider = AccountBalanceFamily._();

final class AccountBalanceProvider
    extends $FunctionalProvider<AsyncValue<Money>, Money, Stream<Money>>
    with $FutureModifier<Money>, $StreamProvider<Money> {
  AccountBalanceProvider._({
    required AccountBalanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accountBalanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountBalanceHash();

  @override
  String toString() {
    return r'accountBalanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Money> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Money> create(Ref ref) {
    final argument = this.argument as String;
    return accountBalance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountBalanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountBalanceHash() => r'3caf472e581fa7e56fdd9665a32dd53b1be05274';

final class AccountBalanceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Money>, String> {
  AccountBalanceFamily._()
    : super(
        retry: null,
        name: r'accountBalanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AccountBalanceProvider call(String accountId) =>
      AccountBalanceProvider._(argument: accountId, from: this);

  @override
  String toString() => r'accountBalanceProvider';
}

@ProviderFor(QuickAddController)
final quickAddControllerProvider = QuickAddControllerProvider._();

final class QuickAddControllerProvider
    extends $NotifierProvider<QuickAddController, TransactionDraft> {
  QuickAddControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickAddControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickAddControllerHash();

  @$internal
  @override
  QuickAddController create() => QuickAddController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionDraft>(value),
    );
  }
}

String _$quickAddControllerHash() =>
    r'47d14b165aa38c06a94ba78c0ca9316ad4786b6f';

abstract class _$QuickAddController extends $Notifier<TransactionDraft> {
  TransactionDraft build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TransactionDraft, TransactionDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionDraft, TransactionDraft>,
              TransactionDraft,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
