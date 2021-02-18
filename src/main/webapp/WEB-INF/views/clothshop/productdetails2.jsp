<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<%@ include file="../include/header.jsp"%>

<title>dogcutieshop - Product Details</title>
<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
<style>
.icon_heart_empty {
	margin: 0;
	width: 50px;
	height: 50px;
	background-size: cover;
	background-position: center;
	background-image: url(/resources/img/heart/heart_empty.png);
}

.icon_heart_red {
	margin: 0;
	width: 50px;
	height: 50px;
	background-position: center;
	background-size: cover;
	background-image: url(/resources/img/heart/heart_red.png);
}
</style>
<!-- ================ start banner area ================= -->
<section class="blog-banner-area" id="blog">
	<div class="container h-100">
		<div class="blog-banner">
			<div class="text-center">
				<h1>Shop Single</h1>
				<nav aria-label="breadcrumb" class="banner-breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page">Shop
							Single</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</section>
<!-- ================ end banner area ================= -->


<!--================Single Product Area =================-->
<div class="product_image_area">
	<div class="container">
		<div class="row s_product_inner">
			<div class="col-lg-6">
				<div class="owl-carousel owl-theme s_Product_carousel">
					<div class="single-prd-item">
						<img class="img-fluid" src="/resources/img/upload/${product.img1}"
							onerror="this.src='/resources/img/noimage.gif'">
					</div>

				</div>
			</div>
			<div class="col-lg-5 offset-lg-1">

				<div class="s_product_text">
					<h3>
						<c:out value="${product.p_name}" />
					</h3>
					<h2>
						<fmt:formatNumber type="number" value="${product.amount}" />
						원
					</h2>
					<ul class="list">
						<li><span>카테고리 </span> : ${product.c_name }</li>
						<%-- <li><span>재고 상태 </span> : 재고 있음(<strong>${product.quantity}개</strong>)</li> --%>
					</ul>
					<p><c:out value="${product.discribe}" /></p>
					<div class="card_area d-flex align-items-center">
					
						<div class="product_count"
							style="margin-top: 20px; float: left; vertical-align: middle;">
							
							<label for="qty" style="margin-top:10px;float: left">수량 : </label> 
							<input
								type="number" min="1" name="qty" id="sst" size="2" maxlength="12"
								value="1" title="Quantity" class="input-text qty"
								style="margin-top:8px;float: left"> 
							
							
							<label for=""
								style="margin-top:10px;margin-left: 15px; float: left">찜 : </label>
							<div class="icon_heart_empty" style="float: left"></div>
							
						</div>
					</div>
				</div><div>
						<div>
							<button class="button primary-btn btn-shopping-cart"
								style="float: left; margin-left: 30px; background-color: blue;">장바구니</button>
						</div>
						<div>
							<form action="/carshop/report" method='get' id = "formReport">
								<input type="hidden" value="${product.p_no }" name="p_no">
							
								<button class="button danger-btn" id="btn-report"
										style="float: left; margin-left: 30px; background-color: red;">신고</button>
							</form>

						</div></div>
						
			</div>
		</div>
	</div>
</div>
<!--================End Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link" id="home-tab"
				data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">상세설명</a></li>
			
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade" id="home" role="tabpanel"
				aria-labelledby="home-tab">
				<p><c:out value="${product.discribe}" /></p>
			</div>
		</div>
	</div>
</section>
<!-- Modal -->
<div class="modal fade" id="notice" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">알림</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				<div id = "cart-btn-area"></div>
			</div>
		</div>
	</div>
</div>
<!-- Modal end -->

<!--================End Product Description Area =================-->

<%@ include file="../include/footer.jsp"%>
<script>
function clickEvent(){
	//하트 토글 이벤
		
	let p_no = getP_no();
	let heart_empty = $(".icon_heart_empty");
	heart_empty.off("click");
	heart_empty.click(function(){ //찜목록 추가 삭제
		let obj = $(this);
		//하트클래스 포함여부
		if(obj.hasClass("icon_heart_red")){
			removeLikeEvent(p_no,obj);
		}
		else{
			addLikeEvent(p_no,obj);
		}
	});
		/* $heart_empty.toggleClass("icon_heart_red"); */
	//장바구니 추가 이벤트
	let btnShoppingCart = $(".btn-shopping-cart");
	btnShoppingCart.click(function(){
		
		let quantity = $(".product_count").children("input").val();
		addCartEvent(p_no,quantity);
	})
	
	let btnReport = $("#btn-report");
	btnReport.click(function(){
		if(loginTypeCheck()){
			return false;
		}
		btnReport.preventDefault();
		console.log("report click!");
		addReportEvent();
	})
	
}
function getUserId(){
	let u_id = "${user.id}";
	return u_id;
}
function getP_no(){
	let p_no = "${product.p_no}";
	return p_no;
}
function getS_id(){
	let s_id = "${product.s_id}";
	return s_id;
}
function getSellerCheck(){
	let sellerCheck = "${user.seller}"
	//console.log("sellerCheck : " +  sellerCheck);
	if(sellerCheck === 'N'){
		return false;
	}else if(sellerCheck === 'Y') {
		return true;
	}
}

