/**
 * 
 */

function review(g_no) {
	$.ajax({
		url : 'review.do',
		type : 'GET',
		data : {
			g_no : g_no
		},
		success : function(data) { // 서버에 대한 정상응답이 오면 실행, callback
			$("#reviews").html(data);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function reviewBtn(g_no) {

	if ($.trim($("#re_content").val()) == ""
			|| $.trim($("#re_content").val()) == null) {
		$(".modal-title1").html("확인");
		$(".modal-body1").html("댓글 내용을 입력해 주세요.");
		$("#myModal").modal('show');
		return false;
	}

	if ($("re_score").val() == null && $("re_score").val() == "") {
		$(".modal-title1").html("확인");
		$(".modal-body1").html("별점을 선택해 주세요.");
		$("#myModal").modal('show');
		return false;
	}

	var dataForm = $('#reviewForm').serialize();

	$.ajax({
		url : 'reviewAdd.do',
		type : 'post',
		data : dataForm,
		success : function(data) { // 서버에 대한 정상응답이 오면 실행, callback
			$("#reviews").html(data);
			$("#modal_title").html("확인");
			$("#modal_body").html("저장 되었습니다.");
			$('#ignismyModal').modal('show');
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function remove(re_no, g_no) {

	$.ajax({
		url : 'reviewDel.do',
		type : 'post',
		data : {
			re_no : re_no,
			g_no : g_no
		},
		success : function(data) {
			$("#reviews").html(data);
			$("#modal_title").html("확인");
			$("#modal_body").html("삭제 되었습니다.");
			$('#ignismyModal').modal('show');
		}
	})
}

function premodify(re_no, g_no) {

	if (confirm("수정 하시겠습니까??")) {

		$.ajax({
			url : 'reviewPremod.do',
			type : 'post',
			data : {
				re_no : re_no,
				g_no : g_no
			},
			success : function(data) {
				$("#reviewModify_" + re_no).html(data);
				$("#reviewModify_" + re_no).focus();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
}

function modify(re_no) {

	var dataForm = $('#modifyForm').serialize();

	$.ajax({
		url : 'reviewModify.do',
		type : 'post',
		data : dataForm,
		success : function(data) {
			$("#modal_title").html("확인");
			$("#modal_body").html("저장 되었습니다.");
			$('#ignismyModal').modal('show');
			$("#reviews").html(data);
			$("#reviewModify_"+ re_no).focus();
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function answer(re_no) {

	var dis = $("#view_" + re_no).css("display");

	if (dis == 'none') {
		$.ajax({
			url : 'answerPreAdd.do',
			type : 'post',
			data : {
				re_no : re_no,
			},
			success : function(data) {
				$("#view_" + re_no).show();
				$("#view_" + re_no).focus();
				$("#view_" + re_no).html(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	} else {
		$("#view_" + re_no).hide();
	}
}

function answerAdd(re_no) {

	var dataForm = $("#answerForm").serialize();
	
	$.ajax({
		url : 'answerAdd.do',
		type : 'post',
		data : dataForm,
		success : function(data) {
			$("#view_" + re_no).html(data);
			$("#view_" + re_no).show();
			$("#view_" + re_no).focus();
			$("#modal_title").html("확인");
			$("#modal_body").html("저장 되었습니다.");
			$('#ignismyModal').modal('show');
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function answerView(re_no) {
	var dis = $("#view_" + re_no).css("display");

	if (dis == 'none') {
		$.ajax({
			url : 'answer.do',
			type : 'post',
			data : {
				re_no : re_no
			},
			success : function(data) {
				$("#view_" + re_no).html(data);
				$("#view_" + re_no).show();
				$("#view_" + re_no).focus();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	} else {
		$("#view_" + re_no).hide();
	}
}

function modifyClose(re_no) {
	$('#reviewModify_' + re_no).remove();
	$('#reviewModify_' + re_no).focus();
}

function answerDel(a_no, re_no, g_no) {

	$.ajax({
		url : 'answerDel.do',
		type : 'post',
		data : {
			a_no : a_no,
			re_no : re_no,
			g_no : g_no
		},
		success : function(data) {
				
				$("#view_" + re_no).hide();
				$("#reviews").html(data);
				$('#reviewModify_' + re_no).focus();
				$("#modal_title").html("확인");
				$("#modal_body").html("삭제 되었습니다.");
				$('#ignismyModal').modal('show');

		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function popupWindow(url, title, w, h) {
	
	var left = (screen.width/2) - (w/2);
	var top = (screen.height/2) - (h/2) - 50;
	
	return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

function reservation(r_no, nights, g_no) {

	var check_in = document.getElementById("check_in").value;
	var check_out = document.getElementById("check_out").value;
	var adult = document.getElementById("adult").value;
	var child = document.getElementById("child").value;
	
	$.ajax({
		url : 'reservationCheck.do',
		type : 'post',
		data : {
			r_no : r_no,
			adult : adult,
			child : child,
			check_in : check_in,
			check_out : check_out,
			nights : nights,
			g_no : g_no
		},
		success : function(data) {
			if(data == 'true') {
				location.href = 'reservationPre.do?r_no=' + r_no +'&adult=' + adult + '&child=' + child + '&check_in=' + check_in + '&check_out=' + check_out + '&nights=' + nights;
			} else {
				$("#modal_title").html("확인");
				$("#modal_body").html("인원초과 되었습니다.");
				$('#ignismyModal').modal('show');
			}
		},
		error : function(request, status, error) {
		alert("code:" + request.status + "\n" + "message:"
				+ request.responseText + "\n" + "error:" + error);
		}
	})
	
	// window.open(url, '예약 확인', 'toolbar=no, location=no, directories=no,
	// status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no,
	// width=600, height=600, top='+top+', left='+left);
	
}

function detaillike_btn(btn_flag, g_no, u_id){		
	
	$.ajax({
			url : "detaillike.do",
			type : "post",
			data : {
						g_no : g_no,
						u_id : u_id, 
						btn_flag : btn_flag,
					},
			success : function(data){			
				$("#detaillike").html(data);	
			}
		});
	}