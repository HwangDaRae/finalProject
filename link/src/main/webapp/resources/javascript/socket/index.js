var sock = null;

$(document).ready(function () {
	connectWs();
});

function connectWs() {

	sock = new SockJS('http://localhost:8080/echo');

	sock.onopen = function () {
		console.log('open');

	};

	sock.onmessage = function (e) {
		console.log('message', e.data);

		alert("message" + e.data);
		
	};

	sock.onclose = function () {
		console.log("체크" + sock);
		console.log('close');
	};

};

function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;

	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
};