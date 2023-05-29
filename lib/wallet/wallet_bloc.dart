import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  double _balance = 0.0;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  WalletBloc() : super(WalletInitialState()) {
    on<FetchBalanceEvent>(_onFetchBalanceEvent);
    on<AddBalanceEvent>(_onAddBalanceEvent);
  }

  Future<void> _onFetchBalanceEvent(FetchBalanceEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoadingState());
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('wallet')
          .doc(userId)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        _balance = data['BalanceUSD'] ?? 0.0;
        emit(WalletLoadedState(balance: _balance));
      } else {
        throw Exception("Document does not exist");
      }
    } catch (e) {
      emit(WalletErrorState(error: e.toString()));
    }
  }

  Future<void> _onAddBalanceEvent(AddBalanceEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoadingState());
    try {
      _balance += event.addedAmount;

      // Update in Firebase
      await FirebaseFirestore.instance.collection('wallet').doc(userId).set({
        'BalanceUSD': _balance,
      });
      emit(WalletLoadedState(balance: _balance));
    } catch (e) {
      emit(WalletErrorState(error: e.toString()));
    }
  }
}
