import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background= Colors.blue,
  bool isUberCase= true,
  double radius=25.0,
  required Function function,
  required String text,
})=>Container(
  width: width,
  child: MaterialButton(
    onPressed:()=>function() ,
    child: Text(
      isUberCase ?text.toUpperCase():text,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius,),
    color: background,
  ),
);


//Function? validateFunc() => null;


Widget defaultFormFiled({
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData fixIcon,
  IconData? suffix,
  bool ispassword= false,
  Function? onChanged,
  Function? onsumit,
  Function? ontap,
  Function? validation,
  Function? sufixpressd,
  bool isClicable = true,

})=>TextFormField(
  controller:controller,
  keyboardType:type,
  obscureText: ispassword,
  onFieldSubmitted:(value)=>onsumit!(value),
  onChanged: (value)=>onChanged!(value),
  onTap: ()=>ontap!(),
  enabled:isClicable ,
  validator: (value)=>validation!(value),


  decoration:InputDecoration(
    prefixIcon: Icon(
        fixIcon
    ),
    suffixIcon: IconButton(
      onPressed:()=>sufixpressd!() ,
      icon: Icon(
          suffix
      ),
    ) ,
    labelText: lable,
    border: OutlineInputBorder(),

  ),

);




Widget MyDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticaleItem(artical , context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${artical['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${artical['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${artical['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);



void navigateTo(context, widget) =>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,));

void navigateAndFinish(context, widget) =>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context)=>widget),
        (route) => false);

void showToast({
  required String text,
  required ToastStates state})=> Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}
