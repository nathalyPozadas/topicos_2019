import 'package:flutter/material.dart';
import 'Objeto.dart';

class Dibujo {
  List<Objeto> listaObjetos;
  Offset centro;

  Dibujo(){
    listaObjetos = List<Objeto>();
    centro = Offset(0, 0);
  }

  void centrar(centro){
    this.centro = centro;
  }

  int longitud(){
    return listaObjetos.length;
  }

  Objeto get(pos){
    return listaObjetos[pos];
  }

  void add(objeto){
    this.listaObjetos.add(objeto);
  }

  void remove(pos){
    this.listaObjetos.remove(pos);
  }

}