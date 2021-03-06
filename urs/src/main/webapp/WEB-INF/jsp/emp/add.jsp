<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/jsp/layout/top.jsp" %>

<div class="row justify-content-center">
	<div class="card border-width-3 border-radius-0 border-color-hover-dark mb-4 col-lg-6">
		<div class="card-body">
		<h4 class="font-weight-bold text-uppercase text-4 mb-3">직원 정보 등록</h4>
			<form action="${request.getContextPath()}/emp" method="post" class="needs-validation" onsubmit="return check(this);">
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">사번</label>
					<div class="col-lg-9">
						<input class="form-control" id="memberNo" type="text" name="memberNo" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required>
					</div>
					<div class="col-lg-9" id="errorMemberNo"></div>
				</div>
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">학과명</label>
					<div class="col-lg-9">
						<select name="deptNo" class="form-control" id="deptNo">
							<c:forEach items="${rows}" var="row">
								<option value="${row.no}">${row.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-lg-9" id="errorDeptNo"></div>
				</div>
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">이름</label>
					<div class="col-lg-9">
						<input class="form-control" type="text" name="name" maxlength="33" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">연락처</label>
					<div class="col-lg-9">
						<input class="form-control" type="text" name="phone" maxlength="13" onkeyup="inputPhoneNumber(this)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-3 font-weight-bold text-dark col-form-label form-control-label text-2 required">카드번호</label>
					<div class="col-lg-9">
						<input class="form-control" id="cardNo" type="text" name="cardNo" maxlength="8" required>
					</div>
					<div class="col-lg-9" id="errorCardNo"></div>
				</div>
				<input type="submit" value="등록" class="btn btn-primary btn-modern float-right" />
				<div class="col-lg-10">
					<a href="/emp"><input type="button" value="취소" class="btn btn-primary btn-modern float-right" /></a>	
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	function inputPhoneNumber(obj) {
	    var number = obj.value.replace(/[^0-9]/g, "");
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
					if (row === null) {
						form.submit();
					} else {
						if (row.memberNo != 0) {
							document.getElementById("errorMemberNo").innerHTML = "<font size=\"2em\" color=\"red\">이미 존재하는 사번입니다.</font>";
						} 
						if (row.cardNo != null) {
							document.getElementById("errorCardNo").innerHTML = "<font size=\"2em\" color=\"red\">이미 존재하는 카드번호입니다.</font>";
						}
						if (row.deptNo != 0) {
							document.getElementById("errorDeptNo").innerHTML = "<font size=\"2em\" color=\"red\">해당 학과에 이미 직원이 존재합니다.</font>";
						}
					}
				} else {
					console.error(xhr.responseText);
				}
			}
		};
		
		var memberNo = document.getElementById("memberNo").value;
		var cardNo = document.getElementById("cardNo").value;
		var deptNo = document.getElementById("deptNo").value;
		if (!memberNo) {
			memberNo = "0";
		}
		if (!cardNo) {
			cardNo = "!";
		}
		if (!deptNo) {
			deptNo = "0";
		}

		xhr.open("GET", "http://localhost/emp/check/" + memberNo + "/" + cardNo + "/" + deptNo, true);
		xhr.send();
		
		return false;
	};
</script>

<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>