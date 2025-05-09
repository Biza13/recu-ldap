/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import clases.Cuestionario;
import clases.Preguntas;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author serra
 */
@WebServlet(name = "CrearCuestionario", urlPatterns = {"/CrearCuestionario"})
public class CrearCuestionarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrearCuestionario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CrearCuestionario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        request.setCharacterEncoding("UTF-8");

        //crear la sesion para importar variables
        HttpSession session = request.getSession();

        //creamos el cuestionario
        Cuestionario c = new Cuestionario();

        //creamos array para añadir las preguntas de la bd todas
        ArrayList<Preguntas> preguntasBD = new ArrayList<>();

        //ArrayList para las preguntas que añadiremos al cuestionario
        ArrayList<Preguntas> preguntasCuestionario = new ArrayList<>();

        //crear variable para bajar la conexion de la sesion
        Connection conexion = (Connection) session.getAttribute("conexion");

        try {
            //crear la declaracion sql para hacer el select y mostrar todas las preguntas
            Statement sentenciaSelect = conexion.createStatement();

            //en los resultset almacenamos los resultados de una consulta sql es decir aqui almacenamos todas las filas de la consulta sql
            ResultSet obtencionDatos = sentenciaSelect.executeQuery("select * from preguntas");

            //aqui obtengo el numero de preguntas que el usuario quiere que sea el cuestionario
            int cantPregUsuario = Integer.parseInt(request.getParameter("cantPreg"));

            // Iterar sobre los resultados y crear objetos Preguntas para cada fila
            while (obtencionDatos.next()) {
                //creo variables de tipo string para agregar los diferentes campos de la bd con el metoto.getString()
                String enunciado = obtencionDatos.getString("enunciado");
                String posiblesResp1 = obtencionDatos.getString("posiblesResp1");
                String posiblesResp2 = obtencionDatos.getString("posiblesResp2");
                String posiblesResp3 = obtencionDatos.getString("posiblesResp3");
                String posiblesResp4 = obtencionDatos.getString("posiblesResp4");
                String posiblesResp5 = obtencionDatos.getString("posiblesResp5");
                String respuestaCorrecta = obtencionDatos.getString("respCorrecta");

                //creo un arrayList de posibles respuestas donde añadir las posibles respuestas y posteriormente añadir este array al constructor de preguntas
                ArrayList<String> posiblesResp = new ArrayList<>();
                posiblesResp.add(posiblesResp1);
                posiblesResp.add(posiblesResp2);
                posiblesResp.add(posiblesResp3);
                posiblesResp.add(posiblesResp4);
                posiblesResp.add(posiblesResp5);

                // Crear un objeto Preguntas y agregarlo al ArrayList
                Preguntas pregunta = new Preguntas(enunciado, posiblesResp, respuestaCorrecta);
                preguntasBD.add(pregunta);

                //subiendo el array de preguntasBD a la sesion
                session.setAttribute("preguntasBD", c);
            }

            //cerrar el statment y el resultset
            obtencionDatos.close();
            sentenciaSelect.close();

        } catch (SQLException ex) {
            Logger.getLogger(CrearCuestionarioServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //creo variable para guardar el numero de preguntas que quiere el usuario que sea el cuestionario y lo hago con u nparseInt porque es una string
        int cantPregCuest = Integer.parseInt(request.getParameter("cantPreg"));

        /*El hashSet es parecido a un hashMap pero con la diferencia de que el hashMap tiene clave y valor y el hashSet solo tiene valores.
        En el hashSet solo se pueden meter elementos del mismo tipo, es decir todo string o todo int... pero no se pueden mezclar
        y otra peculiaridad es que no puede obtener valores repetidos*/
        //por lo que usaremos el hash set para que no se repitan las preguntas que quiero añadir al cuestionario, guardando en el los indices de las preguntas a añadir
        Set<Integer> indicesDePreguntas = new HashSet<>();

        if (cantPregCuest <= preguntasBD.size()) {

            // bucle while para que agregue preguntas al cuestionario hasta que lleguemos al limite de preguntas marcadas por el usuario
            while (cantPregCuest > preguntasCuestionario.size()) {
                // Generar un número aleatorio entre 0 y el tamaño del ArrayList de preguntasBD
                Random randomizador = new Random();
                int numRand = randomizador.nextInt(preguntasBD.size());

                // en este if verifico que el hashSet NO contenga el numero random que nos ha dado.
                if (!indicesDePreguntas.contains(numRand)) {
                    //en este objeto guardo la pregunta del arrayList del cuestionario con el indice del numero random
                    Preguntas preguntaCues = preguntasBD.get(numRand);

                    //Añado la pregunta al ArrayList preguntasCuestionario
                    preguntasCuestionario.add(preguntaCues);

                    //aqui añado el numero random al hashSet para que no se repita
                    indicesDePreguntas.add(numRand);
                }
            }
            
            //añadir al objeto cuestionario el array de preguntas que hemos creado con el random
            c.setBateriaPreg(preguntasCuestionario);
                
            //subir el cuestionario a la sesion para cogerlo desde otro jsp
            session.setAttribute("cuestionario", c);
            
            response.sendRedirect("CuestionarioCreadoConExito.jsp");
            
        } else {
            response.sendRedirect("Error.jsp");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
