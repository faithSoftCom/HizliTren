import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:hizli_tren/notification.dart';
void main() {
  runApp(MyApp());
}

class TrenVacancies {
  final String saat;
  final String bosluk;

  const TrenVacancies({
    required this.saat,
    required this.bosluk,
  });

  factory TrenVacancies.fromJson( dynamic json) {
    return TrenVacancies(
      saat: json['hours'] as String,
      bosluk: json['vacancies'] as String,
    );
  }
}

List<String> getTrenVacanices(String responseBody)
{
  var tagsJson = jsonDecode(responseBody)['vacancies'];
  List<String> tags =List.from(tagsJson) ;

  return tags;
}

List<String> getTrenHours(String responseBody)
{
  var tagsJson = jsonDecode(responseBody)['hours'];
  List<String> tags =List.from(tagsJson) ;

  return tags;
}
List<String> getRadioButtons(String responseBody)
{
  List<String>hours= getTrenHours(responseBody);
  List<String>vacancies= getTrenVacanices(responseBody);
  List<String> returnList=[];
  for(int i=0;i<hours.length;i++)
    {
      returnList.add(hours[i]+'  /  '+vacancies[i]);
    }
  return returnList;
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Date Picker",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  TextEditingController dateInput = TextEditingController();
  NotificationClass notificationObj= NotificationClass();
  final List<String> items = [
    "Ankara Gar",
    "Arifiye",
    "Bilecik YHT",
    "Bozüyük YHT",
    "Büyükderbent YHT",
    "Çumra",
    "Derince YHT",
    "Diliskelesi YHT",
    "ERYAMAN YHT",
    "Eskişehir",
    "Gebze",
    "Hereke YHT",
    "Karaman",
    "Konya",
    "Polatlı YHT",
    "Selçuklu YHT(Konya)",
    "Yarımca YHT",
    "İstanbul(Bakırköy)",
    "İstanbul(Bostancı)",
    "İstanbul(Halkalı)",
    "İstanbul(Pendik)",
    "İstanbul(Söğütlü Ç.)",
    "İzmit YHT",
  ];
  String? selectedBinis;
  String? selectedInis;
  String formattedDate= "";
  String results= "";
  static const urlPrefix = 'https://balkan-tren.herokuapp.com/locations';
  late Future<http.Response> futureAlbum ;
  final RoundedLoadingButtonController _btnController1 = RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController2 = RoundedLoadingButtonController();
  int _stackIndex = 0;

  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";

  List<String> _status = [];
  List<TrenVacancies>? postResults;
  bool _isVisible = false;
  bool isLoading=false;
  String selectedSefer="";

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    _btnController1.stateStream.listen((value) {
      print(value);

    });
    notificationObj.initializeClass();
  }

  Future<http.Response> fetchAlbum() async{
    return http.post(Uri.parse('https://balkan-tren.herokuapp.com/trainHours?first_location=$selectedBinis&last_location=$selectedInis&date=$formattedDate'),headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"}
    );
  }

  Future<http.Response> registerResponse() async{
    return http.post(Uri.parse('https://balkan-tren.herokuapp.com/register?first_location=$selectedBinis&last_location=$selectedInis&date=$formattedDate&sefer=$selectedSefer'),headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"}
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text("Hızlı Tren Bileti Bul"),
          backgroundColor: Colors.redAccent, //background color of app bar
        ),
        body: ListView(
          children: <Widget>[
            TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tarih Seçin" //label text of field
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  formattedDate =
                  DateFormat('dd.MM.yyyy').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Biniş İstasyonu Seçin',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ))
              .toList(),
          value: selectedBinis,
          onChanged: (value) {
            setState(() {
              selectedBinis = value as String;
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),

            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'İniş İstasyonu Seçin',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                    .toList(),
                value: selectedInis,
                onChanged: (value) {
                  setState(() {
                    selectedInis = value as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
                buttonHeight: 50,
                buttonWidth: 160,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.redAccent,
                ),
                buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 200,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.redAccent,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
              ),
            ),
            RoundedLoadingButton(
              successIcon: Icons.cloud,
              failedIcon: Icons.cottage,
              child: Text('Seferleri Bul', style: TextStyle(color: Colors.white)),
              controller: _btnController1,
              onPressed: ()
              async {
                setState(() {
                  isLoading = true;
                });
                final myFuture = fetchAlbum();

                myFuture.then((response) {
                  _btnController1.reset();
                  if (response.statusCode == 200) {
                    // print(response.body);
                    setState(() {
                      results = response.body;
                      _status = getRadioButtons(response.body);
                      _isVisible = true;
                    });

                  }
                });
                setState(() {
                  isLoading = false;
                });
              },
            ),
            Column(
              children: <Widget>[
                RadioGroup<String>.builder(
                  groupValue: _verticalGroupValue,
                  onChanged: (value) => setState(() {
                    _verticalGroupValue = value!;
                    print("selectedValue:$value");

                  }),
                  items:_status,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                  activeColor: Colors.red,
                ),

              ],
            ),
            Visibility(
              visible: _isVisible,
                child:    RoundedLoadingButton(
                successIcon: Icons.cloud,
                failedIcon: Icons.cottage,

                child: Text('Seferdeki Değişikliklere Kayıtlan', style: TextStyle(color: Colors.white)),
                controller: _btnController2,
                onPressed: ()
                {
                  print("$_verticalGroupValue seferine kayıtlanıldı");
                  setState(() {
                   _status[_status.indexOf(_verticalGroupValue)] = "$_verticalGroupValue seferine kayıtlanıldı";
                   selectedSefer = _verticalGroupValue;
                   registerResponse();
                  });
                  _btnController2.reset();
                },
              ),
            )

          ],
        )

        );
  }
}