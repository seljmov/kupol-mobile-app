import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/components/plume_model.dart';

class PlumeDetailsScreen extends StatefulWidget {
  PlumeDetailsScreen({Key? key, this.plume}) : super(key: key);

  final Plume? plume;

  @override
  _PlumeDetailsScreenState createState() => _PlumeDetailsScreenState();
}

class _PlumeDetailsScreenState extends State<PlumeDetailsScreen> {
  var idController = TextEditingController();
  var locationController = TextEditingController();

  @override
  void initState() {
    if (widget.plume != null) {
      idController.text = widget.plume!.id.toString();
      locationController.text = widget.plume!.location;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => catchFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.plume == null ? "Добавить шлейф" : "Изменить шлейф",
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          padding: kDetailScreenPadding,
          physics: kDefaultPhysics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.w600,
                ),
                controller: idController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Идентификатор",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.w600,
                ),
                controller: locationController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Локация",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: Text("Сохранить"),
              ),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
