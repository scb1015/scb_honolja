<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	*{
		font-size: 10pt;
		font-weight: bold;
	}
	.joinform {
		width: 500px;
		margin: 0 auto;
	}
	.logo {
		display: block;
	    overflow: hidden;
	    width: 240px;
	    height: 100px;
	    margin: 0 auto;
	    color: blue;
		}
	.loghoh1 {
		font-size: 44px;
		font-weight: bold;
	}
	.logo .loghoh1 a{
		text-decoration: none;
	}
	.honolja{
		font-size: 44px;
		font-weight: bold;
	    overflow: hidden;
	    clip: rect(0 0 0 0);
	    margin: -1px;
	    width: 1px;
	    height: 1px;
	}
	.option-input {
		-webkit-appearance: none;
		-moz-appearance: none;
		-ms-appearance: none;
		-o-appearance: none;
		appearance: none;
		position: static;
		top: 13.33333px;
		right: 0;
		bottom: 0;
		left: 0;
		height: 20px;
		width: 20px;
		transition: all 0.15s ease-out 0s;
		background: #cbd1d8;
		border: none;
		color: #fff;
		cursor: pointer;
		margin-right: 0.5rem;
		outline: none;
		position: relative;
		z-index: 1000;
	}
	.option-input:hover {
		background: #9faab7;
	}
	.option-input:checked {
		background: blue;
	}
	.option-input:checked::before {
		height: 20px;
		width: 20px;
		position: absolute;
		content: '✔';
		font-size: 15px;
		text-align: center;
		line-height: 20px;
	}
	.option-input:checked::after {
		-webkit-animation: click-wave 0.65s;
		-moz-animation: click-wave 0.65s;
		animation: click-wave 0.65s;
		background: #40e0d0;
		content: '';
		position: relative;
		z-index: 100;
	}
	.option-input.radio {
		border-radius: 50%;
	}
	.option-input.radio::after {
		border-radius: 50%;
	}
	.txtlayout {
		width: 100%;
		height: 51px;
		border: solid 1px;
		display: block;
		border-color: #dadada;
		padding: 7px 13px 10px;
	}
	@keyframes hover-color {
  from {
    border-color: #c0c0c0; }
  to {
    border-color: #3e97eb; } }

	.magic-checkbox {
	  position: absolute;
	  display: none; }
	
	.magic-checkbox[disabled] {
	  cursor: not-allowed; }
	
	.magic-checkbox + label {
	  position: relative;
	  display: block;
	  padding-left: 30px;
	  cursor: pointer;
	  vertical-align: middle; }
	.magic-checkbox + label:hover:before {
	  animation-duration: 0.4s;
	  animation-fill-mode: both;
	  animation-name: hover-color; }
	.magic-checkbox + label:before {
	  position: absolute;
	  top: 0;
	  left: 0;
	  display: inline-block;
	  width: 20px;
	  height: 20px;
	  content: '';
	  border: 1px solid #c0c0c0;
	  }
	.magic-checkbox + label:after {
	  position: absolute;
	  display: none;
	  content: ''; }
	
	.magic-checkbox[disabled] + label {
	  cursor: not-allowed;
	  color: #e4e4e4; }
  
	.magic-checkbox[disabled] + label:hover,
	.magic-checkbox[disabled] + label:before,
	.magic-checkbox[disabled] + label:after {
	  cursor: not-allowed; }
	.magic-checkbox[disabled] + label:hover:before {
	  border: 1px solid #e4e4e4;
	  animation-name: none; }
	.magic-checkbox[disabled] + label:before {
	  border-color: #e4e4e4; }

	.magic-checkbox:checked + label:before {
	  animation-name: none; }
	
	.magic-checkbox:checked + label:after {
	  display: block; }
	
	.magic-checkbox + label:before {
	  border-radius: 3px; }
	
	.magic-checkbox + label:after {
	  top: 2px;
	  left: 7px;
	  box-sizing: border-box;
	  width: 6px;
	  height: 12px;
	  transform: rotate(45deg);
	  border-width: 2px;
	  border-style: solid;
	  border-color: #fff;
	  border-top: 0;
	  border-left: 0; }
	
	.magic-checkbox:checked + label:before {
	  border: #3e97eb;
	  background: #3e97eb; }
	
	.magic-checkbox:checked[disabled] + label:before {
	  border: #c9e2f9;
	  background: #c9e2f9; }
	  
	.text {
		margin-left: 7%;
	}
	
</style>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>

<script type="text/javascript">
	
	function agreeCheck(){
		var check = document.getElementById("check");
		var cb1 = document.getElementById("cb1");
		var cb2 = document.getElementById("cb2");
		var cb3 = document.getElementById("cb3");
		
		if(cb2.checked == false || cb3.checked == false){
			check.innerHTML = "<font color='red'>혼놀자 이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.</font>";
			return;
		}else{
			location.href="m_join.do";
		}
	}//agreeCheck end
	
	function cbCheck(){
		var cb1 = document.getElementById("cb1");
		var cb2 = document.getElementById("cb2");
		var cb3 = document.getElementById("cb3");
		
		if(cb1.checked == true){
			cb2.checked = true;
			cb3.checked = true;
		}else if(cb1.checked == false){
			cb2.checked = false;
			cb3.checked = false;
		}else{}
		
	}//cbCheck end
	
	function cb23Check(){
		var cb1 = document.getElementById("cb1");
		var cb2 = document.getElementById("cb2");
		var cb3 = document.getElementById("cb3");
		
		if(cb2.checked == true){
			if(cb3.checked == true){
				cb1.checked = true;
			}else{
				cb1.checked = false;
			}
		}else if(cb3.checked == true){
			if(cb2.checked == true){
				cb1.checked = true;
			}else{
				cb1.checked = false;
			}
		}else{}
	}//cb23Check end
</script>


</head>
<body id="page-top" style="margin-top:51px;">
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<div class="logo" role="banner">
		<h1 class="loghoh1">
			<a href="main.do">
				<span class="honolja">HONOlJA</span>
			</a>
		</h1>
	</div>
	<div class="joinform">
		<input class="magic-checkbox" type="checkbox" name="layout" id="cb1" value="option" onclick="cbCheck();">
			<label for="cb1"></label>
			<label class="text" for="cb1" style="margin-bottom: 7%;">이용약관, 개인정보 수집 및 이용에 모두 동의합니다.</label>
			
		<input class="magic-checkbox" type="checkbox" name="layout" id="cb2" value="option" onclick="cb23Check();">
			<label for="cb2"></label>
			<label class="text" for="cb2" style="margin-bottom: 3%;">혼놀자 이용약관 동의<span style="color: red; font-size: 8pt;">&nbsp;(필수)</span></label>
		
		<div class="form-group">
			<textarea class="form-control" rows="5" id="comment" style="margin-bottom: 7%;">
여러분을 환영합니다.

혼놀자 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 혼놀자 서비스의 이용과 관련하여 혼놀자 서비스를 제공하는 혼놀자 주식회사(이하 ‘혼놀자’)와 이를 이용하는 혼놀자 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 혼놀자 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.

혼놀자 서비스를 이용하시거나 혼놀자 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.

다양한 혼놀자 서비스를 즐겨보세요.
혼놀자는 www.naver.com을 비롯한 혼놀자 도메인의 웹사이트 및 응용프로그램(어플리케이션, 앱)을 통해 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 제공, 상품 쇼핑 등 여러분의 생활에 편리함을 더할 수 있는 다양한 서비스를 제공하고 있습니다.
여러분은 PC, 휴대폰 등 인터넷 이용이 가능한 각종 단말기를 통해 각양각색의 혼놀자 서비스를 자유롭게 이용하실 수 있으며, 개별 서비스들의 구체적인 내용은 각 서비스 상의 안내, 공지사항, 혼놀자 웹고객센터(이하 ‘고객센터’) 도움말 등에서 쉽게 확인하실 수 있습니다.

본 약관은 한국어를 정본으로 합니다. 본 약관 또는 혼놀자 서비스와 관련된 여러분과 혼놀자와의 관계에는 대한민국의 법령이 적용됩니다. 그리고 본 약관 또는 혼놀자 서비스와 관련하여 여러분과 혼놀자 사이에 분쟁이 발생할 경우, 그 분쟁의 처리는 대한민국 '민사소송법'에서 정한 절차를 따릅니다.

공지 일자: 2018년 3월 30일
적용 일자: 2018년 5월 1일
혼놀자 서비스와 관련하여 궁금하신 사항이 있으시면 고객센터(대표번호: 1588 – 3820/ 평일 09:00~18:00)로 문의 주시기 바랍니다.
정보통신망법 규정에 따라 혼놀자에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
			</textarea>
		</div>
			
		<input class="magic-checkbox" type="checkbox" name="layout" id="cb3" value="option" onclick="cb23Check();">
			<label for="cb3"></label>
			<label class="text" for="cb3" style="margin-bottom: 3%;">개인정보 수집 및 이용에 대한 안내<span style="color: red; font-size: 8pt;">&nbsp;(필수)</span></label>
		
		<div class="form-group">
			<textarea class="form-control" rows="5" id="comment" style="margin-bottom: 7%;">
1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 혼놀자 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 혼놀자는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 혼놀자가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 가입인증 휴대폰번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대폰번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.
- 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 가입인증 휴대폰번호를 필수항목으로 수집합니다. 그리고 단체 대표자명, 비밀번호 발급용 멤버 이름 및 이메일주소를 선택항목으로 수집합니다.
서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
NAVER 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.

서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다.
구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 정보통신서비스 제공자가 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 
2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환한 후에 수집하는 경우를 의미합니다.
혼놀자 위치기반서비스 이용 시 수집·저장되는 위치정보의 이용 등에 대한 자세한 사항은 ‘혼놀자 위치정보 이용약관’에서 규정하고 있습니다.

2. 수집한 개인정보의 이용
혼놀자 및 혼놀자 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발・제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.

- 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
- 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.
- 법령 및 혼놀자 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
- 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.
- 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
3. 개인정보의 파기
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.

이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우는 아래와 같습니다.
			</textarea>
		</div>
		
		<label id="check"></label>
			
			<div style="display: flex;">
				<input type="button" class="btn btn-primary btn-md" onclick="location.href='main.do'" style="height: 50px; width: 100%; margin-top: 20px; margin-right: 3%; background-color: gray; border-color: gray;" value="비동의">
				<input type="button" class="btn btn-primary btn-md" onclick="agreeCheck(); return false;" style="height: 50px; width: 100%; margin-top: 20px;" value="동의">
			</div>
	</div>
	

</body>
</html>