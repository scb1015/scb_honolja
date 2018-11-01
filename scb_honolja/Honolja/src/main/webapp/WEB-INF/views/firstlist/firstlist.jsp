<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="application/json; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
    
<title>[firstlist.jsp]</title>
	
<link href="./resources/css/slidebtn.css" type="text/css" rel="stylesheet">
<link href="./resources/css/filter.css" type="text/css" rel="stylesheet">
<link href="./resources/css/header.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/detail.css" />
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 달력 사용하기  -->
<script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<!-- naver MAP API 받아오기 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=U7Zqn2z2m6oFf4fS07JV&submodules=geocoder"></script>
 	
<style type="text/css">
a {text-decoration: none;}
a:hover{ color:#337ab7; text-decoration: none;}
a:link{ color: #212121; text-decoration: none;}
a:visited{color: #212121; text-decoration: none;}
</style>
<script type="text/javascript">
	var x= new Array();
	var y= new Array();
	var name= new Array();
	var url= new Array();
	var g_no = new Array();
	var adult; var child; var check_in; var check_out; var area; var nights;
	</script>
	<script>
	function like_btn(btn_flag_val, g_no_val, like_id_val){		
		var u_id_val = "${u_id}";
		if("${u_id}" != 'none'){
			$.ajax({
				"url" : "http://localhost:8080/honolja/guestlike.do",
				"type" : "get",
				"data" : {
							g_no : g_no_val,
							u_id : u_id_val, 
							btn_flag : btn_flag_val,
							like_id : like_id_val
						},
				"success" : function(data){			
					$('#'+ like_id_val).html(data);	
				}
			});
		}else{$(document).ready(function(){
			$('#alertbox').ready(function(){
				$("#error").html("로그인 후 가능합니다.");
				$('#modal').modal("show");
			});
		});} 
	}
	</script>
	<script>
	//메인 검색 null 체크
	function nights_11(){
	    var check_in = document.getElementById("startDate").value;
	    var check_out = document.getElementById("endDate").value;

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
				    		document.getElementById("form").submit();
				    		
				    	//체크아웃 일 < 체크인 일
				    	}else if(out_array[2] - in_array[2] < 0){					   
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("체크아웃 일이 체크인 일보다 이전일 수 없습니다.");
									$('#modal').modal("show");
								});
							});
			    		//체크아웃 일 == 체크인 일	
				    	}else if(out_array[2] == in_array[2]){					    		
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("체크아웃 일과 체크인 일이 같을 수 없습니다.");
									$('#modal').modal("show");
								});
							});
				    	}else{					    		
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("10일 이상 예약이 불가합니다.");
									$('#modal').modal("show");
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
				    			document.getElementById("form").submit();
							
				    		}else{					    			
								$(document).ready(function(){
									$('#alertbox').ready(function(){
										$("#error").html("10일 이상 예약이 불가합니다.");
										$('#modal').modal("show");
									});
								});
				    		}
				    	}else{					    		
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("1달 이내에만 예약이 가능합니다.");
									$('#modal').modal("show");
								});
							});
				    	}
				    }				  	
			    }else{				    	
					$(document).ready(function(){
						$('#alertbox').ready(function(){
							$("#error").html("체크인 월이 체크아웃 월보다 클 수 없습니다.");
							$('#modal').modal("show");
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
							document.getElementById("form").submit();
				    
						}else{    							
							$(document).ready(function(){
								$('#alertbox').ready(function(){
									$("#error").html("10일 이상 예약이 불가합니다.");
									$('#modal').modal("show");
								});
							});
						} 	
					}else{    						
						$(document).ready(function(){
							$('#alertbox').ready(function(){
								$("#error").html("1달 이내에만 예약이 가능합니다.");
								$('#modal').modal("show");
							});
						});
					}
				}else{    					
					$(document).ready(function(){
						$('#alertbox').ready(function(){
							$("#error").html("기간이 1년 이상 차이 납니다.");
							$('#modal').modal("show");
						});
					});
				}
			}	
		}else{    			
			$(document).ready(function(){
				$('#alertbox').ready(function(){
					$("#error").html("체크인 연도는 체크아웃 연도보다 클 수 없습니다.");
					$('#modal').modal("show");
				});
			});
		}
		
	}
</script>


