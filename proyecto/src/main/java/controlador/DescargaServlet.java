/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import clases.Cuestionario;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "DescargaServlet", urlPatterns = {"/DescargaServlet"})
public class DescargaServlet extends HttpServlet {

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
            out.println("<title>Servlet DescargaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DescargaServlet at " + request.getContextPath() + "</h1>");
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
        
        Cuestionario c = (Cuestionario) session.getAttribute("cuestionario");

        String nombreArchivo = "cuestionario.txt";
        String rutaDirectorio = "C:\\Users\\serra\\Downloads\\";
        String rutaArchivo = rutaDirectorio + nombreArchivo;
        
        try {
            // Crear un objeto FileWriter
            FileWriter escritor = new FileWriter(rutaArchivo);

            // Escribir datos en el archivo
            escritor.write(c.toString());

            // Cerrar el archivo
            escritor.close();
            System.out.println("Datos escritos en el archivo correctamente.");
            

        } catch (IOException e) {
            // Manejar excepciones de entrada/salida
            System.out.println("<p>Ocurrió un error al generar el archivo.</p>");
            e.printStackTrace();
        }

        response.sendRedirect("Descarga.jsp");
        
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
