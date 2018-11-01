<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

	<title>[main.jsp]</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
    
    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css" rel="stylesheet" type="text/css" />
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
		
	<script type="text/javascript">	
	
		//진행률  표시
		function progress(){
			
			//select-option value 값
			var selector = document.getElementById("sel1");
		    var value = selector[selector.selectedIndex].value;
		    
		    //지역, 체크인, 체크아웃 입력 확인 Flag
		    var checkFlag = new Array();
		    
		    //true 개수 , 개수에 따라 35% / 70% / 100% 
		    var countTrue = 0;
		    
		    //진행률
		    var percent = 0;
		    
		    
		    
		    //Flag 초기화
		    for(var i; i<checkFlag.length; i++){
		    	checkFlag = false;
		    }
			
		    //지역이 선택되어 있으면 true 아니면 false
		    if(value == "선택"){
		    	checkFlag[0] = false;
		    }else{
		    	checkFlag[0] = true;
		    }
		    
		    //체크 인이 입력되어 있으면 true 아니면 false
		    if(document.getElementById("datepicker").value == ""){
		    	checkFlag[1] = false;
		    }else{
		    	checkFlag[1] = true;
		    }
		    
		    //체크 아웃이 입력되어 있으면 true 아니면 false
			if(document.getElementById("datepicker1").value == ""){
				checkFlag[2] = false
		    }else{
		    	checkFlag[2] = true
		    }
		    
		    //성인 인원 수 가 0이 되어 있으면,
			if(document.getElementById("adult").value == 0){
				checkFlag[3] = false
		    }else{
		    	checkFlag[3] = true
		    }
		    
			
			//true의 갯수 카운트
			for(var i=0; i<checkFlag.length; i++){
				
				if(checkFlag[i] == true){
					countTrue++;
				}
			}
			
			//개수에 따라 25% / 50% / 75% / 100% 
			switch(countTrue){
					
				case 1:
					percent = 25;
					color = "progress-bar-danger";
					break;
					
				case 2:
					percent = 50;
					color = "progress-bar-warning";
					break;
					
				case 3:
					percent = 75;
					color = "progress-bar-info";
					break;
					
				case 4:
					percent = 100;
					color = "progress-bar-success";
					break;
							
				default:
					percent = 0;
					color = "";
					break;
			}
		    

						
			var string = "<div class='progress'>";
			string += "<div class='progress-bar "+color+" progress-bar-striped active' role='progressbar' aria-valuenow='"+percent+"' aria-valuemin='0' aria-valuemax='100' style='width:"+percent+"%'>";
			string += percent + "% Complete";
			string += "</div>";
			string += "</div>";
				
			document.getElementById("progress").innerHTML = string;
			
		}
			
		//진행률 초기화
		function init(){
			count = 0;	
			document.getElementById("progress").innerHTML = "";
		}
		
		//공지사항 노출 기능	
		var notice_num = 0;
		
		function chgNotice(){
			
			var notices = new Array();
			
			notices[0] = "카카오 위치기반서비스 이용약관 변경 안내";
			notices[1] = "개인정보 처리방침 개정안내";
			notices[2] = "카카오 사칭 코인 세일 피싱 사이트 피해 주의 안내";		
			
			document.getElementById("notice").innerHTML = notices[notice_num];
			
			notice_num++;
			
			if(notice_num == 3)notice_num = 0;	
			
		}
		
		//공지사항 노출 기능 - JavaScript Ajax
		function chgNotice_ajax(){
			
			var xhr = new XMLHttpRequest();
			
				xhr.onreadystatechange = function(){
					if(this.readyState == 4 && this.status == 200){
						document.getElementById("notice").innerHTML = this.responseText;
					}
				};
				
				xhr.open("GET", "http://localhost:8080/honolja/main_notice.do", 'Y');
				xhr.send();
				
		}		
		
		//공지사항 노출 기능 - jQuery Ajax	
		$(function(){
			$('#notice_btn').click(function(){
				$.ajax({
					"url" : "http://localhost:8080/honolja/main_notice.do",
					"type" : "get",
					"data" : {test : $('#notice').val(), test2 :$('#notice').val()},
					"beforeSend" : function(){
						$('#notice').show();
						$('#notice').empty();
						$('#notice').html("Loading...");
						$('#notice').css("opacity", "0.2").stop().animate({opacity:1},300);
					},
					"success" : function(data){
						setTimeout(function(){
							//$('#notice').fadeOut();
							//$('#notice').empty();
							$('#notice').html(data);
						}, 300);
					},
					"error" : function(){
						$('#notice').fadeOut();
					}
				});
			});
		});
		
	
		//메인 검색 눌 체크
		function nullCheck(){
			
			var selector = document.getElementById("sel1");
		    var value = selector[selector.selectedIndex].value;
		    
		    var check_in = document.getElementById("datepicker").value;
		    var check_out = document.getElementById("datepicker1").value;
		    
		    var adult =  document.getElementById("adult").value;
		    
		    if(value == "선택"){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("지역을 선택해주세요.");
						$('#myModal').modal("show");
					});
				});
		    	return;
		    }
		    
		    if(adult == 0){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("성인이 0 일 수 없습니다.");
						$('#myModal').modal("show");
					});
				});
		    	return;
		    }
		    
		    if(check_in == ""){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("체크인을 입력하세요.");
						$('#myModal').modal("show");
					});
				});
		    	return;
		    }
		    
		    if(check_out == ""){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("체크아웃을 입력하세요.");
						$('#myModal').modal("show");
					});
				});
		    	return;
		    }
		    

		    
		    

		    
		    var in_string_array = new Array();
		    var out_string_array = new Array();   
		    
		    var in_array = new Array();
		    var out_array = new Array();
		    
		    in_string_array = check_in.split("/");
		    out_string_array = check_out.split("/");
		    
		    for(i in in_string_array){
		    	in_array[i] = parseInt(in_string_array[i]);
		    }
		    
		    for(i in out_string_array){
		    	out_array[i] = parseInt(out_string_array[i]);
		    }
		   
    		//체크인 연 <= 체크아웃 연
    		if(in_array[0] <= out_array[0]){
    			
    			//체크인 연 == 체크아웃 연
    			if(in_array[0] == out_array[0]){
    				
				    //만약에 체크인 월 <= 체크아웃 월 이면,
				    if(in_array[1] <= out_array[1]){
				    	
					    //만약에 체크인 월 == 체크아웃 월 이면,
					    if(in_array[1] == out_array[1]){
					    	
					    	//체크아웃 일 - 체크인 일  <= 10
					    	if(out_array[2] - in_array[2] <= 10 && out_array[2] - in_array[2] > 0){
					    		
					    		document.getElementById("nights").value = out_array[2] - in_array[2];
					    		document.getElementById("check_form").submit();
					    		
					    	//체크아웃 일 < 체크인 일
					    	}else if(out_array[2] - in_array[2] < 0){					   
								$(document).ready(function(){
									$('#alertbox').ready(function(){
										$("#error").html("체크아웃 일이 체크인 일보다 이전일 수 없습니다.");
										$('#myModal').modal("show");
									});
								});
				    		//체크아웃 일 == 체크인 일	
					    	}else if(out_array[2] == in_array[2]){					    		
								$(document).ready(function(){
									$('#alertbox').ready(function(){
										$("#error").html("체크아웃 일과 체크인 일이 같을 수 없습니다.");
										$('#myModal').modal("show");
									});
								});
					    	}else{					    		
								$(document).ready(function(){
									$('#alertbox').ready(function(){
										$("#error").html("10일 이상 예약이 불가합니다.");
										$('#myModal').modal("show");
									});
								});
					    	}
					    
					    //만약에 체크인 월 < 체크아웃 월 이면,
					    }else{
					    	
					    	//체크아웃 월 - 체크인 월 == 1
					    	if(out_array[1] - in_array[1] == 1){
		
					    		//(체크인 월의 말일 - 체크인 일) + (체크아웃 일) <=10;
					    		if(endOfDay(in_array[1]) - in_array[2] + out_array[2] <= 10){
					    			
					    			document.getElementById("nights").value = endOfDay(in_array[1]) - in_array[2] + out_array[2];
					    			document.getElementById("check_form").submit();
    							
					    		}else{					    			
									$(document).ready(function(){
										$('#alertbox').ready(function(){
											$("#error").html("10일 이상 예약이 불가합니다.");
											$('#myModal').modal("show");
										});
									});
					    		}
					    	}else{					    		
								$(document).ready(function(){
									$('#alertbox').ready(function(){
										$("#error").html("1달 이내에만 예약이 가능합니다.");
										$('#myModal').modal("show");
									});
								});
					    	}
					    }				  	
				    }else{				    	
						$(document).ready(function(){
							$('#alertbox').ready(function(){
								$("#error").html("체크인 월이 체크아웃 월보다 클 수 없습니다.");
								$('#myModal').modal("show");
							});
						});
				    }
    			//체크인  연< 체크아웃 연
    			}else{
    			
    				//체크 아웃 연 - 체크 인 연 == 1
    				if(out_array[0] - in_array[0] == 1){	
    				
    					//체크인 월== 11월 && 체크 아웃 월== 1월 
    					if(in_array[1] == 11 && out_array[1] == 1){
    						
    						//(11월 말일 - 체크인 일) + 체크아웃 일 <= 10; 
    						if(endOfDay(11) - in_array[2] + out_array[2] <= 10){
 
    							document.getElementById("nights").value = endOfDay(11) - in_array[2] + out_array[2];
    							document.getElementById("check_form").submit();
					    
    						}else{    							
    							$(document).ready(function(){
    								$('#alertbox').ready(function(){
    									$("#error").html("10일 이상 예약이 불가합니다.");
    									$('#myModal').modal("show");
    								});
    							});
    						} 	
    					}else{    						
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("1달 이내에만 예약이 가능합니다.");
									$('#myModal').modal("show");
								});
							});
    					}
    				}else{    					
						$(document).ready(function(){
							$('#alertbox').ready(function(){
								$("#error").html("기간이 1년 이상 차이 납니다.");
								$('#myModal').modal("show");
							});
						});
    				}
    			}	
    		}else{    			
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("체크인 연도는 체크아웃 연도보다 클 수 없습니다.");
						$('#myModal').modal("show");
					});
				});
    		}
			
		}
		
		function endOfDay(month){
			
			var thirty_one = [1,3,5,7,8,10,12];
			var thirty = [4,6,9,11];
			var twenty_eight = 2;
			
			var day;
					
			for(i in thirty_one){
				if(thirty_one[i] == month){
					day = 31;
				}
			}
			
			for(i in thirty){
				if(thirty[i] == month){
					day = 30;
				}
			}
			
			if(twenty_eight[i] == month){
				day = 28;
			}	
			
			return day
		}
		
		function countPlus(id){
			
			var value = document.getElementById(id).value;		
			
			if(value == 9){
				document.getElementById(id).value = 9;
			}else{
				value++;
				document.getElementById(id).value = value;
			}
			
		}
		
		function countMinus(id){
			
			var value = document.getElementById(id).value;		
			
			if(value == 0){
				document.getElementById(id).value = 0;
			}else{
				value--;
				document.getElementById(id).value = value;
			}
			
		}
		
	</script>
     
