import 'package:flutter/material.dart';
import 'package:interview/Products.dart';
import 'package:interview/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future _data;
  @override
  void initState() {
    // TODO: implement initState
    fetch();
    super.initState();
  }

  fetch() {
    _data = Services.getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        Product product = products[index];
                        return Card(
                          child: ListTile(
                            title: Text(product.title),
                            leading: Image.network(product.images[0]),
                            subtitle: Text(product.price.toString()),
                            trailing:
                                Text(product.discountPercentage.toString()),
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
                    itemCount: products.length,
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
}
