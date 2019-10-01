import 'package:flutter/material.dart';
import 'Poligono.dart';

class Objeto {
  List<Poligono> listaPoligono;
  Offset centro;

  Objeto(){
    listaPoligono = List<Poligono>();
  }

  void centrar(centro){
    this.centro = centro;
  }

  int longitud(){
    return listaPoligono.length;
  }

  Poligono get(pos){
    return listaPoligono[pos];
  }

  void add(poligono){
    listaPoligono.add(poligono);
  }

  void remove(pos){
    this.listaPoligono.remove(pos);
  }
}
