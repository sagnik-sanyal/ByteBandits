import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/text_widget.dart';

class PaymentScreen extends StatelessWidget {
  final String mccCode;
  const PaymentScreen({
    super.key,
    required this.mccCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proceed to Payment'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 100),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Flexible>[
                        Flexible(
                          child: AppText.semiBold(
                            'Amount',
                            fontSize: 20,
                            color: Color(0xFFDADBFF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Flexible(
                          child: AppText.semiBold(
                            '₹ ',
                            fontSize: 50,
                            color: Color(0xFFDADBFF),
                          ),
                        ),
                        SizedBox(
                          width: 0.4.sw,
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.1.sw),
                        constraints: BoxConstraints(maxWidth: 0.8.sw),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 42, 42, 42),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.spMin,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp('^[a-zA-Z ]+')),
                          ],
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Note',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 16.spMin,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(0.65.sw, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: const AppText.semiBold(
                      'Send',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
