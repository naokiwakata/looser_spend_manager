import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/root/ui/root_page_controller.dart';

import '../../router/app_router.gr.dart';

@RoutePage()
class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootServiceController = ref.watch(rootControllerProvider);
    return ref.watch(authUserStreamProvider).when(
          error: (e, st) => Center(
            child: Text(e.toString()),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          data: (user) {
            useEffect(() {
              if (user == null) {
                rootServiceController.signIn();
              } else {
                rootServiceController.createUser(user.uid);
              }
              [user];
              return null;
            });

            return AutoTabsRouter(
              routes: const [
                HomeRoute(),
                SettingsRoute(),
              ],
              builder: (context, child) {
                final tabsRouter = context.tabsRouter;
                return Scaffold(
                  body: child,
                  bottomNavigationBar: NavigationBar(
                    selectedIndex: tabsRouter.activeIndex,
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                    onDestinationSelected: tabsRouter.setActiveIndex,
                  ),
                );
              },
            );
          },
        );
  }
}
