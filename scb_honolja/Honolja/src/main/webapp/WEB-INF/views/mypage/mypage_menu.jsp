<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
   <meta charset='utf-8'>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="css/styles_side.css">
   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
</head>

<body>

<br>

<div id='cssmenu'>
<ul>
   <li><a href="mypage_like.do">찜</a></li>
   <li><a href="mypage_rsvt.do">예약 현황</a></li>
   <li><a href="mypage_board.do">내가 쓴 글</a></li>
      <ul>
         <li class='has-sub'id="box"><a href='#'>쪽지함</a>
        <div style="display:none" id="boxlist">
		<ul>
			<li><a href="msg_boxR.do">받은 쪽지함</a></li>
			<li><a href="msg_boxS.do">보낸 쪽지함</a></li>
		</ul>
		</div>
		</li>
		
        <li class='has-sub'id="info"><a href="#">회원 관리</a>
        <div style="display:none"id="infolist">  
        <ul>
			<li><a href="mypageuser.do">회원 정보</a></li>
            <li><a href="mypageDelete.do">회원 탈퇴</a></li>
		</ul>
		</div>
		</li>
	</ul>
</div>
<script>

jQuery('#box').click(function(){
	if($('#boxlist').css("display")=="block"){
		jQuery('#boxlist').css("display","none");
	}else{jQuery('#boxlist').css("display","block");}
})
jQuery('#info').click(function(){
	if($('#infolist').css("display")=="block"){
		jQuery('#infolist').css("display","none");
	}else{jQuery('#infolist').css("display","block");}
})
</script>
</body>
</html>
