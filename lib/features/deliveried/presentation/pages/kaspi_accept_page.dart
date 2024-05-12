import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';

class KaspiAccept extends StatefulWidget {
  const KaspiAccept({
    super.key,
    required this.distance,
    required this.orderId,
  });
  final int orderId;
  final double distance;
  @override
  State<KaspiAccept> createState() => _KaspiAcceptState();
}

class _KaspiAcceptState extends State<KaspiAccept> {
  late TextEditingController digit1;
  late TextEditingController digit2;
  late TextEditingController digit3;
  late TextEditingController digit4;

  late DeliveriedBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<DeliveriedBloc>(context);
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveriedBloc, DeliveriedState>(
      listener: (context, state) {
        if (state is Deliviringed) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Успех'),
            ),
          );
        } else if (state is DelivirError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Неправильный код'),
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 68,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: TextFormField(
                          controller: digit1,
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        height: 68,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: TextFormField(
                          controller: digit2,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        height: 68,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: TextFormField(
                          controller: digit3,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        height: 68,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: TextFormField(
                          controller: digit4,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                state is Deliviring
                    ? const MainButtonLoading()
                    : MainButton(
                        text: 'Подтвердить',
                        onPressed: () async {
                          String codeAll = '';
                          codeAll += digit1.text;
                          codeAll += digit2.text;
                          codeAll += digit3.text;
                          codeAll += digit4.text;
                          if (kDebugMode) {
                            print(codeAll);
                          }
                          if (codeAll.isEmpty) {
                            bloc.add(
                              Delivered(
                                distance: widget.distance,
                                id: widget.orderId,
                                code: null,
                              ),
                            );
                          } else {
                            bloc.add(
                              Delivered(
                                distance: widget.distance,
                                id: widget.orderId,
                                code: int.parse(codeAll),
                              ),
                            );
                          }
                        },
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
