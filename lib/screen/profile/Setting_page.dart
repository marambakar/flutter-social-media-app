import 'package:flutter/material.dart';
import 'package:pronz/screen/profile/EditProfile.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../config.dart';
class Setting_page extends StatefulWidget{
  @override
  State createState() => _Setting();
}
enum Languages { Arabic, English }
class _Setting extends State<Setting_page>
{
   Languages selectedLanguage;
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
       // leading: Icon(Icons.arrow_back),
        backgroundColor: Color_green,
        title: Text("Setting"),),
      body: Container(
        child: ListView(
         children: <Widget>[
           ListTile(
             title:Text(LocaleKeys.Editlanguage.tr()),
            onTap:() async {
               // print("chaaange the laaan");
               //  await context.setLocale(Locale('ar'));
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                btnOkColor: Colors.grey,
                dialogType: DialogType.NO_HEADER,
                padding: EdgeInsets.all(10),
                body: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        RadioListTile<Languages>(
                          title: const Text('العربية'),
                          value: Languages.Arabic,
                          groupValue: selectedLanguage,
                          onChanged: (Languages value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        ),
                        RadioListTile<Languages>(
                          title: const Text('English'),
                          value: Languages.English,
                          groupValue: selectedLanguage,
                          onChanged: (Languages value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                title: 'This is Ignored',
                desc: 'This is also Ignored',
                btnOkOnPress: () {
                  if (selectedLanguage == Languages.Arabic) {
                    if (context.locale != Locale('ar'))
                      setState(() {
                        context.setLocale(Locale('ar'));
                      });
                  } else {
                    if (context.locale != Locale('en'))
                      setState(() {
                        context.setLocale(Locale('en'));
                      });
                  }
                },
              )..show();
      },

           ),
           Divider(height: 12,color: Colors.grey ,),
           ListTile( title: Text(LocaleKeys.EditProfile.tr()) ,
  onTap: (){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>EditProfile()) //LocationAllowPage(temp:widget.temp))
    );
  },
           ),
           Divider(height: 15,color: Colors.grey),

         ],
        )
      ) );
  }

}