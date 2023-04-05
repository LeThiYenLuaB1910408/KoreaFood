import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import 'dialog.dart';

class UserEditProfile extends StatefulWidget {
  User user;
  UserEditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  late User _editUser;
  File? _image;

  final _editForm = GlobalKey<FormState>();
  var _isLoading = false;

  @override
  void initState() {
    _editUser = widget.user;
    super.initState();
  }

  Future getImage(src) async {
    final image = await ImagePicker().pickImage(source: src);
    if (image == null) return;

    // final imageTemporary = File(image.path);

    final imagePermanent = await saveFilePermanently(image.path);
    _editUser = _editUser.copyWith(
        hinh_anh_tai_khoan: 'user/${p.basename(image.path)}');
    setState(() {
      this._image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = p.basename(imagePath);
    final img = File('${directory.path}/$name');
    print('${directory.path}/$name');
    return File(imagePath).copy(img.path);
  }

  TextFormField buildNameFied() {
    return TextFormField(
      initialValue: _editUser.ho_ten,
      decoration: const InputDecoration(labelText: 'Name'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editUser = _editUser.copyWith(ho_ten: value);
      },
    );
  }

  Widget buildAddressFied() {
    return TextFormField(
      initialValue: _editUser.dia_chi,
      decoration: const InputDecoration(labelText: 'Address'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editUser = _editUser.copyWith(dia_chi: value);
      },
    );
  }

  TextFormField buildID() {
    return TextFormField(
      initialValue: _editUser.cccd,
      decoration: const InputDecoration(labelText: 'CCCD'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a CCCD.';
        }
        return null;
      },
      onSaved: (value) {
        _editUser = _editUser.copyWith(cccd: value);
      },
    );
  }

  TextFormField buildPhone() {
    return TextFormField(
      initialValue: _editUser.so_dien_thoai,
      decoration: const InputDecoration(labelText: 'Phone'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a phone.';
        }
        return null;
      },
      onSaved: (value) {
        _editUser = _editUser.copyWith(so_dien_thoai: value);
      },
    );
  }

  TextButton buildDate(context) {
    return TextButton(
      onPressed: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: _editUser.ngay_sinh as DateTime,
          firstDate: DateTime(1960),
          lastDate: DateTime(2005),
        );
        if (newDate == null) return;
        setState(() {
          _editUser.ngay_sinh = newDate;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.yMMMd().format(_editUser.ngay_sinh),
            style: poppins.copyWith(fontSize: 15, color: Colors.black),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            Icons.date_range,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget buildImageURLField() {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Chọn Ảnh Thư Viện',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () => getImage(ImageSource.camera),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Truy Cập Máy Ảnh',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget buildUserPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          margin: const EdgeInsets.only(top: 8, right: 10),
          child: _image == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/${_editUser.hinh_anh_tai_khoan}',
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(child: buildImageURLField()),
      ],
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final usersManager = context.read<UserManager>();
      await usersManager.updateUser(_editUser, _image);
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => UserPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 225, 207, 41),
          title: const Text(
            'Edit User',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          actions: [
            IconButton(
              onPressed: () => _saveForm(),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _editForm,
                  child: ListView(
                    children: [
                      buildUserPreview(),
                      SizedBox(height: 10),
                      buildNameFied(),
                      buildAddressFied(),
                      SizedBox(height: 10),
                      buildPhone(),
                      buildID(),
                      buildDate(context),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
