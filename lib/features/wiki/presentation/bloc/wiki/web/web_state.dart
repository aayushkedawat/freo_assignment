abstract class WebState {
  bool isLoading;
  WebState(this.isLoading);
}

class WebLoadingState extends WebState {
  WebLoadingState(super.isLoading);
}
