/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/userphoto")
public class userphoto extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String bio = request.getParameter("bio");

            Part part = request.getPart("file");
            String photo = extractFileName(part);
            String savepath = "C:\\Users\\aksha\\OneDrive\\Desktop\\pics\\"+File.separator+photo;
            File filedir = new File(savepath);

            part.write(savepath + File.separator);

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish database connection
                String url = "jdbc:mysql://localhost:3307/socialmedia";
                String username = "root";
                String password = "";

                try (Connection con = DriverManager.getConnection(url, username, password)) {
                    PreparedStatement ps = con.prepareStatement("INSERT INTO users VALUES (?, ?, ?, ?, ?)");

                    // Set parameters for the PreparedStatement
                    ps.setInt(1, id);
                    ps.setString(2, name);
                    ps.setString(3, email);
                    ps.setString(4, bio);
                    ps.setString(5, savepath); // Assuming 'savepath' is the path to the saved photo file

                    // Execute the PreparedStatement
                    ps.executeUpdate();

                    out.println("User added successfully");

                    ps.close();
                }
            } catch (Exception e) {
                out.println("Exception: " + e.getMessage());
            }
        }
    }

    private String extractFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        String items[] = cd.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}