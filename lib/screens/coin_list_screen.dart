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
            return Container(
              height: 80,
              margin: const EdgeInsets.all(10),
              color: Colors.blue,
              child: Text(
                cryptoList![index].name,
                style: const TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
