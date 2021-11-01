import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/Astrophytum/asterias.dart';
import 'package:flutter_login_signup/src/SearchPage/Astrophytum/capricorne.dart';
import 'package:flutter_login_signup/src/SearchPage/Astrophytum/myriostigma.dart';
import 'package:flutter_login_signup/src/SearchPage/Astrophytum/ornatumPage.dart';
import 'package:flutter_login_signup/src/SearchPage/Coryphantha/elephantidens.dart';
import 'package:flutter_login_signup/src/SearchPage/Coryphantha/ottonis.dart';
import 'package:flutter_login_signup/src/SearchPage/Coryphantha/retusa.dart';
import 'package:flutter_login_signup/src/SearchPage/Coryphantha/zougemaru.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_02.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_03.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_04.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_05.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_06.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/alberto-vojtechii.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/diffusa.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/fricii.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/jourdaniana.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/koehresii.dart';
import 'package:flutter_login_signup/src/SearchPage/Lophophora/williamsii.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/Beneckei.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/Bucareliensis.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/Karwinskiana.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/albicoma.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/bocasana.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/hahniana.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/huitzilopochtli.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/longimamma.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/mazatlanensis.dart';
import 'package:flutter_login_signup/src/SearchPage/Mammillaria/pectinifera.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/SearchPage/Gymnocalycium/Cactus_G_01.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SeaechPage extends StatefulWidget {
  @override
  _SeaechPageState createState() => _SeaechPageState();
}

