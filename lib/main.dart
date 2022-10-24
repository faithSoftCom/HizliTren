import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
  final List<String> items = [
    "Adana",
    "Adapazarı",
    "Adatepe (Pingen)",
    "Adnanmenderes Havaalanı",
    "Afyon A.Çetinkaya",
    "Ahmetler",
    "Ahmetli",
    "Akgedik",
    "Akhisar",
    "Aksakal",
    "Akçadağ",
    "Akçamağara",
    "Akşehir",
    "Alayunt",
    "Alayunt Müselles",
    "Alaşehir",
    "Alifuatpaşa",
    "Alp",
    "Alpu",
    "Alpullu",
    "Alöve",
    "Ankara Gar",
    "Araplı",
    "Argıthan",
    "Arifiye",
    "Arıkören",
    "Asmakaya",
    "Atça",
    "Avşar",
    "Aydın",
    "Ayran",
    "Ayrancı",
    "Ayvacık",
    "Aşkale",
    "Bahçe",
    "Bahçeli (Km.755+290 S)",
    "Bahçeşehir",
    "Bahçıvanova",
    "Bakır",
    "Balıkesir",
    "Balıköy",
    "Balışıh",
    "Banaz",
    "Bandırma Şehir",
    "Baskil",
    "Batman",
    "Battalgazi",
    "Bağıştaş",
    "Bedirli",
    "Belemedik",
    "Bereket",
    "Beyhan",
    "Beylikköprü",
    "Beylikova",
    "Beyoğlu",
    "Beşiri",
    "Bilecik",
    "Bilecik YHT",
    "Bismil",
    "Biçer",
    "Bor",
    "Bostankaya",
    "Bozkanat",
    "Bozkurt",
    "Bozüyük",
    "Bozüyük YHT",
    "Boğazköprü",
    "Boğazköprü Müselles",
    "Buharkent",
    "Burdur",
    "Böğecik",
    "Büyükderbent YHT",
    "Büyükçobanlar",
    "Caferli",
    "Ceyhan",
    "Cürek",
    "Dazkırı",
    "Demirdağ",
    "Demiriz",
    "Demirkapı",
    "Demirli",
    "Demiryurt",
    "Demirözü",
    "Denizli",
    "Derince YHT",
    "Değirmenözü",
    "Değirmisaz",
    "Diliskelesi YHT",
    "Dinar",
    "Divriği",
    "Diyarbakır",
    "Doğançay",
    "Doğanşehir",
    "Dumlupınar",
    "Durak",
    "Dursunbey",
    "Döğer",
    "ERYAMAN YHT",
    "Edirne",
    "Edirne Şehir",
    "Ekerek",
    "Ekinova",
    "Elazığ",
    "Elmadağ",
    "Emiralem",
    "Emirler",
    "Erbaş",
    "Ereğli",
    "Ergani",
    "Eriç",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Evciler",
    "Eşme",
    "Fevzipaşa",
    "Fırat",
    "Gazellidere",
    "Gaziemir",
    "Gazlıgöl",
    "Gebze",
    "Genç",
    "Germencik",
    "Gezin",
    "Goncalı",
    "Goncalı Müselles",
    "Gökköy (Balıkesir)",
    "Gökçedağ",
    "Gökçekısık",
    "Gölbaşı Gar",
    "Gölcük",
    "Gömeç",
    "Göçentaşı",
    "Güllübağ",
    "Gümüş",
    "Gümüşgün",
    "Gündoğan",
    "Güneyköy",
    "Güneş",
    "Gürpınar",
    "Güzelyurt",
    "Hacıkırı",
    "Hacırahmanlı",
    "Hanlı",
    "Hasankale",
    "Hekimhan",
    "Hereke YHT",
    "Himmetdede",
    "Horasan",
    "Horozköy",
    "Horozluhan",
    "Horsunlu",
    "Huzurkent",
    "Hüyük",
    "Ildızım",
    "Ilgın",
    "Ilıca",
    "Irmak",
    "Isparta",
    "Ispartakule",
    "Kabakça",
    "Kadılı",
    "Kadınhan",
    "Kaklık",
    "Kalecik",
    "Kalkancık",
    "Kandilli",
    "Kanlıca",
    "Kapaklı",
    "Kapıdere İstasyonu",
    "Kapıkule",
    "Karaali",
    "Karaali",
    "Karaağaçlı",
    "Karabük",
    "Karaisalıbucağı",
    "Karakuyu",
    "Karaköy",
    "Karalar",
    "Karaman",
    "Karaosman",
    "Karasenir",
    "Karasu",
    "Karaurgan",
    "Karaözü",
    "Kars",
    "Kavaklıdere",
    "Kayabeyli",
    "Kayaş",
    "Kayseri",
    "Kayışlar",
    "Kaşınhan",
    "Kelebek",
    "Kemah",
    "Kemaliye Çaltı",
    "Kemerhisar",
    "Keykubat",
    "Keçiborlu",
    "Kiremithane (adana)",
    "Kireç",
    "Km. 30+500",
    "Km. 37+362",
    "Km.139+500",
    "Km.156 Durak",
    "Km.171+000",
    "Km.176+000",
    "Km.186+000",
    "Km.282+200",
    "Km.286+500",
    "Km.41+500",
    "Km.638+907",
    "Km.746+840",
    "Konaklar",
    "Konya",
    "Kozdere",
    "Kumlu Sayding",
    "Kurbağalı",
    "Kurfallı",
    "Kurt",
    "Kurtalan",
    "Kuyucak",
    "Kuşcenneti",
    "Kuşsarayı",
    "Köprüağzı",
    "Köprüköy",
    "Köprüören",
    "Köşk",
    "Kürk",
    "Kütahya",
    "Kılıçlar",
    "Kırkağaç",
    "Kırıkkale",
    "Kızılinler",
    "Lalahan",
    "Leylek",
    "Lüleburgaz",
    "Maden",
    "Malatya",
    "Mamure",
    "Manisa",
    "Mazlumlar",
    "Menderes",
    "Menemen",
    "Mercan",
    "Meydan",
    "Mezitler",
    "Mithatpaşa",
    "Muradiye",
    "Muratlı",
    "Muş",
    "Narlı Gar",
    "Nazilli",
    "Niğde",
    "Nohutova",
    "Nurdağ",
    "Nusrat",
    "Ortaklar",
    "Osmancık",
    "Osmaneli",
    "Osmaniye",
    "Oturak",
    "Oymapınar",
    "Palandöken",
    "Palu",
    "Pamukören",
    "Pancar",
    "Pazarcık İstasyonu",
    "Paşalı",
    "Pehlivanköy",
    "Piribeyler",
    "Polatlı",
    "Polatlı YHT",
    "Porsuk",
    "Pozantı",
    "Pınarbaşı",
    "Pınarlı",
    "Rahova",
    "Sabuncupınar",
    "Salat",
    "Salihli",
    "Sallar",
    "Sandıklı",
    "Sapanca",
    "Sarayköy",
    "Sarayönü",
    "Saruhanlı",
    "Sarıdemir",
    "Sarıkamış",
    "Sarıkent",
    "Sarımsaklı",
    "Sarıoğlan",
    "Savaştepe",
    "Sağlık",
    "Sekili",
    "Selçuk",
    "Selçuklu YHT(Konya)",
    "Sevindik",
    "Seyitler",
    "Sincan",
    "Sindirler",
    "Sinekli",
    "Sivas",
    "Sivrice",
    "Soma",
    "Soğucak",
    "Sudurağı",
    "Sultandağı",
    "Sultanhisar",
    "Susurluk",
    "Suveren",
    "Suçatı",
    "Söke",
    "Söğütlü Durak",
    "Süngütaşı",
    "Sünnetçiler",
    "Sütlaç",
    "Sıcaksu",
    "Tanyeri",
    "Tatvan Gar",
    "Tavşanlı",
    "Tayyakadın",
    "Taşkent",
    "Tecer",
    "Tepeköy",
    "Topaç",
    "Topdağı",
    "Toprakkale",
    "Torbalı",
    "Turgutlu",
    "Tuzhisar",
    "Tüney",
    "Türkoğlu",
    "Tınaztepe",
    "Ulam",
    "Uluköy",
    "Ulukışla",
    "Uluova",
    "Umurlu",
    "Urganlı",
    "Uzunköprü",
    "Uşak",
    "Velimeşe",
    "Vezirhan",
    "Yahşihan",
    "Yahşiler",
    "Yakapınar",
    "Yarbaşı",
    "Yarımca YHT",
    "Yayla",
    "Yaylıca",
    "Yazlak",
    "Yeni Karasar",
    "Yenice",
    "Yenifakılı",
    "Yenikangal",
    "Yeniköy",
    "Yeniçubuk",
    "Yerköy",
    "Yeşilhisar",
    "Yolçatı",
    "Yunusemre",
    "Yurt",
    "Yıldırımkemal",
    "Çadırkaya",
    "Çakmak",
    "Çalıköy",
    "Çamlık",
    "Çankırı",
    "Çardak",
    "Çatalca",
    "Çavundur",
    "Çavuşcugöl",
    "Çay",
    "Çağlar",
    "Çerikli",
    "Çerkezköy",
    "Çerkeş",
    "Çetinkaya",
    "Çiftehan",
    "Çiğli",
    "Çobanhasan",
    "Çorlu",
    "Çukurhüseyin",
    "Çumra",
    "Çöltepe",
    "Çöğürler",
    "İhsaniye",
    "İliç",
    "İnay",
    "İncesu(Kayseri)",
    "İncirlik",
    "İncirliova",
    "İsabeyli",
    "İshakçelebi",
    "İsmetpaşa",
    "İstanbul(Bakırköy)",
    "İstanbul(Bostancı)",
    "İstanbul(Halkalı)",
    "İstanbul(Pendik)",
    "İstanbul(Söğütlü Ç.)",
    "İzmir (Basmane)",
    "İzmit YHT",
    "Şakirpaşa",
    "Şarkışla",
    "Şefaatli",
    "Şefkat",
    "Şehitlik",
    "Şerbettar"
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
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    _btnController1.stateStream.listen((value) {
      print(value);

    });
  }

  Future<http.Response> fetchAlbum() async{
    return http.post(Uri.parse('https://balkan-tren.herokuapp.com/trainHours?first_location=$selectedBinis&last_location=$selectedInis&date=$formattedDate'),headers: {
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
                  _btnController2.reset();
                },
              ),
            )

          ],
        )

        );
  }
}