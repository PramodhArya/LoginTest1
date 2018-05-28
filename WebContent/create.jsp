<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page import = "java.sql.*" %>
	<%@ page import = "javax.sql.*" %>
	<%
		String user = request.getParameter("uname");
		session.putValue("uname",user);
		String pwd = request.getParameter("pass");
		String cpwd = request.getParameter("conPass");
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginTest", "root", "root");
		//out.print("Connected");
		
		Statement st = con.createStatement();
		
		
		String searchTable = "select count(*) from logininfo where username like '%"+user+"%';";	
		PreparedStatement prest = con.prepareStatement("SELECT username FROM logininfo WHERE username = ?");
		prest.setString(1, user);
		ResultSet rs = prest.executeQuery();
		
		if (rs.next()) {
			out.print(rs.getString(1));
			response.sendRedirect("createForm.html");
			out.print("Username already exists.");
		} else {
			if (pwd.equals(cpwd)) {
				int i = st.executeUpdate("insert into logininfo values ('" + user + "','"+ pwd +"');");
				out.print(i);
				out.print("Success");
				response.sendRedirect("loginForm.html");
			} else {
				response.sendRedirect("createForm.html");
				out.print("Passwords dont match.");
			}
		}
		
		
		
		
	%>
</body>
</html>