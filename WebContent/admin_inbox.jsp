<%@ page import="java.sql.*"%>
<%
	Connection con=null;
	PreparedStatement sst=null;
	Statement st=null;
	ResultSet rs=null;
 %>
 <script>
 function getMessage(val) {
 styles="<link href='cyber.cdf' rel='stylesheet'><title>Message</title>"
 nwin=open("","","scrollbars=yes,width=500 height=300,left=120,top=200");
 nwin.document.write(styles+"<p>"+document.getElementById('msgs'+val).innerHTML+"</p>");
 nwin.document.close();
 }
 </script>
<html xmlns=""><head>
<meta http-equiv="page-enter" content="blendTrans(duration=1)">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<title>e-Music world</title>
<style>
.border{border-color:#CC0000}
.style1 {
	color: #336600;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
}
</style>
</head><body background="ban.GIF" 
            bgcolor="chocalate"
                  text="#003399"
                  vlink="red" link="blue">
<span class="style1"><BR><BR><BR>
</span>
<fieldset class="border">
<legend align="center" class="style1">Messages From Administrator</legend>
<BR>
<%  

String buff="";
    String head="";
	try {
		Class.forName("com.mysql.jdbc.Driver");  
	 	con=DriverManager.getConnection("jdbc:mysql://localhost:3307/digitaltunes","root","root");  
    st=con.createStatement();
	String s="admin";
	String cmd="Select * from admin_inbox where user_name='"+s+"'";
    rs=st.executeQuery(cmd);
	int count=0;
	boolean rec=false;
	head+="<table align=center width=600 cellspacing=1 cellpadding=2 bgcolor=lightslategray><form method=post action=\"admin_deletemsgchecked.jsp\">";
	head+="<tr bgcolor=lightslategray><th style='color:aliceblue'>S.no</th><th style='color:aliceblue'>From</th><th style='color:aliceblue'>Subject</th><th style='color:aliceblue'>Date</th></tr>";
	while(rs.next()) {
        rec=true;
		count++;
		int id=rs.getInt("mid");
		String from=rs.getString("msg_from");
		String sub=rs.getString("msg_subject");
        String data=rs.getString("msg_data");
		sub=(sub!=null)?sub:"[&nbsp;None&nbsp;]";
		data=(data!=null)?data:"[&nbsp;No Message is Available&nbsp;]";
		//java.text.SimpleDateFormat fmt=new java.text.SimpleDateFormat("dd-MM-yyyy");
        //String msgdate=fmt.format(rs.getDate("msg_date")).toString();
       String msgdate= rs.getString("msg_date");
		buff+="<TR bgcolor=whitesmoke><TD>"+count+"</td>";
		buff+="<td><input name='from' value='"+id+"' type=checkbox class=check>"+from+"</td>";
		buff+="<Td><div id='msgs"+count+"' style='display:none'>"+data+"</div><a href='javascript:getMessage("+count+")'>"+sub+"</a></td>";
		buff+="<TD>"+msgdate+"</td></tr>";
	}
	if(buff.length()>0)	out.println(head+buff+"</table>");
	else out.println("No Messages Found.Your Inbox Terminal is Empty");
 }   catch(Exception e) {
   out.println("No Items Found"+e);
   }
%>
<br>
<table align=center width=600>
<tr><Td align=center><button type=submit accesskey="P"><u>D</u>elete</button>
  <button type=submit accesskey="R"><u>R</u>eset</button>

</td>
<td><a href="Messages.html">Go BAck</a></td>
</tr></table><BR></fieldset>
</body>
</html>
