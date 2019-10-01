import 'package:flutter/material.dart';
enum Tipo{abierto, cerrado}

class Poligono {
  List<Offset> listaPuntos;
  Offset centro;
  Tipo tipo;

  Poligono(tipo){
    this.listaPuntos = <Offset>[];
    this.tipo= tipo;
  }

  void centrar(centro){
    this.centro = centro;
  }

  int  longitud(){
    return listaPuntos.length;
  }

  Offset get(pos){
    return listaPuntos[pos];
  }

  Poligono from(poligono){
    return this.listaPuntos=poligono.listaPuntos;
  }

  void add(punto){
    this.listaPuntos.add(punto);
  }

  void remove(pos){
    this.listaPuntos.remove(pos);
  }

  external factory Poligono.from(Poligono poligono, {bool growable = true});
}