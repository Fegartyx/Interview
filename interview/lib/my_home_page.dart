import 'package:flutter/material.dart';
import 'package:interview/Products.dart';
import 'package:interview/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollContoller = ScrollController();
  Services services = Services();
  List<Product> products = [];
  late Future _data;
  var limit = 15;
  @override
  void initState() {
    // TODO: implement initState
    scrollContoller.addListener(_scroll);
    fetch();
    super.initState();
  }

  fetch() {
    _data = services.getProducts(limit);
    setState(() {
      _data = services.getProducts(limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       if (index < data.length) {
          //         //Product product = data[index];
          //         return Card(
          //           child: ListTile(
          //             title: Text(data[index]),
          //           ),
          //           // child: ListTile(
          //           //   title: Text(product.title),
          //           //   leading: Image.network(product.images[0]),
          //           //   subtitle: Text(product.price.toString()),
          //           //   trailing: Text(product.discountPercentage.toString()),
          //           // ),
          //         );
          //       } else {
          //         return const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 20),
          //           child: Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //         );
          //       }
          //     },
          //     itemCount: data.length,
          //   ),
          // )
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    controller: scrollContoller,
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        Product product = products[index];
                        return Card(
                          child: ListTile(
                            title: Text(product.title),
                            leading: Image.network(product.images[0]),
                            subtitle: Text(product.price.toString()),
                            trailing:
                                Text('Disc : ${product.discountPercentage}%'),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                    itemCount: products.length + 1,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
            future: _data,
          )
        ],
      ),
    );
  }

  void _scroll() {
    if (scrollContoller.position.pixels ==
        scrollContoller.position.maxScrollExtent) {
      limit += 5;
      print('scroll');
      fetch();
    } else {
      print('Dont Call');
    }
  }
}
