import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headlinehub/model/categories_news_model.dart';
import 'package:headlinehub/model/news_view_model.dart';
import 'package:headlinehub/screen/home_screen.dart';
import 'package:intl/intl.dart';

class Categoryscreen extends StatefulWidget {
  final String selectedSource;
  const Categoryscreen({super.key, required this.selectedSource});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat("yyyy-MM-dd");
  String categoryName = 'general';

  List<String> btnCategories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            Text("Categories", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: btnCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        categoryName = btnCategories[index].toLowerCase();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          categoryName == btnCategories[index].toLowerCase()
                              ? Colors.blue
                              : Colors.grey,
                    ),
                    child: Text(
                      btnCategories[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<CategoryNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi(
                  categoryName, widget.selectedSource),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitSpinningLines(
                      color: Colors.white,
                      size: 60.0,
                      lineWidth: 3.5,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
                  return Center(
                    child: Text(
                      "No News Available",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data!.articles![index];
                    DateTime date =
                        DateTime.parse(article.publishedAt.toString());
                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: article.urlToImage != null
                            ? Image.network(article.urlToImage!,
                                width: 80, height: 80, fit: BoxFit.cover)
                            : Container(
                                width: 80, height: 80, color: Colors.grey),
                        title: Text(
                          article.title ?? "No Title",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${article.author ?? 'Unknown Author'} | ${format.format(date)}",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                imageUrl: article.urlToImage ?? "",
                                title: article.title ?? "No Title",
                                description:
                                    article.description ?? "No Description",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
