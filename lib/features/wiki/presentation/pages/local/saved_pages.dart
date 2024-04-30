import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freo_assignment/core/constants/assets.dart';
import 'package:freo_assignment/core/constants/strings.dart';
import 'package:lottie/lottie.dart';

import 'package:freo_assignment/core/util/snackbar_widget.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_state.dart';
import 'package:freo_assignment/features/wiki/presentation/widgets/app_bar.dart';
import 'package:freo_assignment/features/wiki/presentation/widgets/page_display_item.dart';

import '../../../../../core/util/connectivity_check.dart';
import '../web/wiki_webview.dart';

class SavedPagesScreen extends StatelessWidget {
  const SavedPagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocalPageBloc>(context).add(const GetSavedWikiEvent());
    return Scaffold(
      appBar: CommonAppBar.buildAppBar(title: Strings.savedPages),
      body: BlocBuilder<LocalPageBloc, LocalPageState>(
        builder: (context, state) {
          if (state is LocalPagesDone) {
            if (state.pages?.isEmpty ?? true) {
              return Center(
                child: Lottie.asset(Assets.noDataAnimationLottie),
              );
            }
            return ListView.builder(
                itemCount: state.pages?.length ?? 0,
                itemBuilder: (context, index) {
                  PageEntity pageEntity = state.pages![index];
                  return PageDisplayItem().pageDisplayItem(
                    pageEntity,
                    onTap: () async {
                      if (await ConnectivityCheck.isConnected()) {
                        if (!context.mounted) return;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              url: state.pages?[index].pageid.toString() ?? '',
                              name: state.pages?[index].title ?? '',
                            ),
                          ),
                        );
                      } else {
                        if (!context.mounted) return;
                        SnackBarWidget.showSnackBar(
                            context, Strings.noInternet);
                      }
                    },
                    trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<LocalPageBloc>(context)
                            .add(RemoveWikiEvent(pageEntity));
                        SnackBarWidget.showSnackBar(
                            context, 'Bookmark removed successfully');
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                });
          } else if (state is LocalPagesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
