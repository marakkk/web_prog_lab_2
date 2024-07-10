<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>lab2</title>
    <script src="./js/Validator.js"></script>
    <script src="./js/Updater.js"></script>
    <script src="./js/ValueGetter.js"></script>
    <script src="./js/ClearTable.js"></script>
    <script src="./js/rButton.js"></script>
    <script src="./js/GraphHandler.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="resultsContainer">

    <table id="table">
        <tr>
            <th>X</th>
            <th>Y</th>
            <th>R</th>
            <th>Время запроса</th>
            <th>Время работы скрипта (мс)</th>
            <th>Результат</th>
        </tr>
        <%--@elvariable id="shots" type="java.util.LinkedList"--%>
        <tr class="results">
            <c:choose>
                <c:when test="${shots.size()>0}">
                    <td>${shots.getLast().getX().toString().format("%.2f", shots.getLast().getX()).replaceAll(",",".")}</td>
                    <td>${shots.getLast().getY().toString().format("%.2f", shots.getLast().getY()).replaceAll(",",".")}</td>
                    <td>${shots.getLast().getR().toString().format("%.2f", shots.getLast().getR()).replaceAll(",",".")}</td>
                    <td>${shots.getLast().getTime().toString()}</td>
                    <td>${shots.getLast().getScriptTime().toString()}</td>
                    <td>${shots.getLast().getStatus().toString()}</td>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
        </tr>
        <tr>
            <td colspan="6" style="text-align: center">
                <button onClick="window.location.replace('./index.jsp');" type="reset" onclick="">Назад</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
