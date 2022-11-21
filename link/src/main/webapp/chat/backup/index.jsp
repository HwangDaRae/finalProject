<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!doctype html>
<html>
<head>
<!-- <meta charset="EUC-KR"> -->
<title>채팅 프로젝트</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font: 13px Helvetica, Arial; }
    form { background: #000; padding: 3px; position: fixed; bottom: 0; width: 100%; }
    form input { border: 0; padding: 10px; width: 90%; margin-right: 0.5%; }
    form button { width: 9%; background: rgb(130, 224, 255); border: none; padding: 10px; }
    #chatLog { list-style-type: none; margin: 0; padding: 0; }
    #chatLog li { padding: 5px 10px; }
    #chatLog li:nth-child(odd) { background: #eee; }
</style>
</head>
<body>
<script src="http://localhost:3000/socket.io/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.js"></script>
<script>
   $(document).ready(function(){
       var socket = io.connect("http://localhost:3000",{
           cors: { origin: "*" }
         });
   });
</script>

</body>
</html>