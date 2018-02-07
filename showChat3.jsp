<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- tip
	이곳에 필요한 객체들을 import 해야 합니다.
 -->    

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
/* 노말라이징 */
body,
ul,
li {
    margin: 0;
    padding: 0;
    list-style: none;
}

/* 라이브러리 */
.con {
    max-width: 1000px;
    margin: 0 auto;
}

/* 커스텀 */
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

body {
    font-family: "Noto Sans KR", sans-serif;
    overflow-y: hidden;
}

body,
html {
    height: 100%;
}

#chat-room {
    height: 100%;
    background-color: #6884b3;
    /* 임시 */
    outline: 2px solid black;
    position: relative;
}

#chat-room .message-box {
    padding: 0 0.7rem;
    overflow-y: scroll;
    height: calc(100% - 4.4rem);
}

#chat-room .message-group::before {
    content: attr(data-date-str);
    display: block;
    background-color: rgba(0, 0, 0, 0.15);
    border-radius: 1rem;
    text-align: center;
    padding: 0.3rem 0;
    color: white;
    font-size: 1.6rem;
}

#chat-room .chat-message {
    margin-left: 3rem;
    position: relative;
}

#chat-room .chat-message > section {
    position: absolute;
    top: 0;
    left: -3rem;
}

#chat-room .chat-message > span {
    display: block;
}

#chat-room .chat-message > section {
    font-size: 3rem;
}

#chat-room .chat-message::after {
    content: "";
    display: block;
    clear: both;
}

#chat-room .chat-message > div {
    background-color: white;
    float: left;
    padding: 0.8rem;
    border-radius: 1rem;
    clear: both;
    font-weight: bold;
    font-size: 1.46rem;
    box-shadow: 1px 1px 0 rgba(0, 0, 0, 0.3);
}

#chat-room .chat-message.mine > div {
    background-color: #fdf01b;
    float: right;
    box-shadow: -1px 1px 0 rgba(0, 0, 0, 0.3);
}

#chat-room .chat-message.mine > span {
    display: none;
}

#chat-room .chat-message.mine > section {
    display: none;
}

#chat-room .input-box {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
}

#chat-room .input-box #text-input {
    width: 100%;
    display: block;
    border: 0;
    outline: none;
    padding-right: 8.5rem;
    padding-left: 4.8rem;
    padding-top: 0.1rem;
    font-size: 1.4rem;
    line-height: 4rem;
    font-weight: bold;
    box-sizing: border-box;
}

#chat-room .input-box .btn-plus {
    position: absolute;
    top: 0;
    left: 0;
    width: 4rem;
    height: 100%;
    background-color: #d1d1d1;
}

#chat-room .input-box .btn-plus > i {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-45%);
    color: white;
    font-size: 3rem;
}

#chat-room .input-box .btn-submit {
    position: absolute;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
    padding: 10px;
    background-color: #fdf01b;
    padding: 10px;
    color: #bfb73d;
    border-radius: 3px;
    font-size: 1.3rem;
    box-shadow: 0 1px 10px rgba(0, 0, 0, 0.2);
    user-select: none;
}

#chat-room .input-box .btn-emo {
    position: absolute;
    right: 6rem;
    top: 50%;
    transform: translateY(-50%);
    font-size: 2rem;
    color: #cbcbcb;
    user-select: none;
}

#messageForm {
	margin-bottom:0;
}

#style-1::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
    background-color: #6884b3;
}

#style-1::-webkit-scrollbar {
    width: 12px;
    background-color: #f5f5f5;
}

#style-1::-webkit-scrollbar-thumb {
    border-radius: 10px;
    -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
    background-color: #555;
}
</style>
<script>

$(function(){
	
	var k = function() {
	    // val()은 엘리먼트가 가지고 있는 value 속성의 값을 가져온다.
	    var 메세지 = $('#chat-room .input-box #text-input').val();
	    
	    // 메세지 변수에 들어있는 값이 ''와 같다면
	    if ( 메세지 == '' ) {
	        // 함수를 더 이상 진행시키지 않고 여기서 종료시킨다.
	        return false;
	    }
	    
	    // tip
	    //	아래  '' 여기를 요청 url 작성하여 contoller와 통신하게 해야합니다.
	    
	    $('#messageForm').attr('action', '');
	    $('#messageForm').submit();
	    
	    $('#chat-room .message-box').scrollTop(99999999999);
	};
	
	//btn-submit 버튼을 클릭했을 때 k함수가 호출.
	$('#chat-room .input-box .btn-submit').click(k);
	
	// input 창에서 키보드 눌림 이벤트 발생시 함수를 실행하도록 예약
	$('#chat-room .input-box #text-input').keydown(function(e) {
	    // 만약 입력한 키코드가 13, 즉 엔터라면 함수를 실행한다.
	    if ( e.keyCode == 13 ) {
	        k();
	    }
	});
});
</script>
</head>
<body>
<div id="chat-room">
    <div class="message-box" id="style-1">
    	
        <div class="message-group" data-date-str="2018년 02월 07일 일요일">
        <!-- tip
        	class가 chat-message other인 부분은 다른 사람의 메시지를 보여주는 곳입니다. 
        -->
            <div class="chat-message other">
                <section><i class="fa fa-user"></i></section>
                <span>아들</span>
                <div>굿모닝!!!!</div>
            </div>
        <!-- tip
        	class가 chat-message mine인 부분은 나의 메시지를 보여주는 곳입니다. 
        -->    
            <div class="chat-message mine">
                <section><i class="fa fa-user"></i></section>
                <span>홍길동</span>
                <div>새벽공기가 쌀쌀하구나</div>
            </div>
        </div>
    </div>
    <div class="input-box">
    	<form name="messageForm" id="messageForm">
    		<!--tip
    			여기 있는 input 값을 controller에 넘겨서 왓슨에게 보내야합니다.
    			contorller에서는 name인 'message'로 매핑됩니다.
    		  -->
        	<input type="text" name="message" id="text-input">
        </form>
        <div class="btn-plus">
            <i class="fa fa-plus" aria-hidden="true"></i>
        </div>
        <div class="btn-emo">
            <i class="fa fa-smile-o" aria-hidden="true"></i>
        </div>
        <div class="btn-submit">
            <span>전송</span>
        </div>
    </div>
</div>

</body>
</html>