import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../router/app_router.gr.dart';
import 'root_page_controller.dart';

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
          loading: () => const Center(
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox.expand(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          data: (user) {
            useEffect(
              () {
                if (user == null) {
                  rootServiceController.signIn();
                } else {
                  rootServiceController.createUser(user.uid);
                }
                return null;
              },
              [user],
            );

            return AutoTabsRouter(
              routes: const [
                AddRoute(),
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
                        icon: Icon(Icons.add),
                        label: '追加',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.list),
                        label: 'リスト',
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
