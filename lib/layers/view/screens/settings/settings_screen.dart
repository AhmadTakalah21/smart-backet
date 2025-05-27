import 'package:flutter/material.dart';
import 'package:fresh_shelf/core/ui/responsive_text.dart';
import 'package:fresh_shelf/core/utils/size_config.dart';
import 'package:fresh_shelf/layers/view/screens/settings/widgets/settings_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/routing/route_path.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  signOut(BuildContext context) async {
    await Future.wait([
      Provider.of<AppState>(context, listen: false).removeUser(),
      sl.reset(dispose: false)
    ]);
    initInjection();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RoutePaths.LogIn, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints:
                      BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.6),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Styles.colorPrimary.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Builder(builder: (context) {
                    final email = Provider.of<AppState>(context, listen: true)
                        .user!
                        .email;
                    return ResponsiveText(
                      textWidget: Text(
                        email,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () => signOut(context),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).logout,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 25,
                      )
                    ],
                  ),
                )
              ],
            ),
            CommonSizes.vSmallSpace,
            SettingsCard(
              icon: Icons.language,
              title: S.of(context).appLanguage,
              fun: () => {
                Navigator.of(context).pushNamed(RoutePaths.AppLanguageScreen)
              },
            ),
            CommonSizes.vSmallSpace,
            SettingsCard(
              icon: Icons.person,
              title: S.of(context).profile,
              fun: () =>
                  {Navigator.of(context).pushNamed(RoutePaths.UpdateProfile)},
            ),
            CommonSizes.vSmallSpace,
            SettingsCard(
              icon: Icons.location_on,
              title: S.of(context).address,
              fun: () =>
                  {Navigator.of(context).pushNamed(RoutePaths.AddressScreen)},
            ),
            CommonSizes.vSmallSpace,
            SettingsCard(
              icon: Icons.receipt,
              title: S.of(context).bills,
              fun: () =>
                  {Navigator.of(context).pushNamed(RoutePaths.BillsScreen)},
            ),
          ],
        ),
      ),
    );
  }
}
