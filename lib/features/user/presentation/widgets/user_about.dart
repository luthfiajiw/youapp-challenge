import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';
import 'package:youapp_challenge/core/widgets/screen_loading.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/about_textfield.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/edit_button.dart';

class UserAbout extends StatefulWidget {
  const UserAbout({super.key});

  @override
  State<UserAbout> createState() => _UserAboutState();
}

class _UserAboutState extends State<UserAbout> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Tween<double> _sizeTween;
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController horoscopeController = TextEditingController();
  TextEditingController zodiacController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn
    );
    _sizeTween = Tween(begin: 0, end: 1);

    super.initState();
  }

  void handleSubmit(BuildContext context, UserState state) {
    final form = FormUserEntity(
      name: nameController.text,
      birthday: birthdayController.text,
      height: heightController.text.isEmpty ? 0 : int.parse(heightController.text),
      weight: weightController.text.isEmpty ? 0 : int.parse(weightController.text),
      interests: state.interests!,
    );

    FocusScope.of(context).unfocus();
    showScreenLoading(context);
    context.read<UserCubit>().onPutUser(form);
  }

  void pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery)
      .then((image) {
        if (image != null) {
          context.read<UserCubit>().onChangeImage(image);
        }
      });
  }

  Future<void> pickDate(BuildContext context, String birthday) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthday.isEmpty ? DateTime.now() : DateTime.parse(birthday),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              onSurface: Colors.white
            )
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      birthdayController.text = formattedDate;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (previous, current) {
        return previous.getUserStatus != current.getUserStatus || previous.putUserStatus != current.putUserStatus;
      },
      listener: (context, state) {
        if (state.putUserStatus == PutUserStatus.done) {
          context.read<UserCubit>().onGetUser();
        }
        if (state.getUserStatus == GetUserStatus.done) {
          _controller.reverse();
          setState(() {
             _isExpanded = false;
            nameController.text = state.name!;
            birthdayController.text = state.birthday!;
            horoscopeController.text = state.horoscope!;
            zodiacController.text = state.zodiac!;
            heightController.text = state.height!.toString();
            weightController.text = state.weight!.toString();
          });
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.05)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded,
                    replacement: EditButton(
                      key: const Key("btn-edit-about"),
                      onTap: () {
                        _controller.forward();
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                    ),
                    child: InkWell(
                      key: const Key("btn-save-about"),
                      onTap: () => handleSubmit(context, state),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GradientText(
                          text: Text(
                            "Save & Update",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: _isExpanded ? 18 : 16,),
              SizeTransition(
                sizeFactor: _sizeTween.animate(_animation),
                child: Column(
                  key: const Key("form-about"),
                  children: [
                    _buildUploadBtn(
                      image: state.image,
                      onTap: pickImage
                    ),
                    const SizedBox(height: 24,),
                    AboutTextField(
                      label: "Display Name:",
                      hintText: "Enter Name",
                      controller: nameController
                    ),
                    AboutTextField(
                      label: "Birthday:",
                      hintText: "DD MM YYYY",
                      controller: birthdayController,
                      readOnly: true,
                      onTap: () {
                        pickDate(context, state.birthday!);
                      },
                    ),
                    AboutTextField(
                      label: "Horoscope:",
                      hintText: "--",
                      controller: horoscopeController,
                      disabled: true,
                      readOnly: true,
                    ),
                    AboutTextField(
                      label: "Zodiac:",
                      hintText: "--",
                      controller: zodiacController,
                      disabled: true,
                      readOnly: true
                    ),
                    AboutTextField(
                      label: "Height:",
                      hintText: "0",
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      suffix: const Text(
                        "cm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    AboutTextField(
                      label: "Weight:",
                      hintText: "0",
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      suffix: const Text(
                        "kg",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !_isExpanded && state.email!.isNotEmpty,
                child: Column(
                  key: const Key("section-about"),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      label: "Birthday:",
                      value: state.birthday!.isEmpty ? "--" : "${DateFormat("dd / MM / yyyy").format(DateTime.parse(state.birthday!))} (Age ${state.age})"
                    ),
                    _buildField(label: "Horoscope:", value: state.horoscope),
                    _buildField(label: "Zodiac:", value: state.zodiac),
                    _buildField(label: "Height:", value: "${state.height} cm"),
                    _buildField(label: "Weight:", value: "${state.weight} kg"),
                  ],
                ),
              ),
              Visibility(
                visible: state.email!.isEmpty,
                child: const Text(
                  "Add in yours to help others know you\nbetter",
                  key: Key("initial-about"),
                  style: TextStyle(color: Colors.white60),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget _buildField({
  required String label,
  Key? key,
  dynamic value
}) {
  return Padding(
    key: key,
    padding: const EdgeInsets.only(bottom: 14.0),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white60),
        ),
        const SizedBox(width: 8,),
        Text("$value"),
      ],
    ),
  );
}

Widget _buildUploadBtn({
  VoidCallback? onTap,
  XFile? image
}) {
  return Row(
    children: [
      InkWell(
        key: const Key("btn-upload"),
        onTap:onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(22),
            image: image == null ? null : DecorationImage(
              image: FileImage(File(image.path)),
              fit: BoxFit.cover
            )
          ),
          child: const GradientIcon(
            icon: Icon(Icons.add_rounded, size: 40,),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text("Add Image"),
      )
    ],
  );
}