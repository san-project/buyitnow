import 'package:buyitnow/screens/edit_profile/edit_profile_screen.dart';
import 'package:buyitnow/screens/order_history/order_history_screen.dart';
import 'package:buyitnow/screens/wishlist/wishlist_screen.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:buyitnow/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/check_login.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileProvider>().getProfileDetails(context);
    });
    super.initState();
  }

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
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        if (provider.isLoading || provider.user == null) {
          return const Center(
            child: LoadingWidget(),
          );
        } else {
          return Column(
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
                        provider.user!.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        provider.user!.email,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 25.h),
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()));
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
                          ListTile(
                            onTap: () async {
                              final isLoggedIn =
                                  await checkLogin(context) ?? false;
                              if (isLoggedIn && context.mounted) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const WishlistScreen()));
                              }
                            },
                            title: const Text('Wishlist'),
                            leading: const Icon(Icons.favorite_sharp),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderHistoryScreen()));
                            },
                            title: const Text('Order History'),
                            leading: const Icon(Icons.history),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              context
                                  .read<AuthProvider>()
                                  .logOut()
                                  .then((value) {
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
          );
        }
      }),
    );
  }
}
