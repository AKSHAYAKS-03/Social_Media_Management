<%-- 
    Document   : newjsp
    Created on : 27 Mar, 2024, 10:16:32 PM
    Author     : aksha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
        <thead>
            <tr>
                <th>Invoice_id</th>
                <th>Customer_name</th>
                <th>Date</th>
                <th>Total_amount</th>
            </tr>
        </thead>
        </body>
        <% 
           out.println("<h2>INVOICE TABLE<h2>");
           try{ Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/ip_8");
            Statement st=c.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM invoices");
                    
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                    while (rs.next()) {
                        int id = rs.getInt("inv_id");
                        String name = rs.getString("customer_name");
                        Date joiningDate = rs.getDate("date");
                        double salary = rs.getDouble("total_amount");
                        

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + joiningDate + "</td>");
                        out.println("<td>" + salary + "</td>");
                        out.println("</tr>");
                    }
                                                
                rs = st.executeQuery("SELECT COUNT(*) FROM invoices");
                while (rs.next()) {
                    out.println("<table border=2 solid black><tr><th>Total no of Invoices </th><th>" + rs.getInt(1) + "</th></tr><br>");
                }
                rs = st.executeQuery("SELECT SUM(total_amount) FROM invoices");
                while (rs.next()) {
                    out.println("<tr><th>Total Amount </th><th>" + rs.getInt(1) + "</th></tr><br>");
                }
                rs = st.executeQuery("SELECT AVG(total_amount) FROM invoices");
                while (rs.next()) {
                    out.println("<tr><th>Average Amount </th><th>" + rs.getInt(1) + "</th></tr><br>");
                }
            }
           
            catch (SQLException e) {
                // Handle database errors
                out.println("Error: " + e.getMessage());
            } 

            %>
    </body>
</html>
