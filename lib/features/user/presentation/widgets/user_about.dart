import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.getUserStatus == GetUserStatus.done) {
          setState(() {
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
                      onTap: () {
                        _controller.reverse();
                        setState(() {
                          _isExpanded = false;
                        });
                      },
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
                  children: [
                    _buildUploadBtn(),
                    const SizedBox(height: 24,),
                    _buildTextfield(
                      label: "Display Name:",
                      hintText: "Enter Name",
                      controller: nameController
                    ),
                    _buildTextfield(
                      label: "Birthday:",
                      hintText: "DD MM YYYY",
                      controller: birthdayController,
                      readOnly: true
                    ),
                    _buildTextfield(
                      label: "Horoscope:",
                      hintText: "--",
                      controller: horoscopeController,
                      disabled: true,
                      readOnly: true,
                    ),
                    _buildTextfield(
                      label: "Zodiac:",
                      hintText: "--",
                      controller: zodiacController,
                      disabled: true,
                      readOnly: true
                    ),
                    _buildTextfield(
                      label: "Height:",
                      hintText: "0",
                      controller: heightController
                    ),
                    _buildTextfield(
                      label: "Weight:",
                      hintText: "0",
                      controller: weightController
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !_isExpanded && state.email != "--",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(label: "Birthday:", value: state.birthday),
                    _buildField(label: "Horoscope:", value: state.horoscope),
                    _buildField(label: "Zodiac:", value: state.zodiac),
                    _buildField(label: "Height:", value: "${state.height} cm"),
                    _buildField(label: "Weight:", value: "${state.weight} kg"),
                  ],
                ),
              ),
              Visibility(
                visible: state.getUserStatus == GetUserStatus.loading && state.email == "--",
                child: const Text(
                  "Add in yours to help others know you\nbetter",
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
  dynamic value
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14.0),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white60),
          )
        ),
        const SizedBox(width: 24,),
        Expanded(
          child: Text("$value"),
        ),
      ],
    ),
  );
}

Widget _buildTextfield({
  required String label,
  String? hintText,
  TextEditingController? controller,
  bool? readOnly = false,
  bool? disabled = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0, right: 8),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white60),
          )
        ),
        const SizedBox(width: 24,),
        Expanded(
          child: TextFormField(
            key: Key(label),
            readOnly: readOnly!,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: disabled! ? Colors.white24 : Colors.white
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(width: 1, color: Colors.white24)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(width: 1, color: Colors.white24)
              ),
              contentPadding: const EdgeInsets.only(right: 16)
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUploadBtn() {
  return Row(
    children: [
      InkWell(
        key: const Key("btn-upload"),
        onTap: () {},
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(22)
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