</head>
<body id="page-top" style="margin-top:51px;" >
   <c:import url="http://localhost:8080/honolja/header.do">
      <c:param name="checked" value="${checked}"></c:param>
      <c:param name="host" value="guestlist.do?area=my&adult=${param.adult}&child=${param.child}&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}"></c:param>
      <c:param name="area" value="${param.area}"></c:param>
      <c:param name="adult" value="${param.adult}"></c:param>
      <c:param name="child" value="${param.child}"></c:param>
      <c:param name="check_in" value="${param.check_in}"></c:param>
      <c:param name="check_out" value="${param.check_out}"></c:param>
      <c:param name="nights" value="${param.nights}"></c:param>
   </c:import>
   	<!-- Modal(== alert) 기능 구현 시 필요 -->
	<jsp:include page="modal.jsp" />
     
<!-- 달력 시작 -->  
<form id="form" name="form" action="guestlist.do" method="get">
<!-- 숙박일 수 -->
<input type="hidden" id = "nights" name="nights" />
	<input type="hidden" name="g_addr"value="${param.g_addr}">
	<input type="hidden" name="adult"value="${param.adult}">
	<input type="hidden" name="child"value="${param.child}">
	<input type="hidden" name="nights"value="${param.nights}">
	<input type="hidden" name="sval"value="${param.sval}">
	<input type="hidden" name="sortFilter"value="${param.sortFilter}">
	<input type="hidden" name="basic"value="${param.basic}">

<div style="position:fixed; background-color:#D5D5D5;width:100%;height:50px;margin-bottom:0;margin-top:0; border:0;">
	<div style="margin-top:10px;">
	<jsp:include page="../main/modal.jsp" />
		<!-- 체크 인 날짜 -->
    	<div style="position:fixed;margin-left:1.5%;" >
    		<span>체크인</span>
    	</div>
    	<div style="position:fixed;margin-left:4%;">
    		<input type="text" aria-label="YYYY/MM/DD" name="check_in"  id="startDate" value="${param.check_in}"
    		 width="150px" placeholder="날짜 미정"  style="color:black;" onchange="date1()"/> 
    	</div>
   		<!-- 체크 아웃 날짜 -->
    	<div style="position:fixed; margin-left:13%; "><!--margin-bottom:50%;  -->
    		<span>체크아웃</span>
    	</div>
    	<div style="position:fixed; margin-left:16.5%; margin-bottom:80%;">
    		<input type="text" aria-label="YYYY/MM/DD" name="check_out" id="endDate" value="${param.check_out}"
    		 width="150px" placeholder="날짜 미정"  style="color:black;" onchange="date2()"/>
    	</div>
    	<div style="position:fixed; margin-left:24.5%; "><!-- margin-bottom:50%; -->
    		<img src="https://yaimg.yanolja.com/joy/pw/place/bullet-datepicker-check.svg" >
    		<span>${param.nights}박 ${param.nights+1}일</span> 
    	</div>
    	<div style="position:fixed; margin-left:29.5%; margin-bottom:80%;">
    		<input type="button" class="btn btn-primary" value="날짜변경" size = "5px" style="size:6px;"onclick="nights_11()">
		</div>
    </div>
</div>

