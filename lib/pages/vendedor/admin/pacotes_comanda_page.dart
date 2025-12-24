import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/firestore_service.dart';

class PacotesComandaPage extends StatefulWidget {
  final String comandaId;
  final String codigoComanda;

  const PacotesComandaPage({
    super.key,
    required this.comandaId,
    required this.codigoComanda,
  });

  @override
  State<PacotesComandaPage> createState() => _PacotesComandaPageState();
}

class _PacotesComandaPageState extends State<PacotesComandaPage> {
  String _formaPagamento = 'pix';

  double _calcularTotal(List<QueryDocumentSnapshot> vendas) {
    return vendas.fold(0.0, (total, venda) {
      final data = venda.data() as Map<String, dynamic>;
      return total + (data['Valor_Total_Venda'] ?? 0.0);
    });
  }

  Future<void> _recalcularTotalComanda() async {
    await FirestoreService.instance
        .recalcularTotalComanda(widget.comandaId);
  }

  void _editarVendaDialog(
    BuildContext context,
    QueryDocumentSnapshot venda,
  ) {
    final data = venda.data() as Map<String, dynamic>;

    final quantidadeCtrl =
        TextEditingController(text: data['Quantidade'].toString());
    final precoCtrl =
        TextEditingController(text: data['Preco_Unitario'].toString());
    final descontoCtrl =
        TextEditingController(text: data['Desconto'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Venda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: quantidadeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
            TextFormField(
              controller: precoCtrl,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Preço Unitário'),
            ),
            TextFormField(
              controller: descontoCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Desconto'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Salvar'),
            onPressed: () async {
              final qtd = int.parse(quantidadeCtrl.text);
              final preco = double.parse(precoCtrl.text);
              final desconto = double.parse(descontoCtrl.text);

              final total = (qtd * preco) - desconto;

              await FirebaseFirestore.instance
                  .collection('vendas')
                  .doc(venda.id)
                  .update({
                'Quantidade': qtd,
                'Preco_Unitario': preco,
                'Desconto': desconto,
                'Valor_Total_Venda': total,
              });

              await _recalcularTotalComanda();

              if (mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comanda ${widget.codigoComanda}'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('comandas')
            .doc(widget.comandaId)
            .snapshots(),
        builder: (context, comandaSnap) {
          if (!comandaSnap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final comandaData =
              comandaSnap.data!.data() as Map<String, dynamic>;
          final status = comandaData['status'];

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('vendas')
                .where('Comanda_ID', isEqualTo: widget.comandaId)
                .orderBy('dataVenda')
                .snapshots(),
            builder: (context, vendasSnap) {
              if (!vendasSnap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final vendas = vendasSnap.data!.docs;
              final total = _calcularTotal(vendas);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: vendas.length,
                      itemBuilder: (context, index) {
                        final venda = vendas[index];
                        final data =
                            venda.data() as Map<String, dynamic>;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text(data['Produto_Nome']),
                            subtitle: Text(
                              'Vendedor: ${data['Vendedor_Nome']} | '
                              'Qtd: ${data['Quantidade']}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'R\$ ${data['Valor_Total_Venda'].toStringAsFixed(2)}',
                                ),
                                if (status == 'aberta') ...[
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _editarVendaDialog(context, venda),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('vendas')
                                          .doc(venda.id)
                                          .delete();

                                      await _recalcularTotalComanda();
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Forma de pagamento:'),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _formaPagamento,
                              onChanged: status == 'aberta'
                                  ? (v) => setState(
                                        () => _formaPagamento = v!,
                                      )
                                  : null,
                              items: const [
                                DropdownMenuItem(
                                    value: 'credito',
                                    child: Text('Crédito')),
                                DropdownMenuItem(
                                    value: 'debito',
                                    child: Text('Débito')),
                                DropdownMenuItem(
                                    value: 'pix', child: Text('PIX')),
                                DropdownMenuItem(
                                    value: 'dinheiro',
                                    child: Text('Dinheiro')),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R\$ ${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (status == 'aberta')
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check),
                            label: const Text('Validar e Fechar'),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('comandas')
                                  .doc(widget.comandaId)
                                  .update({
                                'status': 'fechada',
                                'formaPagamento': _formaPagamento,
                                'dataFechamento': Timestamp.now(),
                              });

                              if (mounted) Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
