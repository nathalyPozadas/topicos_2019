import 'package:flutter/material.dart';
import 'package:topicos_paint2/clases/Poligono.dart';
import 'package:topicos_paint2/clases/Dibujo.dart';
import 'package:topicos_paint2/clases/Objeto.dart';

void main() => runApp(MyApp());

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));


Poligono pol;
Objeto obj;
Dibujo dib= Dibujo();
int cant=0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'x',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Offset> listaPuntos = <Offset>[];
Offset p;


  @override
  Widget build(BuildContext context){

    pol= new Poligono(Tipo.cerrado);
    obj=new Objeto();
    obj.add(pol);
    dib.add(obj);
    
    return Scaffold(
      appBar:AppBar(
        title: const Text("topicos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Show Snackbar',
            onPressed: () {
              pol= new Poligono(Tipo.cerrado);
              obj=new Objeto();
              obj.add(pol);
              dib.add(obj);
              dib=new Dibujo();
            },
          )
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details){ print('moviendose');},
        onTapUp:(TapUpDetails details){
          setState(() {
            RenderBox box = context.findRenderObject();
                p = box.globalToLocal(details.localPosition);
          });
          print('solto');
        },
        onDoubleTap: (){
          dib.add(new Objeto()..add(new Poligono(Tipo.cerrado)));
          cant++;
          print('cantidad de objetos: '+cant.toString());
        }
        ,
        child: Container(
          child: CustomPaint(
            painter: Dib(p,cant),
            child: Container(),
          ),
        ),
      ),
    );
  }
}


class Dib extends CustomPainter{
  Dib(this.p,this.cant);
  final Offset p;
  final int cant;
  
  @override
  void paint(Canvas canvas, Size size) {
    
    if(p!=null){
    dib.get(cant).get(0).add(p);

    final paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 1;  

    var cantObj=dib.longitud();
    for(var i=0; i<cantObj;i++){
      var objeto=dib.get(i);
      print('object '+i.toString());
      var cantPol=objeto.longitud();
      for(var j=0; j<cantPol;j++){
        var poligono=objeto.get(j);
        print('pol '+j.toString());
        var cantPuntos=poligono.longitud();
        for(var k=1; k<cantPuntos;k++){
          print('punto '+poligono.get(k-1).toString());
           canvas.drawLine(poligono.get(k-1), poligono.get(k), paint); 
        }
        if(poligono.tipo==Tipo.cerrado){
          canvas.drawLine(poligono.get(0), poligono.get(cantPuntos-1), paint);
        }   
      }
    }
    

    }
    

    }
  
  

  @override
  bool shouldRepaint(Dib p) {
    print("redib");    
    return p.p!=p;
  }
}


