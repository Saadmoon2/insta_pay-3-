import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitialState extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletLoadedState extends WalletState {
  final double balance;

  WalletLoadedState({required this.balance});

  @override
  List<Object> get props => [balance];
}

class WalletErrorState extends WalletState {
  final String error;

  WalletErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
