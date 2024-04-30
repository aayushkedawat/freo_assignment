class Urls {
  static const baseUrl = 'https://en.wikipedia.org';

  static const noDataAnimationUrl =
      'https://lottie.host/d6372b13-6855-40f1-a62b-3affc351a066/aZLrLGyGlf.json';
  static String searchWikiByQuery(String query) =>
      '$baseUrl//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=40&wbptterms=description&gpssearch=$query&gpslimit=20';
}