</form>
	<script type="text/javascript">
	//datepicker 생성 및 날짜 수정시 이벤트
	$(function() {
		var now = new Date();
		var today = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate();
		var today1 = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + (now.getDate() + 1);
		
		$("#startDate").datepicker({ 
			header: true,
	        //value: ,
	        format: 'yyyy/mm/dd',
	        minDate: today
	    });
		$("#endDate").datepicker({ 
			header: true,
	        //value: today1,
	        format: 'yyyy/mm/dd',
	        minDate: function () {
	            return  $('#startDate').val(); 
	        }
	    }); 
	});
	
	function date1(){
		var url = "guestlist.do";
		var name = "check_in";
		var value =  $("#startDate").datepicker({ format: 'yyyy/mm/dd'}).val();

		var form = document.createElement("form");
    		form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "get");
    	    form.setAttribute("action", url);

		var hiddenField = document.createElement("input");
    		hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", name);
    	    hiddenField.setAttribute("value", value);

			form.appendChild(hiddenField);
			document.body.appendChild(form);
	}
	function date2(){
		var url = "guestlist.do";
    	var name1 = "check_out";
    	var value1 = $("#endDate").datepicker({ format: 'yyyy/mm/dd'}).val();
    	
    	var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "get");
	    form.setAttribute("action", url);
	    
		var hiddenField1 = document.createElement("input");
		hiddenField1.setAttribute("type", "hidden");
		hiddenField1.setAttribute("name1", name1);
		hiddenField1.setAttribute("value1", value1);
		
		form.appendChild(hiddenField1);
		document.body.appendChild(form);
	}
   </script>   
   <!-- 달력 끝 -->  
	<br>
	<div style="padding-top:40px; ">
   	<!-- 지도 우측배치로 고정 -->
		<div style= "right:0; position:fixed;width:40%;height:100%;">	
			<div id="map" style="width:100%;height:100%;margin-top:10px;"></div>
		</div>
	<!-- 지도 끝-->
		
        <!-- 필터 담을것. 기본순/테마/가격대선택/예약가능/.......필터초기화-->
	<div style="left:0; width:60%; padding-left: 30px; padding-right:30px;padding-left:30px;">
    	<div style="padding-top: 13px;padding-bottom: 12px;"><p>
     		<button type="button" class="filter__item" name="popoverButton" style="margin-right:27px;"id="firstfilter">
     			<span class="filter__option"id="basics">기본순</span>
     			<i style="width: 17px;height: 16px;	background: url(https://yaimg.yanolja.com/joy/pw/search/filter-icon__arrow_bottom.svg) 50%;
   				display: inline-block;overflow: hidden;font-size: 0;line-height: 0;text-indent: -9999px; vertical-align: middle;"></i>
     		</button> 
     		
     		<button type="button" class="filter__item" name="popoverButton"style="margin-right:27px;" id="secondfilter">
				<c:choose>
  					<c:when test="${low_price=='a'}">
   						<span class="filter__option">0~20000</span>
					</c:when>
					<c:when test="${low_price=='b'}">
						<span class="filter__option">20000~40000</span>
					</c:when>
					<c:when test="${low_price=='c'}">
						<span class="filter__option">40000~60000</span>
					</c:when>
					<c:when test="${low_price=='d'}">
						<span class="filter__option">60000~80000</span>
					</c:when>
					<c:when test="${low_price=='e'}">
						<span class="filter__option">60000~80000</span>
					</c:when>
					<c:otherwise>
						<span class="filter__option">가격대선택</span>
					</c:otherwise>
				</c:choose>   
     			<i style="width: 17px;height: 16px; background: url(https://yaimg.yanolja.com/joy/pw/search/filter-icon__arrow_bottom.svg) 50%;
   				display: inline-block;overflow: hidden;font-size: 0;line-height: 0;text-indent: -9999px; vertical-align: middle;"></i>
     		</button> 
     		
     		<button type="button" class="filter__refresh-btn f-right" style="margin-left: 50%;padding-top: 0;"id="refresh">
     			<i class="filter-icon filter-icon__refresh"></i>
     			<em>필터 초기화</em>
     		</button>
     	</div>
    <!-- 해당 필터 클릭 시 이벤트 -->
	<script>
	//기본순 필터이벤트
 		jQuery('#firstfilter').click(function () {  
 	    	if($("#firstfilt").css("display") == "table"){
 	      		jQuery('#firstfilt').css("display", "none");
 	      	    jQuery('#secondfilt').css("display", "none"); 
			} else {  
 	      		jQuery('#firstfilt').css("display", "table");
 	      	    jQuery('#secondfilt').css("display", "none"); 
			} 
		});
 	//가격대선택 필터이벤트
		jQuery('#secondfilter').click(function () {  
			if($("#secondfilt").css("display") == "table"){
		    	jQuery('#secondfilt').css("display", "none");
		       	jQuery('#firstfilt').css("display", "none");
			} else {  
		    	jQuery('#secondfilt').css("display", "table");
		        jQuery('#firstfilt').css("display", "none");
			}
		});
	//필터 초기화 이벤트
		$(document).ready(function(){
 			jQuery('#refresh').click(function(){
 				location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
	        		+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}";
 			});
 		});
	</script>
	<!-- 해당 필터 클릭 시 이벤트 끝-->
	<!-- 기본순 필터 -->
     <form action="guestlist.do" method="get">
     	<input type="hidden" name="g_addr"value="my">
		<input type="hidden" name="adult"value="${param.adult}">
		<input type="hidden" name="child"value="${param.child}">
		<input type="hidden" name="check_in"value="${param.check_in}">
		<input type="hidden" name="check_out"value="${param.check_out}">
		<input type="hidden" name="nights"value="${param.nights}">
		<input type="hidden" name="sortFilter"value="${param.sortFilter}">
		<input type="hidden" id ="a" name="a" value="${basic}">
		
     	<div data-popover-content="true" id="firstfilt" 
     	style="box-sizing: border-box;
     	width:150px;
     	height:90px;
     	position:absolute;
    	box-shadow: 0 3px 7px rgba(0,0,0,.2);
    	border-top: 2px solid #ff2d60;
    	background-color: #fff;
    	padding: 20px;
    	clear: both;
    	display:none;">
 	    	<div>
 	      		<div>
 	      			<div>
 	      				<input type="radio" id="basic" name="basic" value="basic">
 	      				<label for="basic">기본순</label>
 	      			</div>
 	      			<div>
 	      				<input type="radio" id="like" name="basic" value="like">
 	      				<label for="like">인기순</label>
 	      			</div>
 	      			<div>
 	      				<input type="radio" id="reply" name="basic" value="reply">
 	      				<label for="reply">댓글 많은 순</label>
 	      			</div>
 	      			<div>
 	      				<input type="radio" id="priceup" name="basic" value="priceup">
 	      				<label for="priceup">가격 낮은 순</label>
 	      			</div>
 	      			<div>
 	      				<input type="radio" id="pricedown" name="basic" value="pricedown">
 	      				<label for="pricedown">가격 높은 순</label>
 	      			</div>
 	      		</div>
 	      	</div>
		</div>
	</form>
		<script type="text/javascript">
		//버튼 span에 지정된 값 가져오기
		$(document).ready(function(){
			var basic1 = document.getElementById("a").value;
			if(basic1=="basic"){$('#basics').html('기본순');$('#basic').is(":checked");}
			else if(basic1=="like"){$('#basics').html('인기순');$('#basic').is(":checked");}
			else if(basic1=="reply"){$('#basics').html('댓글 많은 순');$('#basic').is(":checked");}
			else if(basic1=="priceup"){$('#basics').html('가격 낮은 순');$('#basic').is(":checked");}
			else if(basic1=="pricedown"){$('#basics').html('가격 높은 순');$('#basic').is(":checked");}
		});
		//기본순
		$(document).ready(function(){
	    	$("#basic").change(function(){
	        	if($("#basic").is(":checked")){
	        		location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
	        		+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}&sortFilter=${param.sortFilter}&basic=basic";
	    	    }
		    });
		});
		
		//인기순(좋아요 많은 순)
		$(document).ready(function(){
	    	$("#like").change(function(){
	        	if($("#like").is(":checked")){
	        		location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
		        	+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}&sortFilter=${param.sortFilter}&basic=like";
	    	    }
		    });
		});
		
		//댓글 많은 순
		$(document).ready(function(){
	    	$("#reply").change(function(){
	        	if($("#reply").is(":checked")){
	        		location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
		        		+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}&sortFilter=${param.sortFilter}&basic=reply";
	    	    }
		    });
		});
		
		//가격 낮은 순
		$(document).ready(function(){
	    	$("#priceup").change(function(){
	        	if($("#priceup").is(":checked")){
	        		location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
		        		+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}&sortFilter=${param.sortFilter}&basic=priceup";
	    	    }
		    });
		});
		
		//가격 높은 순
		$(document).ready(function(){
	    	$("#pricedown").change(function(){
	        	if($("#pricedown").is(":checked")){
	        		location.href="guestlist.do?area=my&adult=${param.adult}&child=${param.child}"
		        		+"&check_in=${param.check_in}&check_out=${param.check_out}&nights=${param.nights}&sortFilter=${param.sortFilter}&basic=pricedown";
	    	    }
		    });
		});
		</script>
		<!-- 가격대 선택 필터-->
		<form id="priceform" action="guestlist.do" method="get">
		<input type="hidden" name="g_addr"value="my">
		<input type="hidden" name="adult"value="${param.adult}">
		<input type="hidden" name="child"value="${param.child}">
		<input type="hidden" name="check_in"value="${param.check_in}">
		<input type="hidden" name="check_out"value="${param.check_out}">
		<input type="hidden" name="nights"value="${param.nights}">
		<input type="hidden" name="basic"value="${param.basic}">
		<input type="hidden" name="basic"value="${param.btn_flag}">
		
		<div id="secondfilt" 
     	style="box-sizing: border-box;
     	width:180px;
     	height:90px;
     	position:absolute;
    	box-shadow: 0 3px 7px rgba(0,0,0,.2);
    	border-top: 2px solid #ff2d60;
    	background-color: #fff;
    	padding: 20px;
    	clear: both;
    	margin-left:5%;
    	display:none;"><!--data-popover-content="true"  -->
 	    	<div id="checkbox">
 	      		<div>
 	      			<div>
 	      				<input type="checkbox" id="one" name="sortFilter" value="a">
 	      				<label for="one">0~20000</label>
 	      			</div>
 	      			<div>
 	      				<input type="checkbox" id="two" name="sortFilter" value="b">
 	      				<label for="two">20000~40000</label>
 	      			</div>
 	      			<div>
 	      				<input type="checkbox" id="three" name="sortFilter" value="c">
 	      				<label for="three">40000~60000</label>
 	      			</div>
 	      			<div>
 	      				<input type="checkbox" id="four" name="sortFilter" value="d">
 	      				<label for="four">60000~80000</label>
 	      			</div>
					<div>
 	      				<input type="checkbox" id="five" name="sortFilter" value="e">
 	      				<label for="five">80000~100000</label>
 	      			</div>
 	      			<div style="margin-left:60%;">
 	      				<button type="submit" id="pricebtn" style = "width:60px;background-color:#ff2d60; color:white;">
 	      				<em>확인</em>
 	      				</button> 
 	      			</div>
 	      		</div>
 	      	</div>
		</div>	
		</form>
    </div>
		<!-- 필터 끝-->
		<!-- Guest house 목록을 리스트로 뽑아주기 -->
	<table id="ajaxTable" width="60%" height="10%" border="0" cellpadding="1">
    <c:forEach var="list" items="${list}" varStatus="i">
    	<tr align="left" >
    	<td rowspan="5" width="33%" align="center" style="padding-top:20px;padding-bottom:30px;">
    		<a 
    		href="guestdetail.do?g_no=${list.g_no}&adult=${param.adult}&child=${param.child}&check_in=${check_in}&check_out=${check_out}&nights=${param.nights}"
    		target="_blank"><!-- style="text-decoration: none;" -->
    		<img src = "${list.g_url}" width="90%" height="180px"></a>
    	</td>
    	<td style="font-size:24px;padding-top:24px;">
    		<a 
    		href="guestdetail.do?g_no=${list.g_no}&adult=${param.adult}&child=${param.child}&check_in=${check_in}&check_out=${check_out}&nights=${param.nights}"
    		target="_blank"><!-- style="text-decoration: none;" -->
    		${list.g_name}</a>
    	<!-- 좋아요 시작 -->
    	<span id="like_${i.index}">
	    	<c:choose>
				<c:when test="${list.check_like != 0}">
					<button type="button" class="btn btn-primary" onclick="like_btn(1,${list.g_no}, 'like_${i.index }');">
						<span class="glyphicon glyphicon-thumbs-up"></span> Like 좋아요 ${list.islike}
					</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-default btn-sm" onclick = "like_btn(2,${list.g_no}, 'like_${i.index }');">
						<span class="glyphicon glyphicon-thumbs-up"></span> Like 좋아요 ${list.islike}
					</button>
				</c:otherwise> 
			</c:choose>
		</span>
		<!-- 좋아요 끝 -->
      	</td>
      	</tr>
      	<tr><td>평점<c:choose>
							<c:when test="${list.avgs == 5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i></span>
							</c:when>
							<c:when test="${5 > list.avgs && list.avgs >= 4.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i></span>
							</c:when>
							<c:when test="${4.5 > list.avgs && list.avgs >= 4}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${4 > list.avgs && list.avgs >= 3.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${3.5 > list.avgs && list.avgs >= 3}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${3 > list.avgs && list.avgs >= 2.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${2.5 > list.avgs && list.avgs >= 2}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${2 > list.avgs && list.avgs >= 1.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${1.5 > list.avgs && list.avgs >= 1}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:otherwise>
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:otherwise>
						</c:choose>
						댓글 ${list.reviewcnt} 좋아요 ${list.islike}</td></tr>
      	<tr>
      		<td>
      			<i style="font-size:18px;font-weight:bold;color:black;">숙박&nbsp;</i>
      			<i>14:00~&nbsp;</i>
      			<i style="width:15px; height: 15px; background-color:#ff2d60; color:white;">기본</i> 
      			<i style="font-size:18px;font-weight:bold;color:black;">&nbsp;&nbsp;${list.low_price} 원</i>
      		</td>
      	</tr>
      	<tr><td><!-- 쿠폰 및 테마 공백  --></td></tr>
      	<tr><td style="padding-bottom:30px;">&nbsp;</td></tr>
      	<tr><td colspan="2"><hr color="#D5D5D5" align="center" width=97%></hr></td></tr>
      	<script>
      		x[${i.index}] = ${list.g_position_n};
  			y[${i.index}] = ${list.g_position_e}; 
  			name[${i.index}] = '${list.g_name}';
  			url[${i.index}] = '${list.g_url}';
			g_no[${i.index}] = ${list.g_no};
			check_in = '${check_in}'; 
			check_out = '${check_out}';
			adult= '${param.adult}';
			child= '${param.child}'; 
  			area = '${param.area}';
  			nights= '${param.nights}';
  		</script>
	</c:forEach>
    </table>
   	</div>
 <script>
 	var map;
 	if(area=='my'){
 		map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(37.4945220,127.0280080),
       	zoom: 9
    	});
 	}else{
 		map = new naver.maps.Map('map', {
 	        center: new naver.maps.LatLng(x[0],y[0]),
 	       	zoom: 9
 	    });
 	}

    var markers = [];
    var infoWindows = [];
    
    for(var i=0;i<x.length;i++){
	    var marker = new naver.maps.Marker({
	    	map: map,
	    	position: new naver.maps.LatLng(x[i],y[i]),
	    });
	   
	   // 마크 클릭시 인포윈도우 오픈
	    var infowindow = new naver.maps.InfoWindow({
	    	content: '<h6>'+name[i]+'</h6><div align="center"><a href="guestdetail.do?g_no='
	    	+g_no[i]+'&adult='+adult+'&child='+child+'&check_in='+check_in+'&check_out='
	    	+check_out+'&nights='+nights+'" target="_blank"><img src="'+url[i]+'"width="120px" height="120px"></a></div>',
	    	 maxWidth: 140,
	    	    backgroundColor: "#eee",
	    	    borderColor: "#2db400",
	    	    borderWidth: 5,
	    	    anchorSize: new naver.maps.Size(30, 30),
	    	    anchorSkew: true,
	    	    anchorColor: "#eee",
	    	    pixelOffset: new naver.maps.Point(20, -20)
	    });

	    markers.push(marker);
	    infoWindows.push(infowindow);	    
}


    naver.maps.Event.addListener(map, 'idle', function() {
        updateMarkers(map, markers);
    });

    function updateMarkers(map, markers) {

        var mapBounds = map.getBounds();
        var marker, position;

        for (var i = 0; i < markers.length; i++) {

            marker = markers[i]
            position = marker.getPosition();

            if (mapBounds.hasLatLng(position)) {
                showMarker(map, marker);
            } else {
                hideMarker(map, marker);
            }
        }
    }

    function showMarker(map, marker) {

        if (marker.setMap()) return;
        marker.setMap(map);
    }

    function hideMarker(map, marker) {

        if (!marker.setMap()) return;
        marker.setMap(null);
    }

    // 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
    function getClickHandler(seq) {
        return function(e) {
            var marker = markers[seq],
                infoWindow = infoWindows[seq];

            if (infoWindow.getMap()) {
                infoWindow.close();
            } else {
                infoWindow.open(map, marker);
            }
        }
    }

    for (var i=0, ii=markers.length; i<ii; i++) {
        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
    };
   </script>
</body>
</html>