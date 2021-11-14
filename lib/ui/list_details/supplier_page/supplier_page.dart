import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupplierPageArgument {
  final String companyName;
  final String description;

  SupplierPageArgument(
      {@required this.companyName, @required this.description});
}

class SupplierPage extends StatefulWidget {
  static String routeName = '/suppliers';
  final String companyName;
  final String description;

  const SupplierPage(
      {Key key, @required this.companyName, @required this.description})
      : super(key: key);
  @override
  _SupplierPageState createState() => _SupplierPageState();
  static Widget wrapped(SupplierPageArgument supplierPageArgument) {
    return SupplierPage(
      companyName: supplierPageArgument.companyName,
      description: supplierPageArgument.description,
    );
  }
}

class _SupplierPageState extends State<SupplierPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.description);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {})
        ],
        leading: const BackButton(),
        centerTitle: true,
        title: const Text("Suppliers"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              //stops: [.03, 0.04, .8],
              colors: <Color>[
                Color(0xFF033CFF),
                Color(0xFF30AAFF),
                Color(0xFF33CFFF),
                Colors.blue
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -8.5,
                      left: 10,
                      child: Container(
                        color: Colors.white,
                        child: const Text("Company Name"),
                        clipBehavior: Clip.none,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                          // color: Colors.purple,
                          ),
                      child: TextFormField(
                        initialValue: widget.companyName,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),

                    // Text("Company Name")
                  ],
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  fit: StackFit.loose,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                          // color: Colors.purple,
                          ),
                      child: TextFormField(
                        initialValue: widget.description,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(400)
                        ],
                        maxLines: 4,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),

                    Positioned(
                      top: -8.5,
                      left: 10,
                      child: Container(
                        color: Colors.white,
                        child: const Text("Description"),
                        clipBehavior: Clip.none,
                      ),
                    ),
                    // Text("Company Name")
                  ],
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  fit: StackFit.loose,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Center(child: RaisedButton(onPressed: () {})),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      // color: Colors.blueAccent,
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
