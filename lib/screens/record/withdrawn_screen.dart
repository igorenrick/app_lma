import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/screens/record/withdrawn_confirmation_screen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

class WithdrawnScreen extends StatefulWidget {
  final ChemicalMaterial material;
  const WithdrawnScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<WithdrawnScreen> createState() => _WithdrawnScreenState();
}

class _WithdrawnScreenState extends State<WithdrawnScreen> {
  late TextEditingController _amountController;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late String data = 'Agora';
  late DateTime actualDate;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  late String _hour, _minute, _time;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour : $_minute';
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2021, 1, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      actualDate = DateTime.now();
    });
    _amountController = TextEditingController();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2021, 1, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 19, 62, 59),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24, top: 24, right: 24),
              child: Text(
                'Qual a quantidade utilizada?',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      'Quantidade disponível ${widget.material.currentAmount.toString()} ${widget.material.getUnity()}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 142, 142, 147),
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 48),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          autofocus: true,
                          cursorColor: const Color.fromARGB(255, 126, 205, 201),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '00.00',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 142, 142, 147),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          widget.material.type == 'Solvente' ? 'mL' : 'g',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      'Quando foi utilizado?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 142, 142, 147),
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 24),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _selectDate(context);
                        await _selectTime(context);

                        final dt = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute);

                        if (selectedDate != DateTime.now()) {
                          setState(() {
                            data = DateFormat('dd/MM/yyyy').format(dt);
                            actualDate = dt;
                          });
                        }
                        if (selectedTime !=
                            const TimeOfDay(hour: 00, minute: 00)) {
                          setState(() {
                            data = DateFormat('dd/MM/yyyy HH:mm').format(dt);
                            actualDate = dt;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        data,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SquareButton(
              label: 'Retirar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WithDrawnConfirmationScreen(
                      material: widget.material,
                      date: actualDate,
                      amount: (_amountController.text.isNotEmpty
                          ? double.parse(
                              _amountController.text.replaceAll(',', '.'),
                            )
                          : 0.00),
                      userLmaId: auth.lmaUser!.id,
                    ),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 19, 62, 59),
              icon: Icons.arrow_circle_up,
            ),
          ],
        ),
      ),
    );
  }
}