class _SeaechPageState extends State<SeaechPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoCompleteData = cities;
  }

  TextEditingController controller;
  List<String> autoCompleteData;

  final List<String> cities = [
    "Gymnocalycium Baldianum",
    "Gymnocalycium Anisitsii Damsii",
    "Gymnocalycium Denudatum",
    "Gymnocalycium Mihanovichii",
    "Gymnocalycium Ochoterenae",
    "Gymnocalycium Spegazzinii",
    "Mammillaria Albicoma",
    "Mammillaria Beneckei",
    "Mammillaria Bucareliensis",
    "Mammillaria Bocasana",
    "Mammillaria Huitzilopochtli",
    "Mammillaria Karwinskiana",
    "Mammillaria hahniana",
    "Mammillaria Longimamma",
    "Mammillaria Mazatlanensis",
    "Mammillaria Pectinifera",
    "Astrophytum Asterias",
    "Astrophytum Capricorne",
    "Astrophytum Myriostigma",
    "Astrophytum Ornatum",
    "Lophophora Diffusa",
    "Lophophora Fricii",
    "Lophophora Alberto vojtechii",
    "Lophophora Jourdaniana",
    "Lophophora Koehresii",
    "Lophophora Williamsii",
    "Coryphantha Elephantidens",
    "Coryphantha Zougemaru",
    "Coryphantha Ottonis",
    "Coryphantha Retusa",
    "ยิมโนคาไลเซียม บัลเดียนัม",
    "ยิมโนคาไลเซียม อะนิซิตซิอาย แดมซิอาย",
    "ยิมโนคาไลเซียม เดนูดาตัม",
    "ยิมโนคาไลเซียม มิฮาโนวิชิอาย",
    "ยิมโนคาไลเซียม โอโชเทเรเน",
    "ยิมโนคาไลเซียม สเปกาซซินิอาย",
    "แมมมิลลาเรีย แมมขนแกะไร้หนาม",
    "แมมมิลลาเรีย แมมตะขอ",
    "แมมมิลลาเรีย แมมปุยหิมะ",
    "แมมมิลลาเรีย แมมลูกแมว",
    "แมมมิลลาเรีย แมมฮุย",
    "แมมมิลลาเรีย แมมโฉมสกาว",
    "แมมมิลลาเรีย แมมแม่เฒ่า",
    "แมมมิลลาเรีย แมมกล้วยหอม",
    "แมมมิลลาเรีย แมมหนามสับปะรด",
    "แมมมิลลาเรีย แมมหนามหวี",
    "แอสโตรไฟตัม แอสทีเรียส",
    "แอสโตรไฟตัม แคปริคอร์น",
    "แอสโตรไฟตัม ไมริโอสติกมา",
    "แอสโตรไฟตัม ออร์นาตัม",
    "โลโฟโฟรา ดิฟฟูซา",
    "โลโฟโฟรา ฟริซิอาย",
    "โลโฟโฟรา อัลเบิร์ตโต วอจเตชิอาย",
    "โลโฟโฟรา จอร์แดเนียนา",
    "โลโฟโฟรา โคห์เรซิอาย",
    "โลโฟโฟรา วิลเลียมซิอาย",
    "โครีแฟนทา เอเลแฟนติเดนส์",
    "โครีแฟนทา โซเกมารุ",
    "โครีแฟนทา ออตโตนิส",
    "โครีแฟนทา รีตูซา",
  ];

  Widget SearchDataCactusText() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return autoCompleteData.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }
              },
              optionsViewBuilder:
                  (context, Function(String) onSelected, options) {
                return Material(
                  elevation: 4,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);

                      return ListTile(
                        // title: Text(option.toString()),
                        title: SubstringHighlight(
                          text: option.toString(),
                          term: controller.text,
                          textStyleHighlight:
                              TextStyle(fontWeight: FontWeight.w700),
                        ),
                        // subtitle: Text("This is subtitle"),
                        onTap: () {
                          onSelected(option.toString());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: options.length,
                  ),
                );
              },
              onSelected: (selectedString) {
                print(selectedString);
                if (selectedString == 'Astrophytum Asterias' ||
                    selectedString == "แอสโตรไฟตัม แอสทีเรียส") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => asteriasPage()),
                  );
                } else if (selectedString == 'Astrophytum Capricorne' ||
                    selectedString == "แอสโตรไฟตัม แคปริคอร์น") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => capricornePage()),
                  );
                } else if (selectedString == 'Astrophytum Myriostigma' ||
                    selectedString == "แอสโตรไฟตัม ไมริโอสติกมา") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myriostigmaPage()),
                  );
                } else if (selectedString == 'Astrophytum Ornatum' ||
                    selectedString == "แอสโตรไฟตัม ออร์นาตัม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ornatumPage()),
                  );
                } else if (selectedString == 'Coryphantha Elephantidens' ||
                    selectedString == "โครีแฟนทา เอเลแฟนติเดนส์") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => elephantidensPage()),
                  );
                } else if (selectedString == 'Coryphantha Zougemaru' ||
                    selectedString == "โครีแฟนทา โซเกมารุ") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => zougemaruPage()),
                  );
                } else if (selectedString == 'Coryphantha Ottonis' ||
                    selectedString == "โครีแฟนทา ออตโตนิส") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ottonisPage()),
                  );
                } else if (selectedString == 'Coryphantha Retusa' ||
                    selectedString == "โครีแฟนทา รีตูซา") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => retusaPage()),
                  );
                } else if (selectedString == 'Gymnocalycium Baldianum' ||
                    selectedString == "ยิมโนคาไลเซียม บัลเดียนัม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BaldianumPage()),
                  );
                } else if (selectedString == 'Gymnocalycium Anisitsii Damsii' ||
                    selectedString == "ยิมโนคาไลเซียม อะนิซิตซิอาย แดมซิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnisitsiiDamsiiPage()),
                  );
                } else if (selectedString == 'Gymnocalycium Denudatum' ||
                    selectedString == "ยิมโนคาไลเซียม เดนูดาตัม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DenudatumPage()),
                  );
                } else if (selectedString == 'Gymnocalycium Mihanovichii' ||
                    selectedString == "ยิมโนคาไลเซียม มิฮาโนวิชิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MihanovichiiPage()),
                  );
                } else if (selectedString == 'Gymnocalycium Ochoterenae' ||
                    selectedString == "ยิมโนคาไลเซียม โอโชเทเรเน") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OchoterenaePage()),
                  );
                } else if (selectedString == 'Gymnocalycium Spegazzinii' ||
                    selectedString == "ยิมโนคาไลเซียม สเปกาซซินิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpegazziniiPage()),
                  );
                } else if (selectedString == 'Lophophora Diffusa' ||
                    selectedString == "โลโฟโฟรา ดิฟฟูซา") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => diffusaPage()),
                  );
                } else if (selectedString == 'Lophophora Fricii' ||
                    selectedString == "โลโฟโฟรา ฟริซิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => friciiPage()),
                  );
                } else if (selectedString == 'Lophophora Alberto vojtechii' ||
                    selectedString == "โลโฟโฟรา อัลเบิร์ตโต วอจเตชิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => albertovojtechiiPage()),
                  );
                } else if (selectedString == 'Lophophora Jourdaniana' ||
                    selectedString == "โลโฟโฟรา จอร์แดเนียนา") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => jourdanianaPage()),
                  );
                } else if (selectedString == 'Lophophora Koehresii' ||
                    selectedString == "โลโฟโฟรา โคห์เรซิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => koehresiiPage()),
                  );
                } else if (selectedString == 'Lophophora Williamsii' ||
                    selectedString == "โลโฟโฟรา วิลเลียมซิอาย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => williamsiiPage()),
                  );
                } else if (selectedString == 'Mammillaria Albicoma' ||
                    selectedString == "แมมมิลลาเรีย แมมขนแกะไร้หนาม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => albicomaPage()),
                  );
                } else if (selectedString == 'Mammillaria Beneckei' ||
                    selectedString == "แมมมิลลาเรีย แมมตะขอ") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BeneckeiPage()),
                  );
                } else if (selectedString == 'Mammillaria Bucareliensis' ||
                    selectedString == "แมมมิลลาเรีย แมมปุยหิมะ") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BucareliensisPage()),
                  );
                } else if (selectedString == 'Mammillaria Bocasana' ||
                    selectedString == "แมมมิลลาเรีย แมมลูกแมว") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => bocasanaPage()),
                  );
                } else if (selectedString == 'Mammillaria Huitzilopochtli' ||
                    selectedString == "แมมมิลลาเรีย แมมฮุย") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => huitzilopochtliPage()),
                  );
                } else if (selectedString == 'Mammillaria Karwinskiana' ||
                    selectedString == "แมมมิลลาเรีย แมมโฉมสกาว") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KarwinskianaPage()),
                  );
                } else if (selectedString == 'Mammillaria hahniana' ||
                    selectedString == "แมมมิลลาเรีย แมมแม่เฒ่า") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => hahnianaPage()),
                  );
                } else if (selectedString == 'Mammillaria Longimamma' ||
                    selectedString == "แมมมิลลาเรีย แมมกล้วยหอม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => longimammaPage()),
                  );
                } else if (selectedString == 'Mammillaria Mazatlanensis' ||
                    selectedString == "แมมมิลลาเรีย แมมหนามสับปะรด") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => mazatlanensisPage()),
                  );
                } else if (selectedString == 'Mammillaria Pectinifera' ||
                    selectedString == "แมมมิลลาเรีย แมมหนามหวี") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pectiniferaPage()),
                  );
                }
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                this.controller = controller;

                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    hintText: "Search Something",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: controller.text.isEmpty
                        ? GestureDetector(
                            child: Icon(Icons.close, size: 13,),
                            onTap: () {
                              controller.clear();
                              // widget.onChanged('');
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        : GestureDetector(
                            child: Icon(Icons.close, size: 13,),
                            onTap: () {
                              controller.clear();
                              // widget.onChanged('');
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String _MainSpeCactus;
  List<DropdownMenuItem<String>> _dropDownItemMainSpeCactus() {
    List<String> cactusa = [
      "Astrophytum(แอสโตรไฟตัม)",
      "Coryphantha(โครีแฟนทา)",
      "Gymnocalycium(ยิมโนคาไลเซียม)",
      "Lophophora(โลโฟโฟรา)",
      "Mammillaria(แมมมิลาเลีย)",
    ];
    return cactusa
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  String _SupSpeCactus;
  String type;
  List<DropdownMenuItem<String>> _dropDownItemSupSpeCactus() {
    if (_MainSpeCactus == 'Astrophytum(แอสโตรไฟตัม)') {
      type = 'Astrophytum';
      List<String> Astrophytum = [
        "Asterias(แอสทีเรียส)",
        "Capricorne(แคปริคอร์น)",
        "Myriostigma(ไมริโอสติกมา)",
        "Ornatum(ออร์นาตัม)",
      ];
      return Astrophytum.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )).toList();
    } else if (_MainSpeCactus == 'Coryphantha(โครีแฟนทา)') {
      type = 'Coryphantha';
      List<String> Coryphantha = [
        "Elephantidens(เอเลแฟนติเดนส์)",
        "Zougemaru(โซเกมารุ)",
        "Ottonis(ออตโตนิส)",
        "Retusa(รีตูซา)",
      ];
      return Coryphantha.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )).toList();
    } else if (_MainSpeCactus == 'Gymnocalycium(ยิมโนคาไลเซียม)') {
      type = 'Gymnocalycium';
      List<String> Gymnocalycium = [
        "Baldianum(บัลเดียนัม)",
        "Anisitsii Damsii(อะนิซิตซิอาย แดมซิอาย)",
        "Denudatum(เดนูดาตัม)",
        "Mihanovichii(มิฮาโนวิชิอาย)",
        "Ochoterenae(โอโชเทเรเน)",
        "Spegazzinii(สเปกาซซินิอาย)",
      ];
      return Gymnocalycium.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )).toList();
    } else if (_MainSpeCactus == 'Lophophora(โลโฟโฟรา)') {
      type = 'Lophophora';
      List<String> Lophophora = [
        "Diffusa(ดิฟฟูซา)",
        "Fricii(ฟริซิอาย)",
        "Alberto vojtechii(อัลเบิร์ตโต วอจเตชิอาย)",
        "Jourdaniana(จอร์แดเนียนา)",
        "Koehresii(โคห์เรซิอาย)",
        "Williamsii(วิลเลียมซิอาย)",
      ];
      return Lophophora.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )).toList();
    } else if (_MainSpeCactus == 'Mammillaria(แมมมิลาเลีย)') {
      type = 'Mammillaria';
      List<String> Mammillaria = [
        "Albicoma(อัลบิโคมา)",
        "Beneckei(เบเนเคอิ)",
        "Bucareliensis(บูอารีเลนซิ)",
        "Bocasana(โบคาซานะ)",
        "Huitzilopochtli(ฮุยต์ซิโลพอซต์ลี)",
        "Karwinskiana(คาร์วินสเกียนา)",
        "hahniana(ฮาเนียน่า)",
        "Longimamma(ลองอิมามมะ)",
        "Mazatlanensis(มาซัตลาเนนซิส)",
        "Pectinifera(เพคตินิเฟอรา)",
      ];
      return Mammillaria.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )).toList();
    } else {}
  }

  Widget _ButtonSpeCactus() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton(
            hint: Text("กรุณาเลือกสายพันธุ์หลัก"),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            value: _MainSpeCactus,
            onChanged: (newValue) {
              setState(() {
                if (_MainSpeCactus == type) {
                  _MainSpeCactus = newValue;
                  _SupSpeCactus = null;
                  type = null;
                } else {
                  _MainSpeCactus = newValue;
                  _SupSpeCactus = null;
                  type = null;
                }
                _MainSpeCactus = newValue;
                print('${_MainSpeCactus}');
              });
            },
            items: _dropDownItemMainSpeCactus(),
          ),
        ),
      ),
    );
  }

  Widget _ButtonSupSpeCactus() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text("กรุณาเลือกสายพันธุ์ย่อย"),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              value: _SupSpeCactus,
              onChanged: (newValue) {
                setState(() {
                  _SupSpeCactus = newValue;
                  print('${_SupSpeCactus}');
                  print('type ==>' + '${type}');
                });
              },
              items: _dropDownItemSupSpeCactus(),
            ),
          ),
        ),
      ),
    );
  }

  Widget SearchDataCactus() {
    return InkWell(
      onTap: () {
        if (_SupSpeCactus == null) {
          String valuename;
          if (_MainSpeCactus == "Astrophytum(แอสโตรไฟตัม)") {
            valuename = 'Astrophytum'.trim();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ShowDataModel(value: valuename),
            );
            Navigator.push(context, route);
          } else if (_MainSpeCactus == 'Coryphantha(โครีแฟนทา)') {
            valuename = 'Coryphantha'.trim();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ShowDataModel(value: valuename),
            );
            Navigator.push(context, route);
          } else if (_MainSpeCactus == 'Gymnocalycium(ยิมโนคาไลเซียม)') {
            valuename = 'Gymnocalycium'.trim();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ShowDataModel(value: valuename),
            );
            Navigator.push(context, route);
          } else if (_MainSpeCactus == 'Lophophora(โลโฟโฟรา)') {
            valuename = 'Lophophora'.trim();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ShowDataModel(value: valuename),
            );
            Navigator.push(context, route);
          } else if (_MainSpeCactus == 'Mammillaria(แมมมิลาเลีย)') {
            valuename = 'Mammillaria'.trim();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ShowDataModel(value: valuename),
            );
            Navigator.push(context, route);
          } else {
            normalDialog(context, 'โปรดเลือกสายพันธุ์หลัก หรือ สายพันธุ์หลัก+สายพันธุ์ย่อย');
          }
        } else {
          switch (_SupSpeCactus) {
            case "Asterias(แอสทีเรียส)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => asteriasPage()),
              );
              break;
            case "Capricorne(แคปริคอร์น)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => capricornePage()),
              );
              break;
            case "Myriostigma(ไมริโอสติกมา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => myriostigmaPage()),
              );
              break;
            case "Ornatum(ออร์นาตัม)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ornatumPage()),
              );
              break;
            case "Elephantidens(เอเลแฟนติเดนส์)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => elephantidensPage()),
              );
              break;
            case "Zougemaru(โซเกมารุ)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => zougemaruPage()),
              );
              break;
            case "Ottonis(ออตโตนิส)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ottonisPage()),
              );
              break;
            case "Retusa(รีตูซา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => retusaPage()),
              );
              break;
            case "Baldianum(บัลเดียนัม)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BaldianumPage()),
              );
              break;
            case "Anisitsii Damsii(อะนิซิตซิอาย แดมซิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnisitsiiDamsiiPage()),
              );
              break;
            case "Denudatum(เดนูดาตัม)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DenudatumPage()),
              );
              break;
            case "Mihanovichii(มิฮาโนวิชิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MihanovichiiPage()),
              );
              break;
            case "Ochoterenae(โอโชเทเรเน)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OchoterenaePage()),
              );
              break;
            case "Spegazzinii(สเปกาซซินิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpegazziniiPage()),
              );
              break;
            case "Diffusa(ดิฟฟูซา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => diffusaPage()),
              );
              break;
            case "Fricii(ฟริซิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => friciiPage()),
              );
              break;
            case "Alberto vojtechii(อัลเบิร์ตโต วอจเตชิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => albertovojtechiiPage()),
              );
              break;
            case "Jourdaniana(จอร์แดเนียนา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => jourdanianaPage()),
              );
              break;
            case "Koehresii(โคห์เรซิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => koehresiiPage()),
              );
              break;
            case "Williamsii(วิลเลียมซิอาย)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => williamsiiPage()),
              );
              break;
            case "Albicoma(อัลบิโคมา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => albicomaPage()),
              );
              break;
            case "Beneckei(เบเนเคอิ)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeneckeiPage()),
              );
              break;
            case "Bucareliensis(บูอารีเลนซิ)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BucareliensisPage()),
              );
              break;
            case "Bocasana(โบคาซานะ)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => bocasanaPage()),
              );
              break;
            case "Huitzilopochtli(ฮุยต์ซิโลพอซต์ลี)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => huitzilopochtliPage()),
              );
              break;
            case "Karwinskiana(คาร์วินสเกียนา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KarwinskianaPage()),
              );
              break;
            case "hahniana(ฮาเนียน่า)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => hahnianaPage()),
              );
              break;
            case "Longimamma(ลองอิมามมะ)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => longimammaPage()),
              );
              break;
            case "Mazatlanensis(มาซัตลาเนนซิส)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mazatlanensisPage()),
              );
              break;
            case "Pectinifera(เพคตินิเฟอรา)":
              // _MainSpeCactus = null;
              _SupSpeCactus = null;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pectiniferaPage()),
              );
              break;
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'ค้นหาสายพันธุ์แคคตัส',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาสายพันธุ์'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG03.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            // height: height,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      SearchDataCactusText(),
                      SizedBox(height: 15),
                      _ButtonSpeCactus(),
                      SizedBox(height: 10),
                      _ButtonSupSpeCactus(),
                      SizedBox(height: 15),
                      SearchDataCactus(),
                      SizedBox(
                        height: 500,
                      )
                    ],
                  ),
                ),
                // Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
