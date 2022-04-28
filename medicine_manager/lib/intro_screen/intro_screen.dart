import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_manager/providers/medicines_provider.dart';
import 'package:provider/provider.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key, required this.onDone}) : super(key: key);

  final Function onDone;
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Timer timer;
  GlobalKey<IntroductionScreenState> _myKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => _myKey.currentState?.next());
  }

  PageViewModel introPage(String description, String asset) {
    return PageViewModel(
      title: "Guia para adicionar um remédio",
      bodyWidget: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(description,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset(
              'assets/' + asset + '.jpg',
              width: 300,
            )),
          ],
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listPagesViewModel = [
      introPage("Preencha o nome e a descrição do remédio", "description"),
      introPage("Clique no botão 'Próximo'", "next"),
      introPage("Preencha a quantidade e a validade do remédio", "quantity"),
      introPage("Clique no botão 'Próximo'", "next"),
      introPage("Escolha os dias da semana e o horário para agendar o remédio",
          "schedule"),
      introPage("Clique no botão 'Adicionar'", "add"),
    ];

    return Consumer<MedicinesProvider>(
        builder: (context, medicineProvider, _) => Scaffold(
              body: SafeArea(
                child: IntroductionScreen(
                  key: _myKey,
                  pages: listPagesViewModel,
                  onDone: () => widget.onDone(),
                  onSkip: () => widget.onDone(),
                  showBackButton: false,
                  showSkipButton: true,
                  showNextButton: false,
                  skip: const Text("Pular Tutorial"),
                  next: const Text("Próximo"),
                  done: const Text("Ir para adicionar",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  dotsDecorator: DotsDecorator(
                      size: const Size.square(10.0),
                      activeSize: const Size(20.0, 10.0),
                      activeColor: Colors.blue,
                      color: Colors.black26,
                      spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                ),
              ),
            ));
  }
}
