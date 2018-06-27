/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


if (typeof localStorage.token === "undefined")
    window.location = "index.jsp";
function callJavaScriptServlet(key) {
    document.getElementById("token".concat(key)).value = localStorage.token;
}

