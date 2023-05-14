import 'package:flutter/material.dart';
import 'package:soft/HomePgae.dart';
import 'history.dart';
import 'fav.dart';


class ProfilePage extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String image;// Add an int property to the class
  const ProfilePage({Key? key, required this.id, required this.name, required this.email , required this.image}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  String fullName = 'Ziad Yaser Morsi';
  String email = 'ziad.yaser@example.com';
  String mobileNumber = '01234567890';
  String location = 'Damanhour, Beheira, Egypt';


  void _handleEdit() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          fullName: widget.name,
          email: widget.email,
          mobileNumber: mobileNumber,
          location: location,
        ),
      ),
    ).then((value) {


      setState(() {
        fullName = value['fullName'];
        email = value['email'];
        mobileNumber = value['mobileNumber'];
        location = value['location'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "My Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homepage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              Offset popupPosition = Offset(MediaQuery.of(context).size.width - 50, 50);
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    popupPosition.dx, popupPosition.dy, 0, 0),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(width: 10),
                          Text('Favorite'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Favorite()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 10),
                          Text('History'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => history(id: 15,)),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "${widget.image}",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                          ),
                          child: TextButton(
                            onPressed: _handleEdit,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 70),
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 0),
              Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 0),
              Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(widget.email, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 )),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 0),
              Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(mobileNumber , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 0),
              Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(location , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[200],
                ),

                  child: Text(''),
              ),
              TextButton(

                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController currentPasswordController = TextEditingController();
                      TextEditingController newPasswordController = TextEditingController();
                      TextEditingController confirmNewPasswordController = TextEditingController();

                      return AlertDialog(
                        title: Text('Change Password'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter current password',
                              ),
                              obscureText: true,
                              controller: currentPasswordController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter new password',
                              ),
                              obscureText: true,
                              controller: newPasswordController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Confirm new password',
                              ),
                              obscureText: true,
                              controller: confirmNewPasswordController,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            ),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String newPassword = newPasswordController.text;
                              String confirmNewPassword = confirmNewPasswordController.text;

                              if (newPassword == confirmNewPassword) {
                                // Passwords match, save changes
                              } else {
                                // Passwords don't match, show error message
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Password Error!'),
                                      content: Text('Password doesn\'t match!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            ),
                            child: Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Center(
                  child: Text(
                    'Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
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
}

class EditProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String location;

  EditProfilePage({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.location,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.fullName;
    _emailController.text = widget.email;
    _mobileNumberController.text = widget.mobileNumber;
    _locationController.text = widget.location;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit Profile         ')),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _fullNameController,
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _emailController,
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _mobileNumberController,
              ),
              SizedBox(height: 16),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _locationController,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {

                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'fullName': _fullNameController.text,
                        'email': _emailController.text,
                        'mobileNumber': _mobileNumberController.text,
                        'location': _locationController.text,
                      });
                    },
                    child: Text('  Save  '),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}