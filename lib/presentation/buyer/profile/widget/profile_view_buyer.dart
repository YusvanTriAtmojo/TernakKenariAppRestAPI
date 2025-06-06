import 'package:flutter/material.dart';
import 'package:kenari_app/core/core.dart';
import 'package:kenari_app/data/model/response/buyer/buyer_profile_response_model.dart';
import 'package:kenari_app/presentation/buyer/home/buyer_home_screen.dart';

class ProfileViewBuyer extends StatelessWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${profile.name}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Alamat: ${profile.address}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              "No HP: ${profile.phone}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.pushAndRemoveUntil(
                  const BuyerHomeScreen(),
                  (route) => false,
                );
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
