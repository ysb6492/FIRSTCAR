<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.nbp.product.model.DTO.Product" %>
<%@ include file="/WEB-INF/common/sessionInfo.jsp" %>
<%
	Product p = (Product)request.getAttribute("productInfo");
	String loginId = "";
	try{
		loginId= loginMember.getMemberId();
	}catch(NullPointerException e){
		loginId="";
	}
	
	String productMainImg = (String)request.getAttribute("productMainImg");
	System.out.print(productMainImg);
%>
<%@ include file="/WEB-INF/common/subHeader.jsp" %> 
<%
	int productPrice = 0;
	String delivery="";
	if(p.getProductPrice()<100000){
		
		productPrice=p.getProductPrice()+3500;
		delivery="(배송비 포함 : 3,500원)";
	}else if(p.getProductPrice()>=100000){
		productPrice=p.getProductPrice();
	}else{
		delivery="";
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<style>
 #product-main{
    display: flex;
    position: relative;
    justify-content: center;
    justify-content: space-between;
    overflow:hidden;
    align-items: center;
    background: url("<%=request.getContextPath()%>/upload/product/<%=productMainImg%>") no-repeat center center;
    
	/* background-size:cover; */
	background-size: 100%;
    transition: background-size 1s ease;
   } 
   #product-main:hover{
    background-size:120%;
   }     


   .product-title{
    color: white;
    font-weight: bolder;
    font-size: 30px;
    height: 150px;

   }

   .product-sub-title{
    color: white;
    font-family: GmarketSans;
    font-size: 15px;
    font-weight: lighter;

   }

   .price{
    color: white;
    font-family: GmarketSans;
    font-size: 30px;
    border-width: 0;
    background-color: transparent;
    width: 15 0px;

   }

   .price-menu{
    
    height: 100px;
    width: 500px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
   }
   
   .product-pic:hover{
    opacity: 0.5;
   }
   
   #product-count{
    font-size: 20px;
    color: white;
   }

   .detail{
    display: flex;
    justify-content: center;
    justify-content: space-evenly;
    align-items: center;
    width: 100px;
   }

  .font{
    color: white;
  }

  #parchase{
    display: flex;
    justify-content: center;
    justify-content: space-evenly;
    align-items: center;
  }

  

  #product-sub-main{
    display: flex;
    flex-direction: column;
    align-items: center;

  }

  #parchase{
    height:50px; 
    width: 300px; 
    border: 2px solid white;
    margin-top: 40px;
    border-radius: 5px;
    color: white;
    transition: all 0.25s ease-in;
  }

  #parchase:hover{
    background-color: white;
    color: rgb(3, 1, 57);
    cursor: pointer;
  }

  #cart{
  	padding-top:5px;
    font-size: 30px; 
    font-weight: bolder; 
    color: rgb(3, 1, 57); 
    background-color: white;
    width: 240px;
    height: 50px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.25s ease-in;
  }

  #cart:hover{
    color:white ;
    background-color: rgb(3, 1, 57);
    cursor: pointer;
    
  }

  #cart>p{
    margin-bottom: 7px;
  }

  #wish-img{
    font-size: 30px; 
    font-weight: bolder; 
    width: 50px;
    height: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: inset  0 0 0 2px white;
    border-radius: 10px;
    cursor: pointer;
  }
  