</head>
<body style="margin-top: 50px;">
	
	<!-- 상단 바 -->
	<!-- checked는 로그인 후, session 값 이름이며. 로그인시 헤더의 버튼을 변경하는데 필요하다. -->
	<!-- access_token은 네이버 로그인 후, 해당 아이디의 개인정보를 끌어오는데 필요하다. -->
	<!-- host는 로그인 후, 팝업을 닫은 후 새로고침 할 페이지 이다. -->
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="access_token" value="${access_token}"></c:param>
		<c:param name="host" value="main.do"></c:param>
		<c:param name="u_member" value="${u_member}" />
	</c:import>
	
	<!-- Modal(== alert) 기능 구현 시 필요 -->
	<jsp:include page="modal.jsp" />
	
	<!-- 네이버 로그인 후, 최초 회원가입 일때 회원가입 페이지로 이동 -->
	<c:if test="${u_id != null}">
		<script>
			location.href = "m_join.do?u_id=${u_id}";
		</script>
	</c:if>

	<!-- 카로셀 시작 -->
	<div class="container" style = "width:100%; position: relative; padding: 0;">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
		    <ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
		    </ol>
	
			<!-- Wrapper for slides -->
			<div class="carousel-inner">
				<div class="item active">
			        <img src="resources/main_images/1.jpg" alt="Los Angeles" style="width:100%;height:650px;">
			        <div class="carousel-caption">
						<h3></h3>
						<p></p>
			        </div>
				</div>

				<div class="item">
					<img src="resources/main_images/2.jpg" alt="Chicago" style="width:100%;height:650px;">
					<div class="carousel-caption">
						<h3></h3>
						<p></p>
		        	</div>
				</div>
		    
				<div class="item">
		        <img src="resources/main_images/3.jpg" alt="New York" style="width:100%;height:650px;">
			        <div class="carousel-caption">
						<h3></h3>
						<p></p>
			        </div>
				</div>
			</div>
	
		    <!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
				<span class="sr-only">Previous</span>
		    </a>
		    <a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
				<span class="sr-only">Next</span>
		    </a>
		</div>

		<div style="position: absolute; 
					left: 50%; 
					top: 50%;
					transform: translate(-50%,-50%); 
					background-color: white; 
					padding: 20px; 
					border-radius: 20px; 
					text-align: center;">	
					

					
			<!-- 지역 / 체크인 / 체크아웃 검색 창 시작 -->
			<form id = "check_form" action="guestlocation.do">
				<div class="form-group">
					<label for="sel1">지역</label>
					<select class="form-control" id="sel1" name="g_addr" onchange="progress();">
						<option>선택</option>
						<option value="seoul">서울</option>
						<option value="gyeonggi">경기</option>
						<option value="inchun">인천</option>
						<option value="gangwon">강원</option>
						<option value="chungbuk">충북</option>
						<option value="chungnam">충남</option>
						<option value="jeollabuk">전북</option>
						<option value="jeollanam">전남</option>
						<option value="gyeongbuk">경북</option>
						<option value="gyeongnam">경남</option>
						<option value="jeju">제주</option>
					</select>
				</div>
				
				<!-- 인원 수 입력 -->
				<div class="form-group">
					<table style="width: 100%;">
						<tr>
							<td>
								<label for="usr" style="display: block;">성인</label>
								<a onclick="countMinus('adult');progress();" href="#" style="color: navy;"><span class="glyphicon glyphicon-minus"></span></a>
								&nbsp;&nbsp;<input id = "adult" name = "adult"  type="text" class="form-control" id="usr" style="width: 35px; display: inline;" value="0" readonly="readonly">&nbsp;&nbsp;
								<a onclick="countPlus('adult');progress();" href="#" style="color: navy;"><span class="glyphicon glyphicon-plus"></span></a>
							</td>
							<td>
								<label for="usr" style="display: block;">아동</label>
								<a onclick="countMinus('child');" href="#" style="color: navy;"><span class="glyphicon glyphicon-minus"></span></a>
								&nbsp;&nbsp;<input id = "child" name = "child" type="text" class="form-control" id="usr" style="width: 35px; display: inline;" value="0" readonly="readonly">&nbsp;&nbsp;
								<a onclick="countPlus('child');" href="#" style="color: navy;"><span class="glyphicon glyphicon-plus"></span></a>
							</td>
						</tr>
					</table>
				</div>
				
				<!-- Check-IN 날짜 -->
				<label for="sel1">Check-IN</label>							
					<div><input readonly="readonly" type = "text" name="check_in" id="datepicker" width="276" onchange="progress();"/></div>
				<br>
					
				<!-- Check-OUT 날짜 -->
				<label for="sel1">Check-OUT</label>
					<div><input readonly="readonly" type = "text" name="check_out" id="datepicker1" width="276" onchange="progress();"/></div><!-- readonly="readonly" -->
				<br>
				
				<div id = "progress"></div>

				<br>
				<div class="btn-group">
					<input id = "nights" type="hidden" name = "nights">
					<button type="button" class="btn btn-primary" onclick = "nullCheck();">CHECK</button>
					<button type="reset" class="btn btn-primary" onclick = "init();">RESET</button>
				</div>				
			</form>
		</div>
	</div>
	
    <script>
    
    	var today_year = new Date().getFullYear();
    	var today_month = new Date().getMonth();
    	var today_date = new Date().getDate();
    	var get_check_in = (today_year + "/" + (today_month + 1) + "/" + today_date).split("/");
    
    	$('#datepicker').datepicker({
    		format: 'yyyy/mm/dd',
    		value: today_year + "/" + (today_month + 1) + "/" + today_date,
    		close: function(){
    			get_check_in = $('#datepicker').datepicker().value().split("/");
    			$('#datepicker1').datepicker().destroy();
    			$('#datepicker1').datepicker({
    	    		format: 'yyyy/mm/dd',
    	    		value: get_check_in[0] + "/" + get_check_in[1] + "/" + get_check_in[2],
    	    		minDate: new Date(get_check_in[0], get_check_in[1]-1, get_check_in[2]),
    	    		maxDate: new Date(get_check_in[0], get_check_in[1]-1, parseInt(get_check_in[2])+10)
    	    	});
    		},
    		minDate: new Date(today_year,today_month,today_date),
    		maxDate: new Date(today_year, parseInt(today_month)+3, today_date)
    	});
    
		$('#datepicker1').datepicker({
    		format: 'yyyy/mm/dd',
    		value: today_year + "/" + (today_month + 1) + "/" + today_date,
    		minDate: new Date(today_year, today_month, today_date),
    		maxDate: new Date(today_year, today_month, parseInt(today_date)+10)
    	});

        
    </script>
    
   	<!-- 공지사항 노출 부 -->
	<div id = "main_notice" class="alert" style="margin: 0; background-color: #f8f8f8;">
		<table style="width: 100%;">
			<tr>
				<td width="95%">
					<strong>&nbsp;&nbsp;&nbsp;&nbsp;공지사항&nbsp;&nbsp;:&nbsp;&nbsp;</strong>
					<span id="notice">${notice }</span>
				</td>
				<td> 
					<input id = "notice_btn" class="btn" type = "button" value = "&nbsp;&nbsp;>&nbsp;&nbsp;" onclick="" >
				</td>
			</tr>
		</table>
	</div>

	<c:import url="http://localhost:8080/honolja/footer.do"></c:import>
		
	${checked }<br>
	${access_token}<br>
</body>
</html>