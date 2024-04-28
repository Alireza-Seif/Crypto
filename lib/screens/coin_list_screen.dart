import 'package:crypto/constants/constants.dart';
import 'package:crypto/data/model/crypto.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(cryptoList![index].name),
                subtitle: Text(cryptoList![index].symbol),
                leading: SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      cryptoList![index].rank.toString(),
                    ),
                  ),
                ),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cryptoList![index].priceUsd.toStringAsFixed(2)),
                          Text(cryptoList![index]
                              .changePercent24Hr
                              .toStringAsFixed(2)),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: _getIconChangePercent(
                              cryptoList![index].changePercent24Hr),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? const Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : const Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }
}