/*   #product-detail-main{
    height: 1000px;
    min-width: 1400px;
  } */


    /*  .border{
        border: 1px solid red;
    }  */

   #product {
      padding: 10px;
      font-size: 16px;
      border-radius: 5px;
      background:lightgray;
      border: 1px solid #ccc;
      box-shadow: 2px 2px 8px rgba(255, 255, 255, 0.5);
      outline: none;
      transition: box-shadow 0.3s ease-in-out;
      margin-left:20px;
      font-weight:bolder;
   }
   
   #product>option {
   	  font-family:GmarketSans;
   }
   
   #product:hover {
        box-shadow: 2px 2px 8px rgba(255, 255, 255, 0.9), 0 0 15px rgba(0, 0, 0, 0.3);
   }
   
   #order-list{
   		color:white;
   		font-size:17px;
   }
   
   .product-container{
   		display: flex;
        flex-direction: column;
        overflow:visible;
   		height:60px;
   		/* outline:1px solid white; */
   		margin : 10px 0;
   		width:100%;
   		display: flex;
    	justify-content: center;
    	justify-content: space-evenly;
    	align-items: center;
   }
   
   .product-container>table{
   		text-align:center;
   		width:100%;
   		padding-right:25px;
   		border-top: 2px solid rgb(255, 255, 255);
   		border-bottom: 2px solid rgb(255, 255, 255);
   }
   
   
   .total-price{
   		color:white;
   		font-size:30px;
   		/* float:right; */
   }
   
   .delivery-memo{
	   display:none;
	   text-align:center;
       position: absolute;
       background-color: lightgray;
       font-weight:bolder;
       width:170px;
       height:40px;
       color: rgb(3, 1, 57);
       padding: 5px;
       border-radius: 3px;
       z-index: 1000;
       outline:2px solid rgb(3, 1, 57);
   }
   
   .list-delete-btn{
   	cursor:pointer;
   }
   

    </style>

