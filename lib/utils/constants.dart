class Constants {
  
  static const String apiKey = '94e182d73c0e41f3838b0cc0bc41020c';
  static const String topHeadLines = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

  static String headlinesFor(String country) {
    return 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
  }

  static const Map<String, String> countries = {
    "USA" : "us",
    "India" : "in",
    "Korea" : "kr",
    "China" : "ch"
  };
}