import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class FetchBalanceEvent extends WalletEvent {}

class AddBalanceEvent extends WalletEvent {
  final double addedAmount;

  AddBalanceEvent({required this.addedAmount});

  @override
  List<Object> get props => [addedAmount];
}
