import 'package:flutter/material.dart';
import 'package:inventory_management/ui/components/enter_key_alert.dart';
import 'package:inventory_management/ui/components/input_field.dart';

class AddNewSupplier extends StatefulWidget {
  static const routeName = '/newSuplier';
  const AddNewSupplier({Key key}) : super(key: key);
  @override
  _AddNewSupplierState createState() => _AddNewSupplierState();
}

class _AddNewSupplierState extends State<AddNewSupplier> {
  int len;
  List<Widget> list;
  @override
  void initState() {
    len = 0;
    super.initState();
    list = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Supplier'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const InputField(
                  label: 'Supplier Name',
                ),
                const InputField(
                  label: 'Description',
                  maxLine: 8,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    final label =
                        await EnterKeyName.show(context, onDelete: () {});
                    setState(
                      () {
                        list.add(
                          InputField(
                            label: label,
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('+add'),
                ),
                for (var i in list)
                  Stack(children: [
                    i,
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            list.remove(i);
                          });
                        },
                        child: const Icon(Icons.cancel),
                      ),
                    ),
                  ]),
                const SizedBox(
                  height: 36,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add supplier'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
