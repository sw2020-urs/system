<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/jsp/layout/top.jsp" %>

<div class="row justify-content-center">
	<div class="card border-width-3 border-radius-0 border-color-hover-dark mb-4 col-lg-6">
		<div class="card-body">
		<h4 class="font-weight-bold text-uppercase text-4 mb-3">학생 정보 수정</h4>
			<form action="${request.getContextPath()}/student" method="post" class="needs-validation" onsubmit="return check(this)" >
				<input type="hidden" name="_method" value="put" />
				<input type="hidden" name="memberNo" value="${row.memberNo}" />
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">이름</label>
					<div class="col-lg-9">
						<input class="form-control" type="text" name="name" value="${row.name}" maxlength="20" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">연락처</label>
					<div class="col-lg-9">
						<input class="form-control" type="text" name="phone" value="${row.phone}" maxlength="13" onkeyup="inputPhoneNumber(this)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required>
					</div>
				</div>
				<div class="form-group row mb-5">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">카드번호</label>
					<div class="col-lg-9">
						<input id="cardNo" class="form-control" type="text" name="cardNo" value="${row.cardNo}" maxlength="8" required>
					</div>
				</div>
				<input type="submit" value="수정" class="btn btn-primary btn-modern float-right" />	
				<div class="col-lg-10">
					<a href="/student/${row.memberNo}"><input type="button" value="취소" class="btn btn-primary btn-modern float-right" /></a>
				</div>
			</form>
			<div class="col-lg-9" id="errorCardNo"></div>
		</div>
	</div>
</div>
<script>
	function inputPhoneNumber(obj) {
	    var number = obj.value.replace(/[^0-9]/g, "");
	    console.log(number);
	    var phone = "";
	
	    if(number.length < 4) {
	        return number;
	    } else if(number.length < 7) {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3);
	    } else if(number.length < 11) {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3, 3);
	        phone += "-";
	        phone += number.substr(6);
	    } else {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3, 4);
	        phone += "-";
	        phone += number.substr(7);
	    }
	    obj.value = phone;
	};
	
	function check(form) {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			console.log(xhr.readyState);

			if (xhr.readyState === xhr.DONE) {
				if (xhr.status === 200 || xhr.status === 201) {
					var row = JSON.parse(xhr.responseText);
					console.log(row);
					if (row === null) {
						form.submit();
					} else {
						if (row.cardNo === "${row.cardNo}") {
							form.submit();
						} else {
							document.getElementById("errorCardNo").innerHTML = "<font size=\"2em\" color=\"red\">이미 존재하는 카드번호입니다.</font>";
						}
					}
				} else {
					console.error(xhr.responseText);
				}
			}
		};
		
		var cardNo = document.getElementById("cardNo").value;
		if (!cardNo) {
			cardNo = "!";
		}
		
		xhr.open("GET", "http://localhost/student/check/" + 1 + "/" + cardNo, true);
		xhr.send();
		
		return false;
	};
</script>
<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>