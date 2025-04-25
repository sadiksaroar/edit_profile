import 'package:flutter/material.dart';

void main() => runApp(EditProfileApp());

class EditProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(
    text: "Aklima akter",
  );
  TextEditingController phoneController = TextEditingController(
    text: "01234567890",
  );
  TextEditingController emailController = TextEditingController(
    text: "Aklimaakter@gmail.com",
  );
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String countryCode = "+1"; // default country code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "User Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(
                                "assets/profile.jpg",
                              ), // replace with your image
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        _buildTextField("Full Name", nameController),
                        SizedBox(height: 12),
                        _buildPhoneField(),
                        SizedBox(height: 12),
                        _buildTextField(
                          "Email Address",
                          emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12),
                        _buildTextField(
                          "Old Password",
                          oldPasswordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 12),
                        _buildTextField(
                          "Update Password",
                          newPasswordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform update logic here
                              }
                            },
                            child: Text("Update Profile"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) => value!.isEmpty ? "Please enter $label" : null,
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: countryCode,
            underline: SizedBox(),
            items:
                ["+1", "+91", "+44", "+880"].map((code) {
                  return DropdownMenuItem<String>(
                    value: code,
                    child: Text(code),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                countryCode = value!;
              });
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator:
                (value) => value!.isEmpty ? "Please enter phone number" : null,
          ),
        ),
      ],
    );
  }
}
