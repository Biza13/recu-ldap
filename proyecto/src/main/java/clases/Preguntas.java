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
public class Preguntas {

    //Atributos    
    private String enunciado;
    private ArrayList<String> posiblesResp;
    private String respCorrecta;

    //Constructores
    public Preguntas(String enunciado, ArrayList<String> posiblesResp, String respCorrecta) {
        this.enunciado = enunciado;
        this.posiblesResp = posiblesResp;
        this.respCorrecta = respCorrecta;
    }

    public Preguntas() {

    }

    //setter y getter
    public String getEnunciado() {
        return enunciado;
    }
    public ArrayList<String> getPosiblesResp() {
        return posiblesResp;
    }
    public String getRespCorrecta() {
        return respCorrecta;
    }

    public void setEnunciado(String enunciado) {
        this.enunciado = enunciado;
    }
    public void setPosiblesResp(ArrayList<String> posiblesResp) {
        this.posiblesResp = posiblesResp;
    }
    public void setRespCorrecta(String respCorrecta) {
        this.respCorrecta = respCorrecta;
    }

    //Metodos
    public String toString() {
        String resp4;
        String resp5;

        //si posiblesResp en la posicion3 NO esta vacio
        if (!posiblesResp.get(3).isEmpty()) {
            resp4 = posiblesResp.get(3);

            //si posiblesResp en la posicion 4 NO esta vacio
            if (!posiblesResp.get(4).isEmpty()) {
                resp5 = posiblesResp.get(4);

                //este return es si las 5 pregunats tienen contenido
                return "Enunciado: " + enunciado + "\n"
                        + "Respuestas: " + "\n"
                        + "a: " + posiblesResp.get(0) + "\n"
                        + "b: " + posiblesResp.get(1) + "\n"
                        + "c: " + posiblesResp.get(2) + "\n"
                        + "d: " + resp4 + "\n"
                        + "e: " + resp5 + "\n"
                        + "Respuesta correcta" + "--> " + respCorrecta + "\n"
                        + "-----------------------------------------------------------------------------";
            }

            //este return es si tiene las preguntas obligatorias y la cuarta llenas
            return "Enunciado: " + enunciado + "\n"
                    + "Respuestas: " + "\n"
                    + "a: " + posiblesResp.get(0) + "\n"
                    + "b: " + posiblesResp.get(1) + "\n"
                    + "c: " + posiblesResp.get(2) + "\n"
                    + "d: " + resp4 + "\n"
                    + "Respuesta correcta" + "--> " + respCorrecta +"\n"
                    + "-----------------------------------------------------------------------------";
        } else {
            //este es el return por si solo las 3 preguntas obligatorias estan llenas
            return "Enunciado: " + enunciado + "\n"
                    + "Respuestas: " + "\n"
                    + "a: " + posiblesResp.get(0) + "\n"
                    + "b: " + posiblesResp.get(1) + "\n"
                    + "c: " + posiblesResp.get(2) + "\n"
                    + "Respuesta correcta" + "--> " + respCorrecta + "\n"
                    + "-----------------------------------------------------------------------------";
        }
    }
}
