import 'package:flutter/material.dart';
import 'package:topicos_paint2/clases/Poligono.dart';
import 'package:topicos_paint2/clases/Dibujo.dart';
import 'package:topicos_paint2/clases/Objeto.dart';

void main() => runApp(MyApp());

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));


Poligono pol;
Objeto obj;
Dibujo dib=new Dibujo();

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
    return Scaffold(
      appBar:AppBar(
        title: const Text("topicos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.crop_square),
            tooltip: 'Show Snackbar',
            onPressed: () {
              print("poligono cerrado");
              p=null;
              print(p.toString());
              if(pol == null ){
              pol=new Poligono(Tipo.cerrado);
              obj=new Objeto();
              }else{
                obj.add(pol);
                dib.add(obj);
                pol=new Poligono(Tipo.cerrado);
                obj=new Objeto();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.rotate_right),
            tooltip: 'Next page',
            onPressed: () {
              print("poligono abierto");
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'N',
            onPressed: () {
              p =null;
              pol=null;
              obj=null;
              dib=Dibujo();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details){
          setState(() {
            RenderBox box = context.findRenderObject();
                p = box.globalToLocal(details.globalPosition);
          });
        },
        child: Container(
          child: CustomPaint(
            painter: Dib(p),
            child: Container(),
          ),
        ),
      ),
    );
  }



}


class Dib extends CustomPainter{
  Dib(this.p);
  final Offset p;
  
  @override
  void paint(Canvas canvas, Size size) {
    
    if(p!=null && pol!=null){
    print(p.toString());  
    pol.add(p);
    final paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 1;

        var poligono=pol;
        var cantPuntos=poligono.longitud();
        for(var k=1; k<cantPuntos;k++){
           canvas.drawLine(poligono.get(k-1), poligono.get(k), paint); 
        }   
      
      


    var cantObj=dib.longitud();
    for(var i=0; i<cantObj;i++){
      var objeto=dib.get(i);
      var cantPol=objeto.longitud();
      for(var j=0; j<cantPol;j++){
        var poligono=objeto.get(j);
        var cantPuntos=poligono.longitud();
        for(var k=1; k<cantPuntos;k++){
           canvas.drawLine(poligono.get(k-1), poligono.get(k), paint); 
        }
        if(poligono.tipo==Tipo.cerrado){
          canvas.drawLine(poligono.get(0), poligono.get(cantPuntos-1), paint);
        }   
      }
    }
      
    }
    
    
print('Hay '+dib.longitud().toString()+' poligonos');

    }
  
  

  @override
  bool shouldRepaint(Dib p) {
    print("redib");    
    return p.p!=p;
  }
}


