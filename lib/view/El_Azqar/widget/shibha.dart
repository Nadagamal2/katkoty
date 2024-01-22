import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/CounterController.dart';
import '../../../utils/color.dart';
import '../../../utils/images.dart';

class Sebhia extends StatelessWidget {
  const Sebhia({super.key});

  @override
  Widget build(BuildContext context) {
    CounterController viewModel = Get.put(CounterController());

    return GetX<CounterController>(
      init: CounterController(),
      builder: (Value) => Column(
        children: [
          Container(
            height: 110,
            width: 80,
            decoration: const BoxDecoration(
              color: Color(0xffd9d9d9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    right: 55,
                    child: Container(
                      width: 80,
                      height: 235,
                      decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/body.png',
                    height: 235,
                    width: 190,
                  ),
                  Positioned(
                    right: 20,
                    top: 25,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.asset(
                            view,
                            height: 58,
                            width: 152,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 60,
                          child: Center(
                            child: Text(
                              ' ${Value.counter.value}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 90,
                    child: Column(
                      children: [
                        const Text(
                          'إعادة ضبط',
                          style: TextStyle(
                              color: resetColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.deCrement();
                          },
                          child: Image.asset(
                            reset,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 55,
                    child: Stack(
                      children: [
                        Container(
                          width: 82.853515625,
                          height: 77.42388916015625,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(43.95005416870117),
                              color: const Color(0xffffc200)),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                viewModel.increment();
                              },
                              child: Container(
                                width: 62.90730667114258,
                                height: 58.78486633300781,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        37.438961029052734),
                                    color: const Color(0xffffd54c)),
                                child: const Center(
                                  child: Text("اضغط",
                                      style: TextStyle(
                                        fontSize: 13.205886840820312,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 100,
            width: 80,
            decoration: const BoxDecoration(
              color: Color(0xffd9d9d9),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
