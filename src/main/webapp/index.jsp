<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="table" class="beans.ShotCollectionManager" scope="session"/>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <link href="sakura.png" rel="icon" type="image/png">
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
    <meta charset="utf-8">
</head>

<body>
<div id="container">
    <div id="upper">
        <header>
            <div id="header_text">
                Кобзарь Мария, группа P3215, вариант 888
            </div>

        </header>

        <div id="heading">
            <h2>Лабораторная работа №2</h2>
        </div>

    </div>




    <div id="content">

        <div class="graph_block" id="graph">
            <svg width="300px" height="300px" onclick="svgHandler(event)" class="svgClass">
                <!-- Координатные оси -->
                <line x1="0" x2="300" y1="150" y2="150" stroke="#343548"></line>
                <line x1="150" x2="150" y1="0" y2="300" stroke="#343548"></line>
                <!--Стрелки-->
                <polygon points="150,0 145,10 155,10" stroke="#343548"></polygon>
                <polygon points="300,150 290,145 290,155" stroke="#343548"></polygon>

                <!--Прямоугольник в третьей четверти-->
                <polygon points="100,150 150,150 150,250 100,250"></polygon>
                <!--Четверть круга во второй четверти-->
                <path d="M150,50 A100,100 90 0,0 50,150 L 150,150 Z"></path>
                <!--Треугольник в первой четверти-->
                <polygon points="200,150 150,100 150, 150"></polygon>

                <!-- Метки для значений R на оси X -->
                <line x1="50" x2="50" y1="145" y2="155" stroke="#343548"></line>
                <line x1="100" x2="100" y1="145" y2="155" stroke="#343548"></line>
                <line x1="200" x2="200" y1="145" y2="155" stroke="#343548"></line>
                <line x1="250" x2="250" y1="145" y2="155" stroke="#343548"></line>

                <!-- Метки для значений R на оси Y -->
                <line x1="145" x2="155" y1="50" y2="50" stroke="#343548"></line>
                <line x1="145" x2="155" y1="100" y2="100" stroke="#343548"></line>
                <line x1="145" x2="155" y1="200" y2="200" stroke="#343548"></line>
                <line x1="145" x2="155" y1="250" y2="250" stroke="#343548"></line>

                <!-- Подписи к осям -->
                <text x="290" y="140">X</text>
                <text x="155" y="10">Y</text>
                <!-- Значения R на оси X -->
                <text x="40" y="138">-R</text>
                <text x="85" y="138">-R/2</text>
                <text x="190" y="138">R/2</text>
                <text x="245" y="138">R</text>
                <!-- Значения R на оси Y -->
                <text x="162" y="54">R</text>
                <text x="162" y="104">R/2</text>
                <text x="162" y="204">-R/2</text>
                <text x="162" y="254">-R</text>
                <%--@elvariable id="shots" type="java.util.LinkedList"--%>
                <c:forEach items="${shots}" var="col">
                    <c:if test="${col.getStatus() == true}">
                        <circle class="shot" cx="${150 + 50 * 2/col.getR() * col.getX()}"
                                cy="${150 - 50 * 2/col.getR() * col.getY()}" r="2"
                                fill="green" stroke-width="0"></circle>
                    </c:if>
                    <c:if test="${col.getStatus() == false}">
                        <circle class="shot" cx="${150 + 50 * 2/col.getR() * col.getX()}"
                                cy="${150 - 50 * 2/col.getR() * col.getY()}" r="2"
                                fill="red" stroke-width="0"></circle>
                    </c:if>
                </c:forEach>
            </svg>
        </div>

        <div class="content_block">
        <form novalidate name="simpleForm" onsubmit="getDataFromForm(); return false;">
            <div id="form">
                <div  id="values">
                    <div id="x-values">
                        <%--@declare id="x-value"--%><label id="label_x">X = -3</label>
                        <label for="x-value">Выберите X:</label>
                        <select id="x-select" name="x-value" onchange="getX()">
                            <option value="-3" >-3</option>
                            <option value="-2" >-2</option>
                            <option value="-1" >-1</option>
                            <option value="0" >0</option>
                            <option value="1" >1</option>
                            <option value="2" >2</option>
                            <option value="3" >3</option>
                            <option value="4" >4</option>
                            <option value="5" >5</option>
                        </select>
                        <br>
                    </div>
                    <div id="y-values">
                        <label for="y-value">Введите Y (-3 ... 3):</label>
                        <input type="text"  class="y-text" maxlength="15" id="y-value" name="y-value"
                               oninput="validateTextField()" required> <br>
                    </div>
                    <div id="r-value">
                        <label for="r-value">Выберите R:</label>

                        <input class="r-button" type="button" name="r-value" value="1">
                        <input class="r-button" type="button" name="r-value" value="1.5">
                        <input class="r-button" type="button" name="r-value" value="2">
                        <input class="r-button" type="button" name="r-value" value="2.5">
                        <input class="r-button" type="button" name="r-value" value="3">

                        <br>
                    </div>
                    <div id="formButtons">
                    <input type="submit" class="element" name="submit-btn" value="Отправить">
                  <button onClick="window.location.replace('./result.jsp');" type="reset">Последний результат</button>
                    </div>
                </div>
            </div>
        </form>

            <section id="validationInfo" class="validationInfo"></section>
    </div>
    </div>
</div>

<div id="tableInTotal">
    <input type="submit" class="element" id="clear-btn" value="Очистить"
           onclick="clearTable();">
    <div id="results">
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
        <c:forEach items="${shots}" var="col">
            <tr>
                <td>${col.getX().toString().format("%.2f", col.getX()).replaceAll(",",".")}</td>
                <td>${col.getY().toString().format("%.2f", col.getY()).replaceAll(",",".")}</td>
                <td>${col.getR().toString().trim().format("%.2f", col.getR()).replaceAll(",",".")}</td>
                <td>${col.getTime().toString()}</td>
                <td>${col.getScriptTime().toString()}</td>
                <td>${col.getStatus().toString()}</td>
            </tr>
        </c:forEach>
    </table>
    </div>
</div>
</div>

</body>
<footer>
    <div id="footer_text">
        Санкт-Петербург <br>
        Сентябрь, 2023
    </div>
</footer>
</html>
