<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
	Aerial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>LINK</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="/resources/assets/css/noscript.css" /></noscript>
		
	<style>
	
	h1 {
		color: white;
	}
	
	p {
		color: white;
	}
	
	.btn-5 {
		width: 130px;
		height: 40px;
		line-height: 52px;
		padding: 0;
		border: none;
		background: rgb(255 27 0 / 0%);
		color: white;
    	font-weight: 800;
    	font-size: 1rem;
    	cursor:pointer;
	}
	
	.btn-5:hover {
		color: #5F0080;
		background: transparent;
		box-shadow: none;
	}
	
	.btn-5:before, .btn-5:after {
		content: '';
		position: absolute;
		top: 0;
		right: 0;
		height: 2px;
		width: 0;
		background: #5F0080;
		box-shadow: -1px -1px 5px 0px #fff, 7px 7px 20px 0px #0003, 4px 4px 5px
			0px #0002;
		transition: 400ms ease all;
	}
	
	.btn-5:after {
		right: inherit;
		top: inherit;
		left: 0;
		bottom: 0;
	}
	
	.btn-5:hover:before, .btn-5:hover:after {
		width: 100%;
		transition: 800ms ease all;
	}
	</style>

	</head>
	<body class="is-preload">
		<div id="wrapper">
			<div id="bg"></div>
			<div id="overlay"></div>
			<div id="main">

				<!-- Header -->
					<header id="header">
						<h1>서로를 연결하는</h1>
						<p>두근거리는 &nbsp;&bull;&nbsp; 서로의 &nbsp;&bull;&nbsp; 만남</p>
						
						<button class="custom-btn btn-5" onclick="location.href='/feed/getFeedList';">지금 만나러 가기</button>
						
					</header>

			</div>
		</div>
		<script>
			window.onload = function() { document.body.classList.remove('is-preload'); }
			window.ontouchmove = function() { return false; }
			window.onorientationchange = function() { document.body.scrollTop = 0; }
		</script>
	</body>
</html>