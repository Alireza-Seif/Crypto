import 'package:crypto/constants/constants.dart';
import 'package:crypto/data/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  bool isSearchLoadingVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Crypto',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Exo',
          ),
        ),
        backgroundColor: blackColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: 380,
                child: TextField(
                  onChanged: (value) {
                    _filterList(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'coin name',
                    hintStyle: const TextStyle(
                      fontFamily: 'Exo',
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: greenColor,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isSearchLoadingVisible,
              child: const Text(
                'Updating cryptocurrencies',
                style: TextStyle(
                  color: greenColor,
                  fontFamily: 'Exo',
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: greenColor,
                color: blackColor,
                onRefresh: () async {
                  List<Crypto> fereshData = await _getData();
                  setState(() {
                    cryptoList = fereshData;
                  });
                },
                child: ListView.builder(
                  itemCount: cryptoList!.length,
                  itemBuilder: (context, index) {
                    return _getListTileItem(cryptoList![index]);
                  },
                ),
              ),
            ),
          ],
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

  Color _getColorChangeText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }

  Widget _getListTileItem(Crypto crypto) {
    return ListTile(
        title: Text(
          crypto.name,
          style: const TextStyle(color: greenColor),
        ),
        subtitle: Text(
          crypto.symbol,
          style: const TextStyle(color: greyColor),
        ),
        leading: SizedBox(
          width: 30,
          child: Center(
            child: Text(
              crypto.rank.toString(),
              style: const TextStyle(color: greyColor),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    crypto.priceUsd.toStringAsFixed(2),
                    style: const TextStyle(color: greyColor, fontSize: 18),
                  ),
                  Text(
                    crypto.changePercent24Hr.toStringAsFixed(2),
                    style: TextStyle(
                      color: _getColorChangeText(crypto.changePercent24Hr),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
                child: Center(
                  child: _getIconChangePercent(crypto.changePercent24Hr),
                ),
              ),
            ],
          ),
        ));
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Future<void> _filterList(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];

    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearchLoadingVisible = true;
      });
      var result = await _getData();
      setState(() {
        cryptoList = result;
        isSearchLoadingVisible = false;
      });
      return;
    }
    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();

    setState(() {
      cryptoList = cryptoResultList;
    });
  }
}
