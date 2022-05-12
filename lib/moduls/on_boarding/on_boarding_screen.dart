import 'package:flutter/material.dart';
import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel{
  final String image;
  final String title;
  final String body;
  OnBoardingModel({required this.image,required this.title,required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boarderController= PageController();
  List <OnBoardingModel> boardingItems=[
    OnBoardingModel(
      //
      image: 'assets/images/boarder_1.jpg',body: 'There are more then 1,000 brands',title: ' Choose your products '
    ),
    OnBoardingModel(
        image: 'assets/images/boarde_2.png',body: 'Just tow click and you can bay',title: 'Add to cart'
    ),
    OnBoardingModel(
        image: 'assets/images/boarde_3.jpg',body: 'The order can be paid by credit card or in cash at the time of delivery',title: 'Pay by cart'
    ),
  ];
  bool isLast=false;
  void skipBoarding()async{


    await CacheHelper.putBoolData(key: 'onBoarding', value: true).then((value) {

      if(value){
        navigatorReplace(context, LoginScreen());
      }
    });




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(onPressed:(){skipBoarding();}
            , child: Text('Skip',style: TextStyle(color: Colors.deepOrange),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(index==boardingItems.length-1){
                      setState(() {
                        isLast=true;
                      });

                    }else{
                      setState(() {
                        isLast=false;

                      });

                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boarderController,
                  itemBuilder: (context, index) => boarderItems(boardingItems[index]),
                  itemCount: boardingItems.length,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(controller: boarderController, count: boardingItems.length,effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,spacing: 5,
                  ),),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast){
                        skipBoarding();
                      }else{
                        boarderController.nextPage(duration:Duration(milliseconds: 700) , curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                    child: Icon(Icons.navigate_next),
                    backgroundColor: Colors.deepOrange,
                  )
                ],
              ),
            ],
          ),
        ));
  }

  boarderItems(OnBoardingModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
            Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ' ${model.body}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      );


}
