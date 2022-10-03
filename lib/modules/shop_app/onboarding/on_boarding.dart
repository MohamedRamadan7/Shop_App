import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController= PageController();

  List<BoardingModel> boarding=
  [
    BoardingModel(
        image: 'assets/images/onboard1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body',

    ),
    BoardingModel(
      image: 'assets/images/onboard.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',

    ),
    BoardingModel(
      image: 'assets/images/onboard1.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',

    ),
  ];

  bool isLast =false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {

      if(value)
        {
          navigateAndFinish(context,ShopLodginScreen());
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed:submit,
              child: Text(
                'SKIP'
              ),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                 if( index == boarding.length-1)
                 {
                   setState(() {
                     isLast =true;
                   });
                 } else
                   {
                     setState(() {
                       isLast=false;
                     });
                   }
                },
                controller: boardController ,
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(

                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast == true)
                    {
                      submit();
                    }else
                      {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                  },
                  child: Icon(
                      Icons.arrow_forward_ios),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}


Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
          image:AssetImage('${model.image}')),
    ),
    SizedBox(
      height: 30.0,
    ),
    Text(
      '${model.title}',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 15.0,
    ),
    Text(
      '${model.body}',
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    ),


  ],
);