</head>
<body>
 <section>
        <div id="product-main" class="border" style=" height: 800px; min-width: 1400px;">
            <div class="border" style="height: 800px; width: 500px; margin-right: 20px;">
    
            </div>
            <!-- 오른쪽 상품 상세 메뉴들 -->
            <div id="product-sub-main" class="border" style="height: 800px; width: 400px; margin-left: 20px; margin-right: 60px;">
            	<div id="review-productNo" style="display:none"><%=p.getProductNo() %></div>
                <p class="product-title"><br><br><%=p.getProductName()%></p>
                <p class="product-sub-title"><%=p.getProductSubname()%></p> <br><br>
                <!-- 가격, 카운트 업,다운 버튼 -->
                <div class="price-menu border">
                  <div>
                    <span id="price" style="color: white; font-size: 40px;"><%=String.format("%,d",p.getProductPrice())%></span><span style="color: white; font-size: 35px;">원</span><br>
                  </div>
                    <div class="border detail" style="display: flex;">
                    <div id="minus"><img src="https://i.imgur.com/RnOgrKc.png" alt="" width="25px" height="15px"></div>
                    <div id="product-count">1</div>
                    <div id="plus"><img src="https://i.imgur.com/tWmQbwu.png" alt="" width="25px" height="15px"></div>
                  </div>
                </div>
                <br>
                <!-- 추가 구매상품 선택 리스트 -->
                <select id="product"> <!-- onchange="updateTotal()" -->
                    <option  value="0">선택하세요 (선택사항)</option>
                    <option id="ice" value="얼음틀:5000">얼음틀 : 5,000원</option>
                    <option id="glass" value="잔:25000">잔 : 25,000원</option>
                    <option id="pack" value="선물포장:1500">선물포장 : 1,500원</option>
                </select>
                <!-- 구매, 장바구니, 위시리스트 버튼 -->
              <div id="parchase">
                <p id="totalPrice" style="font-size: 25px; font-weight: bolder; padding-bottom: 3px;">total : <%=String.format("%,d",productPrice)%>원</p>
              </div>
                <span id="delivery" style="color:white; font-weight:bolder; margin-top:5px;"><%=delivery%></span>
                <div id="delivery-memo" class="delivery-memo">구매금액 50,000원<br> 이상시 무료배송</div>
              <div style="display: flex; flex-direction: row; justify-content: center; justify-content: space-between; align-items: center; width: 300px; margin-top: 10px;">
                <div id="cart"><p>cart</p></div>
                <div id="wish-img"><img id="wish-btn" src="https://i.imgur.com/VqIZAb3.png" width="30px"></div>
              </div>
              <!-- 구매 상품 리스트 -->
              <div id="order-list" style="color: white; min-height:20px; width: 340px; margin-top: 20px;">
              		<div class="product-container">
              			
              			<table>
              				<tr>
              					<th>제품명</th>
              					<th>수량</th>
              					<th>가격</th>
              					<th></th>
              				</tr>
              				<tr>
              					<td class="list-name"><%=p.getProductName()%></td>
              					<td id="list-count" class="list-count">(1)</td>
              					<td id="list-price" class="list-price"><%=String.format("%,d",p.getProductPrice())%></td>
              					<td><img src="https://i.imgur.com/U1LZh3O.png" width=15px style="padding-top:10px; opacity:0;"></td>
              				</tr>
              				
              			</table>
              			
              		</div>
              </div>
            </div>
        </div>
    
    </section>
    <script>
    	/* 위시리스트 기능 구현 */
    	 $(document).ready(function(){
    		 /* 상세 페이지 로딩시 위시리스트 버튼 조건 활성화 */
    		 <%if(loginId!=""){%>
    		$.ajax({
    			type:'post',
    			url:"<%=request.getContextPath()%>/product/wishlistcheck.do",
    			data:{productId:<%=p.getProductNo()%>,memberId:'<%=loginId%>'},
    			success: function (response){
    				if(response>0){
    					$("#wish-btn").attr("src",'https://i.imgur.com/UboRxyi.png');
    				}
    			}
    		});
    		<%}%>
    	
	    	$("#wish-img").click(e=>{
   				/* 로그인 검열 */
   				<%if(loginId==""){%>
	   	    		alert("로그인 이후 이용할 수 있습니다.");
   	    		<%}else{%>
	    		
	     		$.ajax({
	     			type:'post',
	     			url:"<%=request.getContextPath()%>/product/wishlistcheck.do",
	     			data:{productId:<%=p.getProductNo()%>,memberId:'<%=loginId%>'},
	     			success: function (response){
	     				/* 위시리스트 버튼이 활성화 되어있을때 */
	     				if(response>0){
	     					$.ajax({
	     		    			type:'post',
	     		    			url:"<%=request.getContextPath()%>/product/wishlistdelete.do",
	     		    			data:{productId:<%=p.getProductNo()%>,memberId:'<%=loginId%>'},
	     		    			success: function(response){
	     		    				alert("위시리스트에서 삭제되었습니다.");
	     							$("#wish-btn").attr("src",'https://i.imgur.com/VqIZAb3.png');
	     		    			}
	     		    		});
	     					
	     				/* 위시리스트 버튼이 비활성화 되어있을때 */	
	     				}else{
	     					
	     					$.ajax({
	     		    			type:'post',
	     		    			url:"<%=request.getContextPath()%>/product/wishlist.do",
	     		    			data:{productId:<%=p.getProductNo()%>,memberId:'<%=loginId%>'},
	     		    			success: function(response){
	     		    				alert("위시리스트에 등록되었습니다.");
	     		    				$("#wish-btn").attr("src",'https://i.imgur.com/UboRxyi.png');
	     		    			}
	     		    		});
	     				}
	     			}
	     		});
	    				<%}%>
	    	});
    	
    	 });
    
    
    
    
    
    	/* 장바구니 버튼 구현 */
    		$(document).on('click', '#cart', function(e) {
    			<%if(!loginId.equals("")){%>
    			/* 옵션 이름 배열로 받기 */
    		let option = $(".list-name");
    		let optionName = option.map(function(){
    			let optionNameResult = $(this).text().trim();
    			if(optionNameResult!==""){
    				return optionNameResult;
    			}
    		}).get();
    		
    		/* 옵션 가격 배열로 받기 */
    		let option1 = $(".list-price");
    		let optionPrice = option1.map(function(){
    			let optionPriceResult = $(this).text().trim();
    			if(optionPriceResult!==""){
    				return optionPriceResult;
    			}
    		}).get();
    		/* ajax로 보내 값 저장 */
    		let cartData = {
    				'memberId':'<%=loginId%>',
    				'productId':<%=p.getProductNo()%>,
    				'productPrice':<%=p.getProductPrice()%>,
    				'cartVolume':$("#product-count").text(),
    				'optionName':optionName,
    				'optionPrice':optionPrice
    		};
    		
    		/* ajax처리  > post 형식으로 */
    		$.ajax({
    			type:'post',
    			url:"<%=request.getContextPath()%>/product/productcart.do",
    			data:JSON.stringify(cartData),
    			contentType:'application/json;charset=utf-8;',
    			success: function(response){
    				let cartPageMove = confirm("장바구니에 담겼습니다. 장바구니로 이동 하시겠습니까?");
    				if(cartPageMove){
    					location.assign("<%=request.getContextPath()%>/common/movetocart.do");
    				}
    			}
    		});
    		<%}else{%>
    			alert("로그인 후 이용해주세요.");
    		<%}%>
    		
    		
    	});
    
    
    
    
    
    
    	/* 배송비 포함 호버시 배송 안내문 표시 */
    	$('#delivery').hover(
                function(e) {

                	$("#delivery-memo").css({
                        display: 'block',
                        top: e.pageY + 10 + 'px',
                        left: e.pageX + 10 + 'px' 
                    });
                },
                function() {
                	$("#delivery-memo").css('display', 'none');
                }
            );
    	
    /* 가격 밑 플러스 마이너스 버튼 */
      const plus = document.getElementById("plus");
      const down = document.getElementById("minus");
      let price = document.getElementById("price");
      const count = document.getElementById("product-count");
      let priceCount=<%=p.getProductPrice()%>;
      let countResult=1;
      plus.addEventListener("click",e=>{
          if(priceCount>=<%=p.getProductPrice()%> || countResult>=1){
            countResult+=1;
            priceCount+=<%=p.getProductPrice()%>;
          count.innerHTML=countResult;
          price.innerHTML=priceCount.toLocaleString('ko-KR');
          $("#list-count").text("("+countResult+")");
          $("#list-price").text((countResult*<%=p.getProductPrice()%>).toLocaleString('ko-KR'));
          }
          /* 전체 금액 조회해서 total에 출력 */
          let totalPrice = document.getElementsByClassName("list-price");
          let totalpriceResult = 0;
          for(const p of totalPrice){
        	  totalpriceResult+=parseFloat(p.innerText.replace(/,/g, ''));
          }
          productPrice = $("#price").text().replace(/,/g, '');
          /* totalpriceResult = parseFloat(productPrice)+totalpriceResult; */
          if(totalpriceResult<100000){
        	  totalpriceResult = totalpriceResult+3500;
          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
          $("#delivery").text("(배송비 포함 : 3,500원)");
          }else{
          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
          $("#delivery").text("");
          }
      });
      
      

      down.addEventListener("click",e=>{
        if(priceCount><%=p.getProductPrice()%> || countResult!=1){
          countResult-=1;
          priceCount-=<%=p.getProductPrice()%>;
        count.innerHTML=countResult;
        price.innerHTML=priceCount.toLocaleString('ko-KR');
        down.style.opacity=1;
        $("#list-count").text("("+countResult+")");
        $("#list-price").text((countResult*<%=p.getProductPrice()%>).toLocaleString('ko-KR'));
        }
        /* 전체 금액 조회해서 total에 출력 */
        let totalPrice = document.getElementsByClassName("list-price");
        let totalpriceResult = 0;
        for(const p of totalPrice){
        	totalpriceResult+=parseFloat(p.innerText.replace(/,/g, ''));
        }
        productPrice = $("#price").text().replace(/,/g, '');
        if(totalpriceResult<100000){
      	  totalpriceResult = totalpriceResult+3500;
        $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
        $("#delivery").text("(배송비 포함 : 3,500원)");
        }else{
        $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
        $("#delivery").text("");
        }
      });
     
     
      /* 셀렉션 1번 선택하면 다시 선택 못하게 설정 최대 1회가능 */

      document.addEventListener('DOMContentLoaded', (event) => {
    	    const selectElement = document.getElementById('product');

    	    selectElement.addEventListener('change', function() {
				/* console.log(this); */
    	    	const select = document.getElementById("product");
    	    	 const tableResult = select.value.split(':');
    	    	 console.log(tableResult[0]);

    	    	 const subProduct = "<tr><td class='list-name'>"+tableResult[0]+"</td><td class='list-count'>(1)</td><td class='list-price'>"+Number(tableResult[1]).toLocaleString('ko-KR')+"</td><td><img class='list-delete-btn' src='https://i.imgur.com/U1LZh3O.png' width=15px style='padding-top:10px'></td></tr>";
    				$(".product-container>table").append(subProduct); 
    	    	
    	    	const selectedOption = this.options[this.selectedIndex];
    	        selectedOption.disabled = true;
    	        this.selectedIndex = 0;
    	        
    	        /* 전체 금액 조회해서 total에 출력 */
    	          let totalPrice = document.getElementsByClassName("list-price");
    	          let totalpriceResult = 0;
    	          for(const p of totalPrice){
    	        	  totalpriceResult+=parseFloat(p.innerText.replace(/,/g, ''));
    	          }
    	          productPrice = $("#price").text().replace(/,/g, '');
    	          console.log(productPrice);
    	          if(totalpriceResult<100000){
    	        	  totalpriceResult = totalpriceResult+3500;
    	          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
    	          $("#delivery").text("(배송비 포함 : 3,500원)");
    	          }else{
    	          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
    	          $("#delivery").text("");
    	          }
    	    });
    	});
      
      /* x이미지 클릭시 해당 제품 삭제 */
      $(document).on('click', '.list-delete-btn', function(e) {
    	  let result = $(e.target).parent().parent().children().first().text();
    	  console.log(result);
    	  $(e.target).parent().parent().remove();
   	  /* x버튼 클릭시 상단에 비활성화된 input을 다시 활성화시키는 로직 */  
    	  switch(result){
    	  case "얼음틀" : const ice = document.getElementById('ice');
          				ice.disabled = false;break;
    	  case "잔" : const glass = document.getElementById('glass');
						glass.disabled = false;break;
    	  case "선물포장" : const pack = document.getElementById('pack');
							pack.disabled = false;break;
    	  }
   	  
    	  /* 전체 금액 조회해서 total에 출력 */
          let totalPrice = document.getElementsByClassName("list-price");
          let totalpriceResult = 0;
          for(const p of totalPrice){
        	  totalpriceResult+=parseFloat(p.innerText.replace(/,/g, ''));
          }
          productPrice = $("#price").text().replace(/,/g, '');
          if(totalpriceResult<100000){
        	  totalpriceResult = totalpriceResult+3500;
          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
          $("#delivery").text("(배송비 포함 : 3,500원)");
          }else{
          $("#totalPrice").text("total : "+(totalpriceResult).toLocaleString('ko-KR')+"원");
          $("#delivery").text("");
          }
      });
      //결제페이지로 정보 보내기
      document.getElementById("parchase").addEventListener("click",e=>{
  		const xmlRequest=new XMLHttpRequest();
  		xmlRequest.onload=()=>{
  			if(xmlRequest.status==200){
  				document.write(xmlRequest.responseText);
  			}
  		}
  		const productName=document.querySelector(".list-name").innerText;
  		const productCount=document.querySelector("#product-count").innerText;
  		const productPrice=document.querySelector("#price").innerText.replace(",","");
   		const totalprice=document.querySelector("#totalPrice").innerText.replace(/[^0-9]/g, '');

   		/*const totalprice=document.querySelector("#list-price").innerText.replace(",","");*/  		

  		xmlRequest.open("post","<%=request.getContextPath()%>/order/productdetailorder.do");
  		xmlRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
  		
  		
  		xmlRequest.send("productName="+productName+"&productCount="+productCount+"&productPrice="+productPrice+"&totalprice="+totalprice);
  	});
      
    </script>
</body>
</html>
<%@ include file="/WEB-INF/views/product/ProductInfoDetail.jsp"%> 