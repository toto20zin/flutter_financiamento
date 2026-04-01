import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double valor = 0.0;
  double taxa = 0.0;
  int parcelas = 0;
  double taxasExtras = 0.0;

  double total = 0.0;
  double parcela = 0.0;

  String resultado = "Resultado";

  void calcular() {
    setState(() {
      if (parcelas <= 0) {
        parcela = 0;
        total = 0;
        return;
      }

      double taxaDecimal = taxa / 100;

      if (taxaDecimal == 0) {
        parcela = valor / parcelas;
      } else {
        double fator =
            (taxaDecimal * pow(1 + taxaDecimal, parcelas)) /
            (pow(1 + taxaDecimal, parcelas) - 1);

        parcela = valor * fator;
      }

      total = (parcela * parcelas) + taxasExtras;

      resultado =
          "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}\n"
          "Valor total: R\$ ${total.toStringAsFixed(2)}";
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF2F8),
          title: const Center(
            child: Text(
              "Resultado",
              style: TextStyle(
                color: Color(0xFF6B4664),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            resultado,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF6B4664)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
                style: TextStyle(color: Color(0xFF6B4664)),
              ),
            ),
          ],
        );
      },
    );
  }

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFcdc3b2), fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF6B4664), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF6B4664), width: 1),
      ),
    );
  }

  Widget campo(String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF807158),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: customInputDecoration(hint),
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Color(0xFF6B4664)),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: const Color(0xFF4370D2),
            child: const Center(
              child: Text(
                "Simulador de financiamento",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  campo("Valor de financiamento :", "Digite o valor", (v) {
                    valor = double.tryParse(v) ?? 0;
                  }),

                  const SizedBox(height: 20),

                  campo("Taxa de juros ao mês :", "Digite a taxa de juros", (v) {
                    taxa = double.tryParse(v) ?? 0;
                  }),

                  const SizedBox(height: 20),

                  campo("Número de parcelas :", "Digite o número de parcelas", (v) {
                    parcelas = int.tryParse(v) ?? 0;
                  }),

                  const SizedBox(height: 20),

                  campo(
                      "Demais taxas e custos :",
                      "Digite o total de taxas e custos adicionais", (v) {
                    taxasExtras = double.tryParse(v) ?? 0;
                  }),

                  const SizedBox(height: 25),

                  Center(
                    child: ElevatedButton(
                      onPressed: calcular,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4370D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Registrar"),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Valor total a ser pago: R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color(0xFF807158),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color(0xFF807158),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}