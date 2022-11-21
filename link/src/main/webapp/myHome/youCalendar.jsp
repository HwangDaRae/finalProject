<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script type="text/javascript">


</script>
<style>
a{
color : black !important
}
.fc .fc-daygrid-day-frame {
    position: relative;
    min-height: 100%; 
    border-radius: 15px;
        
        
}
.fc .fc-toolbar {
background-color: black;
border-radius: 15px;
}
.fc .fc-toolbar-title {
    font-size: 1.75em;
    margin: 0;
    color : white;
    border-radius: 15px;
}
.fc-direction-ltr .fc-button-group > .fc-button:not(:last-child) {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
    background-color: #5F0080;
    border-radius: 15px 0px 0px 15px ;
}
.fc-direction-ltr .fc-button-group > .fc-button:not(:first-child) {
    margin-left: -1px;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    background-color: #5F0080;
    border-radius: 0px 15px 15px 0px ;
}
.fc-timeGridWeek-button{
border-radius: 0px 0px 0px 0px  !important;
}

.fc-direction-ltr .fc-toolbar > * > :not(:first-child) {
    margin-left: 0.75em;
    background-color: #5F0080;
    border-radius: 15px;
}
.fc, .fc *, .fc *:before, .fc *:after {
    box-sizing: border-box;
    border-radius: 15px; 
}
.fc .fc-scrollgrid-liquid {
    height: 100%;
    background-color: #F5F6F7;
}
.fc-direction-ltr .fc-daygrid-event.fc-event-end, .fc-direction-rtl .fc-daygrid-event.fc-event-start {
    margin-right: 2px;
    width: 90px;
}
.fc .fc-scrollgrid-section-header > *, .fc .fc-scrollgrid-section-footer > * {
    border-bottom-width: 0;
    border-radius: 15px 15px 0px;
}
.fc .fc-scrollgrid-section > td {
    border-radius: 0px 0px 15px 15px;
}
</style>
</head>
<body>
<div id='calendar'></div>
<script>

  window.onload=function() {
	var result_var = null;	
	var youCalendarId = $("#youCalendarId").val();
	console.log(youCalendarId);
	
	$.ajax({
		url : "/myHomeRest/json/getMeetList", // 어디로 갈거니? // 갈 때 데이터
		type : "POST", // 타입은 뭘 쓸거니?
		datatype : "json",
		 data		:  JSON.stringify({searchKeyword:youCalendarId}),
		contentType : "application/json",
		success : function(JSONData, status) { 
			   	
	              result_val = new Array;		
				  console.log(result_val);
		 
				$.each(JSONData, function(index, item) { // 데이터 =item
				       
					console.log(item);
                    result_val.push(item);                      
				
				});
			    
				var calendarEl = document.getElementById('calendar');
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			    	
			      initialView: 'dayGridMonth',
			      headerToolbar: {
			        left: 'prev,next today',
			        center: 'title',
			        right: 'dayGridMonth,timeGridWeek,timeGridDay'
			      },
			      
			      events:  result_val
			    	 
			    	  
			    
			    });
			  
			    calendar.render();
				
					
		
		},
		error : function(){
			
			var calendarEl = document.getElementById('calendar');
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		    	
		      initialView: 'dayGridMonth',
		      headerToolbar: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'dayGridMonth,timeGridWeek,timeGridDay'
		      },
		             	     	  
		    
		    });
		  
		    calendar.render();
			
			
		}
	});

  };


	 

 
</script>

<input type="hidden" name="youCalendarId" id="youCalendarId" value="${getUser.userId}">




</body>
</html>