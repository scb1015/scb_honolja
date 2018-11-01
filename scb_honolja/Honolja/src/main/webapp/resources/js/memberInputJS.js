function insertCheck(){
		var u_id = myform.u_id.value;
		var u_pwd = myform.u_pwd.value;
		var u_pwd2 = myform.u_pwd2.value;
		var u_name = myform.u_name.value;
		var year = myform.year.value;
		var month = myform.month.value;
		var day = myform.day.value;
		var u_phn = myform.u_phn.value;
		var u_gender = myform.u_gender.value;
		var u_email = myform.u_email.value;
		
		var pwd = document.getElementById("pwd");
		var pwd2 = document.getElementById("pwd2");
		
	//radio버튼
	function radioCheck(v, id){
		if(v == "점주"){
			document.getElementById(id).style.display = ""; //보여줌
		}else{
			document.getElementById(id).style.display = "none"; //숨김
		}
	}//radioCheck end
		
	//ID중복체크 버튼 눌렀을때 팝업창 열어주기
	function idCheck(){
		alert("test");
		var x = (window.screen.width / 2) - 250;
		var y = (window.srceen.wdith / 2) - 65;
		
		window.open("idCheck.jsp", 'idCheck', 'menubar=no, statusbar=no, height=150, wdith=390, left='+x+', top='+y+', screenX='+x+', screenY='+y);
		
	}//idChec kend
		
	function pwdCheck(){
		if(u_pwd.length>7 || u_pwd.length>13){
			if(u_pwd == u_pwd2){
				pwd2.innerHTML="비밀번호가 일치합니다.";
			}else{ pwd2.innerHTML="비밀번호가 일치하지 않습니다."; }
		}else{ 
			pwd.innerHTML="8~12자리 입력해주세요";
		}
	}//pwdCheck end
	
	
		
		if(u_id == "" || u_id == null){
			alert("아이디를 입력해주세요.");
			return;
		}else if(u_pwd == "" || u_pwd == null){
			alert("비밀번호를 입력해주세요.");
			return;
		}else if(u_name == "" || u_name == null){
			alert("이름을 입력해주세요.");
			return;
		}else if(year == "" || year == null){
			alert("년도를 선택해주세요.");
		}else if(month == "" || month == null){
			alert("월을 선택해주세요.");
		}else if(day == "" || day == null){
			alert("일을 선택해주세요.");
		}else if(u_phn == "" || u_phn == null){
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}else if(u_email == "" || u_email == null){
			alert("이메일을 입력해주세요");
			return;
		}//end
		myform.submit();
	}//insertCheck end