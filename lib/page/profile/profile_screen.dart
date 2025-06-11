import 'package:flutter/material.dart';
import 'package:flutter_ecomm/constants/sizes_string.dart';
import 'package:flutter_ecomm/page/profile/profile_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../controllers/authentication.dart';
import '../../main_screen.dart';
import '../../utils/app_styles.dart';
import '../login/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationController _authController = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeMain()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/profile/sdachgame.jpg"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Edit Profile logic
                      },
                      child: const Text("Edit Profile"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Heading Profile Info
              const Text(
                "Profile Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Name', value: 'Chansokleap', onPressed: (){}),
              TProfileMenu(title: 'Username', value: 'Chansokleap', onPressed: (){}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Heading Personal Info
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),


              TProfileMenu(title: 'User ID', value: '00001', icon: Iconsax.copy, onPressed: (){}),
              TProfileMenu(title: 'Email', value: 'Chansokleap', onPressed: (){}),
              TProfileMenu(title: 'Phone Number', value: '+855-12345678', onPressed: (){}),
              TProfileMenu(title: 'Gender', value: 'Male', onPressed: (){}),
              TProfileMenu(title: 'Date of Birth', value: '15 March, 2004', onPressed: (){}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Log Out'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await _authController.logout();
                    }
                  },
                  child: const Text('Log Out',style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


