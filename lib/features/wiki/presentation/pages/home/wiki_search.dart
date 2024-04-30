import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/util/connectivity_check.dart';
import '../../../../../core/util/snackbar_widget.dart';
import '../../bloc/wiki/local/local_wiki_bloc.dart';
import '../../bloc/wiki/local/local_wiki_event.dart';
import '../../bloc/wiki/remote/remote_wiki_bloc.dart';
import '../../bloc/wiki/remote/remote_wiki_event.dart';
import '../../bloc/wiki/remote/remote_wiki_state.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/page_display_item.dart';
import '../local/saved_pages.dart';
import '../web/wiki_webview.dart';

class WikiSearchScreen extends StatelessWidget {
  const WikiSearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.buildAppBar(
        title: Strings.appTitle,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SavedPagesScreen(),
              ));
            },
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (query) {
              BlocProvider.of<RemoteWikiBloc>(context)
                  .add(OnQueryChanged(query: query));
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: Text(
                  Strings.enterQueryHere,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<RemoteWikiBloc, RemoteWikiState>(
            builder: (context, state) {
              if (state is RemoteWikiLoading) {
                return Expanded(
                  child: Center(
                    child: Lottie.asset(Assets.loadingAnimationLottie),
                  ),
                );
              } else if (state is RemoteWikiDone) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.pages?.length ?? 0,
                    itemBuilder: (context, index) {
                      return PageDisplayItem().pageDisplayItem(
                        state.pages![index],
                        trailing: IconButton(
                            onPressed: () {
                              BlocProvider.of<LocalPageBloc>(context)
                                  .add(SaveWikiEvent(state.pages![index]));
                              SnackBarWidget.showSnackBar(
                                  context, Strings.bookmarkAdded);
                            },
                            icon: const Icon(Icons.bookmark)),
                        onTap: () async {
                          if (await ConnectivityCheck.isConnected()) {
                            if (!context.mounted) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  url: state.pages?[index].pageid.toString() ??
                                      '',
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
                      );
                    },
                  ),
                );
              } else if (state is RemoteWikiError) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(Assets.errorAnimationLottie),
                      Text(state.error?.message ?? '')
                    ],
                  ),
                );
              } else if (state is RemoteWikiInitial) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(Assets.searchAnimationLottie),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
