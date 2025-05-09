package controlador;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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
//poner aqui el nombre del servlet para que lo coja desde los formularios a los que envies a este 
@WebServlet(name = "Menu", urlPatterns = {"/menu"})
public class MenuServlet extends HttpServlet {

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
            out.println("<title>Servlet controlador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet controlador at " + request.getContextPath() + "</h1>");
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
        // processRequest(request, response);
        
        //crear una sesion
        HttpSession session = request.getSession();
        
        //esto es para que coja la codificacion de utf-8
        request.setCharacterEncoding("UTF-8"); 
        
        //if para que si al recoger el nombrede usuario de la sesion da null lo cree metiendole el nombre del formulario
        if(session.getAttribute("nombreUsuario")==null){
            session.setAttribute("nombreUsuario",request.getParameter("nombre"));
        }
        
        // Obtener la fecha actual
        LocalDate fecha = LocalDate.now();
        
        // Obtener la hora actual y el formato que le quiero dar
        LocalTime hora = LocalTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("HH:mm:ss");
        //creo una variable string para guardar la hora formateada
        String horaFormateada = hora.format(formato);
        //ahora subimos la variable a la sesion para recuperarla en el jsp
        session.setAttribute("horaFormateada", horaFormateada);

        
        // Combinar la fecha y la hora en un LocalDateTime
        //LocalDateTime fechaYHora = LocalDateTime.of(fecha, hora);
        
        /*crear la sesion con una fecha y hora y hacer el if para que en caso de que ya haya una fecha y hora registrada no la vuelva a registrar*/
        if (session.getAttribute("fecha") == null){
            session.setAttribute("fecha", fecha);
        }
        if (session.getAttribute("hora") == null){
            session.setAttribute("hora", hora);
        }
        
        response.sendRedirect("menu.jsp");
        
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
