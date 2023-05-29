import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'wallet_bloc.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc()..add(FetchBalanceEvent()),
      child: _WalletPageView(),
    );
  }
}

class _WalletPageView extends StatelessWidget {
  Future<double> _showAddBalanceDialog(BuildContext context) async {
    double? newData;
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Add Balance'),
        content: TextFormField(
          decoration: InputDecoration(hintText: 'Enter amount in USD'),
          onChanged: (value) {
            newData = double.tryParse(value);
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () => Navigator.pop(context, newData),
          ),
        ],
      ),
    );
    return newData ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletInitialState) {
            return Center(child: Text('Welcome to Wallet'));
          } else if (state is WalletLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WalletLoadedState) {
            return Column(
              children: [
                ListTile(
                  title: Text('Balance in USD'),
                  subtitle: Text('\$' + state.balance.toStringAsFixed(2)),
                ),
                ElevatedButton(
                  child: Text('Add Balance'),
                  onPressed: () async {
                    double addedBalance = await _showAddBalanceDialog(context);
                    context.read<WalletBloc>().add(AddBalanceEvent(addedAmount: addedBalance));
                  },
                ),
              ],
            );
          } else if (state is WalletErrorState) {
            return Center(child: Text('Error: ' + state.error));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
