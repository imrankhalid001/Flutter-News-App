import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:flutter_news_app/view/categories_screen.dart';
import 'package:flutter_news_app/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


enum FilterList { bbcNews, USAToday, Axios, FoxNews, cnn, Engadget,CNBC, ABCNews}


class _HomeScreenState extends State<HomeScreen> {

NewsViewModel newsViewModel = NewsViewModel();

FilterList? selectedMenu;

String name = 'bbc-news';

final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {

final wight = MediaQuery.sizeOf(context).width *1;
final height = MediaQuery.sizeOf(context).height *1;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoriesScreen()));
          },
          icon: Image.asset('images/category_icon.png',
        height: 30,
        width: 30,)),
        title: Text('News', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
             initialValue : selectedMenu,
             icon : Icon(Icons.more_vert, color: Colors.black,),
             onSelected: (FilterList item){

              if(FilterList.bbcNews.name == item.name)
              {
                name = 'bbc-news';
              }

              
              if(FilterList.cnn.name == item.name)
              {
                name = 'cnn';
              }

         
              if(FilterList.USAToday.name == item.name)
              {
                name = 'usa-today';
              }

               
              if(FilterList.Engadget.name == item.name)
              {
                name = 'engadget';
              }

 
              if(FilterList.Axios.name == item.name)
              {
                name = 'axios';
              }

              if(FilterList.FoxNews.name == item.name)
              {
                name = 'fox-news';
              }
 
              if(FilterList.ABCNews.name == item.name)
              {
                name = 'abc-news';

                print(name);
              }




              setState(() {
                
                selectedMenu = item;
              });



             },
            itemBuilder: (context)=> <PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(
              value: FilterList.bbcNews,
              child: Text('BBC News'),
              ),

      PopupMenuItem<FilterList>(
              value: FilterList.USAToday,
              child: Text(' USA Today'),
              ),

      PopupMenuItem<FilterList>(
              value: FilterList.Axios,
              child: Text('Axios'),
              ),


      PopupMenuItem<FilterList>(
              value: FilterList.FoxNews,
              child: Text('Fox News'),
              ),

      PopupMenuItem<FilterList>(
              value: FilterList.cnn,
              child: Text('CNN'),
              ),

              
      PopupMenuItem<FilterList>(
              value: FilterList.CNBC,
              child: Text('CNBC'),
              ),
             
      PopupMenuItem<FilterList>(
              value: FilterList.ABCNews,
              child: Text('ABC News'),
              ),


          ],)
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*.55,
                  width: wight,
                  child: FutureBuilder<NewsChannelsHeadlinesModel>(
                    future: newsViewModel.fetchNewsChannelsApi(name),
                    builder: (BuildContext context,  snapshot) { 

                      if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return Center(
                          child: SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          ),
                        );
                      }
                      else
                      {
                        
                         return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){


                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());


                            return  SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: wight * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height*.02,
                              ),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url)=> Container(child: spinkit2,),
                                
                                  errorWidget:(context, url, error)=> Icon(Icons.error_outline, color: Colors.red,),
                                ),
                              ),
                            ),
                          
                          Positioned(
                            bottom: 20,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12),),
                            
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.all(15),
                                height: height *0.22,
                                child: Column(
                               
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: wight *0.7,
                                      child: Text(snapshot.data!.articles![index].title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),),
                                    ),
                                    Spacer(),
                                    Container(
                                          width: wight *0.7,
                                      child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        
                                    Text(snapshot.data!.articles![index].source!.name.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),),
                                      
                                      Text(format.format(dateTime),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    ),

                                ]),
                              ),
                             
                            
                            ),
                          )
                          ],

                          ),


                        );

                          }
                          );
                        
                        
                        
                        
                        
                        
                      }

                   },
                    
                  ),
          )

        ],
      ),
    );
  }




}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);