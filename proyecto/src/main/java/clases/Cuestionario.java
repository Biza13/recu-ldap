/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.util.ArrayList;

/**
 *
 * @author serra
 */
public class Cuestionario {
    //Atributos
    private ArrayList <Preguntas> bateriaPreg;
    
    //Constructores
    public Cuestionario(ArrayList <Preguntas> bateriaPreg){
        this.bateriaPreg=bateriaPreg;
    }
    
    public Cuestionario(){
        
    }
    
    //getter y setter

    public ArrayList<Preguntas> getBateriaPreg() {
        return bateriaPreg;
    }

    public void setBateriaPreg(ArrayList<Preguntas> bateriaPreg) {
        this.bateriaPreg = bateriaPreg;
    }
    
    //metodo toString para mostrar las preguntas que llama al to string de Preguntas
    @Override
    public String toString (){ 
        String resultado = "";
        for (Preguntas pregunta : bateriaPreg) {
            resultado += pregunta.toString() + "\n";
        }
        return resultado;
    }
}
