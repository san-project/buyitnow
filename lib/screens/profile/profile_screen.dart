import 'package:buyitnow/screens/edit_profile/edit_profile_screen.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text(
          'profile',
          style: TextStyle(color: AppColors.priceColor, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: NetworkImage(
                            'https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'satyam Gupta',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'satyam@gmail.com',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xffe5e5e9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                        },
                        title: const Text('Edit Profile'),
                        leading: const Icon(Icons.person),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      const ListTile(
                        title: Text('Shopping Address'),
                        leading: Icon(Icons.location_pin),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      const ListTile(
                        title: Text('Wishlist'),
                        leading: Icon(Icons.favorite_sharp),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      const ListTile(
                        title: Text('Order History'),
                        leading: Icon(Icons.history),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          context.read<AuthProvider>().logOut().then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SiginPage(),
                                ),
                                (route) => false);
                          });
                        },
                        title: const Text('Logout'),
                        leading: const Icon(Icons.logout),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
