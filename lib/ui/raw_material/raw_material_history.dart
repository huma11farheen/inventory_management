import 'package:flutter/material.dart';

enum ProductionStatus {
  afterProduction,
  forProduction,
  afterReutilization,
  forPrinting,
  afterPurchase
}

class RawMaterialHistory extends StatelessWidget {
  static const routeName = '/rawMaterialHistory';
  const RawMaterialHistory({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw Material History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return _Card(
              date: 'Feb $index',
              purchaseId: '${index * 2}',
              rawMaterial: 'RawMaterial $index',
            );
          },
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String date;
  final String purchaseId;
  final double quantity;
  final String rawMaterial;
  final ProductionStatus status;

  const _Card(
      {Key key,
      this.date,
      this.purchaseId,
      this.quantity,
      this.rawMaterial,
      this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text('Date\n$date'),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('productionId'),
                        Text('Raw Material'),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(purchaseId),
                        Text(rawMaterial),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
