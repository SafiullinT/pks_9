import 'package:flutter/material.dart';
import '../models/car.dart';
import '../service/api_service.dart';

class AddCarScreen extends StatefulWidget {
  final Function onAddCar;

  AddCarScreen({required this.onAddCar});

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  String _name = '';
  String _imageUrl = '';
  double _price = 0;
  String _description = '';
  String _power = '';
  String _acceleration = '';
  String _engineType = '';
  int _maxSpeed = 0;

  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      Car newCar = Car(
        _name,
        _imageUrl,
        _price,
        _description,
        _power,
        _acceleration,
        _engineType,
        _maxSpeed,
        isFavorite: false,
        quantity: 1,
      );

      setState(() {
        _isLoading = true;
      });

      try {

        await _apiService.createCar(newCar);


        widget.onAddCar(newCar);


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ваше авто успешно добавлено')),
        );


        Navigator.pop(context);
      } catch (e) {

      } finally {

        setState(() {
          _isLoading = false;
          widget.onAddCar(newCar);
          Navigator.pop(context);
        });
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить автомобиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Название автомобиля'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'URL картинки'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите URL картинки';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _imageUrl = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Цена'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите цену';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Описание'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите описание';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Мощность'),
                  onSaved: (value) {
                    _power = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Разгон до 100 км/ч'),
                  onSaved: (value) {
                    _acceleration = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Тип двигателя'),
                  onSaved: (value) {
                    _engineType = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Максимальная скорость'),
                  onSaved: (value) {
                    _maxSpeed = int.parse(value!);
                  },
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Добавить автомобиль'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
