import 'package:compliments_app/router/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/compliment_provider.dart';
import '../styles/app_dimens.dart';
import '../styles/colors.dart';
import '../widgets/compliment_button.dart';
import '../widgets/compliments_summ.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _ComplimentScreenState createState() => _ComplimentScreenState();
}

class _ComplimentScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(complimentListProvider.notifier).loadCompliments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final complimentList = ref.watch(complimentListProvider);
    var screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: complimentList.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ComplimentsSumm(compliments: complimentList),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ComplimentButton(
                        text: 'CREATE',
                        onPressed: () => context.push(ScreenRoutes.newCompliment),
                      ),
                    ],
                  ),
                  SizedBoxHeight10,
                  const Text(
                    'OR CHOOSE',
                    style: TextStyle(
                      color: AppColors.appTextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBoxHeight10,
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                    child: Container(
                      child: ListView.builder(
                        itemCount: complimentList.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: const EdgeInsets.fromLTRB(25, 2, 25, 2),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                                child: Center(
                                  child: Text(
                                    "'" + complimentList[index].description + "'",
                                    style: TextStyle(
                                      color: AppColors.appTextColor,
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                context.push(ScreenRoutes.share, extra: complimentList[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBoxHeight10,
                  ComplimentButton(
                    text: 'SHUFFLE',
                    onPressed: () {
                      ref.read(complimentListProvider.notifier).shuffleCompliments();
                    },
                  ),
                  SizedBoxHeight10,
                ],
              ),
      ),
    );
  }
}