$(document).ready(function() {
					clickEvent();
					checkLiked();
					//getSellerCheck();
					if(getSellerCheck() || sessoinExistenceChecked()){
						$(".review_box").hide();
					}
					let u_id = "${user.id}";
					let seller ="${user.seller}";
					let seller_id = "${product.s_id}";
					let p_no = "${product.p_no}";
					let s_id = "${product.s_id}";
					let list = $("#ask");
					let text = '';
				

		
			
})
	// 이미지 미리보기
	function setThumbnail(event) {

		$("#image_container").empty();
		let size = event.target.files.length;
		if(size>=4){
			alert("최대 3개까지 가능합니다");
			$("#image").val("");
			return false;
		}
		for (var image of event.target.files) { 
			var reader = new FileReader();
			reader.onload = function(event) { 
				var img = document.createElement("img");				
				img.setAttribute("src", event.target.result); 
				img.setAttribute("width", "150px;"); 
				img.setAttribute("height", "200px;"); 
				document.querySelector("div#image_container").appendChild(img)
				}; 
				console.log(image); reader.readAsDataURL(image); } 

				
			}
	//이미지 클릭시 팝업에서 이미지 보기
	 function fnImgPop(url){
			  var img=new Image();
			  img.src=url;
			  var img_width=img.width;
			  var win_width=img.width+25;
			  var img_height=img.height;
			  var win=img.height+30;
			  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
			  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
			 }	
	
	
	
	 function addCartEvent(p_no,quantity) { //장바구니
			let userId = getUserId();
			
			if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
				return false;
			}
	
			$.ajax({
				url : '/carshop/product/addcart',
				type : 'POST',
				data : {
					"u_id" : userId,
					"p_no" : p_no,
					"quantity":quantity
				},
				dataType : 'JSON',
				success : function(stats) {
					$("#notice .modal-body").html("\""+ userId + "\"님 장바구니에 넣었습니다.");
					$("#cart-btn-area").empty().append(`<button type="button" onClick="location.href='/carshop/cart'"
						class="btn btn-primary" data-dismiss="modal">장바구니로 이동</button>`);
					$('#notice').modal('show');
	
				},
				error : function() {
					console.log("장바구니 통신실패");
				}
			})
		}
	function addLikeEvent(p_no,$obj) { //찜목록추가
		let userId = getUserId();
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}

		$.ajax({
			url : '/carshop/product/addlike',
			type : 'POST',
			data : {
				"u_id" : userId,
				"p_no" : p_no
			},
			dataType : 'JSON',
			success : function(stats) {
				$(".icon_heart_empty").addClass("icon_heart_red");								
				$("#notice .modal-body").html("\""+ userId + "\"님 찜 목록에 넣었습니다.");
				$("#cart-btn-area").empty();
				$('#notice').modal('show');
			},
			error : function() {
				console.log("통신실패");
			}
		})
	}
	function addReportEvent() { //신고
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}else{
			$("#formReport").submit();
		}

	}
	function removeLikeEvent(p_no,$obj) { //찜목록삭제
		//console.log("상품번호 : " + p_no);
		let userId = getUserId();
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}
		$.ajax({
			url : '/carshop/product/removeLiked',
			type : 'POST',
			data : {
				"u_id" : userId,
				"p_no" : p_no
			},
			dataType : 'JSON',
			success : function(stats) {
				$(".icon_heart_empty").removeClass("icon_heart_red");
				$("#notice .modal-body").html("\""+ userId + "\"님 찜 목록에서 삭제되었습니다.");
				$("#cart-btn-area").empty();
				$('#notice').modal('show');
			},
			error : function() {
				console.log("통신실패");
			}
		})
	}
	function checkLiked(){
		let userId = getUserId();
		let p_no = getP_no();
		if(sessoinExistenceChecked()){
			return false;
		}

			$.ajax({
				url : '/carshop/product/checkLiked',
				type : 'POST',
				data : {
					"u_id" : userId, //나중에 로그인완성되면 넣을것!
					"p_no" : p_no
				},
				dataType : 'JSON',
				success : function(data) {
					if(data){
						$(".icon_heart_empty").addClass("icon_heart_red");					
					}
				},
				error : function() {
					console.log("통신실패");
				}
			})
		
	} 
	function sessoinExistenceChecked(){
		let userId = getUserId();
		if(userId === "" || typeof userId === "undefined" || userId === null){
			
			return true;
		}
		return false;
	}
	function loginTypeCheck(){
		
		let result = false;
		if(sessoinExistenceChecked()){
			$("#notice .modal-body").html("로그인 후 이용해주세요.");
			$("#cart-btn-area").empty();
			$('#notice').modal('show');
			result = true;
		}else if(getSellerCheck()){
			$("#notice .modal-body").html("판매자는 이용할수 없습니다. 일반유저 로그인 후 이용해주세요.");
			$("#cart-btn-area").empty();
			$('#notice').modal('show');
			result = true;
		}
		return result;
	}
</script>
