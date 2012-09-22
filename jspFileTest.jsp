<%@page import="database.DBAccess"%>
<%@page import="java.util.List"%>
<%@page import="BL.WakUtil"%>
<%@page import="beans.RehearsalRoom"%>
<%@page import="beans.User"%>
<%@page import="Constants.ConstantValues"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%

            DBAccess dbAccess = DBAccess.getInstance();
            User user = (User) session.getAttribute(ConstantValues.USERDATA);
            List<RehearsalRoom> rehersalRooms = WakUtil.getRehearsalRooms();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Neue Band hinzufügen</title>
        <link href="wakmusic.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="script/jquery.min.js"></script>
        <style type="text/css">@import "css/jquery.autocomplete.css"; </style>
        <script type="text/javascript" src="script/jquery.autocomplete.js"></script>
        <script type="text/javascript">

            $(document).ready(function(){
                var data = new Array();
                var dataString = "";
            <%
                        String receiverString = "";
                        List<String> users = dbAccess.getUsers();
                        for (String currentUser : users) {
                            receiverString += (currentUser.split("#")[1] + " ");
                        }
                        out.print("dataString = '" + receiverString.substring(0, receiverString.length() - 1) + "';");
            %>
                    data = dataString.split(" ");
                    $("#username").autocomplete(data);
                });
        </script>
    </head>

    <body>
        <div id="frame">
            <jsp:include page="defaultFrames.jsp"/>
            <jsp:include page="bandArea.jsp"/>
            <div id="content">
                <% if (user == null || user.getAccessLevel() != 2) {%>
                Du muss ein Administrator sein um diese Seite einsehen zu können.
                <% } else {%>
                <h1>Neue Band hinzufügen:</h1>
                <form action="AdminArea" method="POST">
                    <input type="hidden" name="type" value="addBand"/>
                    <label>Bandname:</label><input name="bandname" type="text"/><br/>
                    <label>Proberaum:</label><select name="rrid">
                        <%
                             for (RehearsalRoom currentRs : rehersalRooms) {
                                 out.print("<option value='" + currentRs.getRrid() + "'>" + currentRs.getName() + "</option>");
                             }
                        %>
                    </select><br/>
                    <label>erstes Bandmitglied:</label><input type="text" id="username" name="banduser"/><br/>
                    <input type="submit" value="Band hinzufügen"/>
                </form>
                <% }%>
            </div>
        </div>
    </body>
</html>

