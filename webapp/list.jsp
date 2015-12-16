<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ include file="/include/tags.jspf"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jspf"%>
</head>
<style>
	body{
		font-family:Dotum,'돋움',Helvetica,AppleSDGothicNeo,sans-serif;
	}
	
	#main {
		width : 80%;
		margin : 0 auto;
	}
	
	#title{
		position: relative;
		margin : 30px 10px 50px 10px;
	}
	#title a{
		color : rgb(128, 128, 128);
		text-decoration : none;
	}
	#title #qes{
		/*
		1. 
		#title에서 위에서 0px;
		#title에서 오른쪽에서 10px;
		너비는 80px
		높이는 40px 
		*/
		position: absolute;
		top: 0px;
		right: 10px;
		width: 80px;
		height: 40px;
		
		line-height: 42px;
		border: 2px solid #808080;
		border-radius: 50px;
		background : #fff;
		text-decoration: none;
		text-align: center;
	}
	
	#content{
		/*
		2.
		안쪽 여백을 0px로 
		바깥쪽 여백을 10px로 넣는다.
		*/
		padding: 0px;
		margin: 10px;
	}
	#content li{
		position : relative;
		padding : 10px;
		list-style : none;
		border-bottom : 1px solid #eaebec;
	}
	#content .first{
		border-top : 1px solid #eaebec;
	}
	#content li h2{
		margin : 0px 0px 10px 0px;
		font-size: 1.3em; 
	}
	#content li a{
		color : rgb(0, 119, 204);
		text-decoration : none;
	}
	#content li a:visited{
		color: #6e4987;
	}
	#content li .metadata span{
		color : 	rgb(153, 153, 153);
	} 
	/*
	3. 
	[.author에 있는 엘리먼트에 해당 스타일을 적용해라.]{
		color : rgb(0, 119, 204);
	} 
	*/
	#content li .metadata span.author{
		color: rgb(0, 119, 204);
	}
	
	#content .del{
		position : absolute;
		top: 10px;
		right: 10px;
	}
	
	#footer .more{
		width : 100%;		
		height: 40px;
		border: 2px solid #f79e41;
		border-radius: 50px;
		background : #fff;
		color: #000;
		font-size : 16px;
		text-decoration: none;
	}

</style>
<body>
	<div id ="main">
	    <div id="title">
	        <h1><a href="/list.next">Web Programming 실습</a></h1>
	        <a id="qes" href="/form.next">질문하기</a>
	    </div>
	    <ul id="content">    
		<c:forEach items="${questions}" var="each" varStatus="eachCounter">
		  <li class="post <c:if test="${eachCounter.count == 1}">first</c:if>">
		      <h2 class="title">
		          <a href="/show.next?questionId=${each.questionId}">${each.title}</a>
		      </h2>
		      <div class="metadata">
		      	  <!--
		      	  4.
		      	  ${each.writer}는 author,   
		      	  <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${each.createdDate}" />는 date,
		      	  comments은 빈 값으로 inline tag을 사용하여 넣는다.
		      	  
		      	  sample)
		      	  <inline-tag class="date"></inline-tag>
		      	  <inline-tag class="author"></inline-tag>
		      	  <inline-tag class="comments"></inline-tag>
		      	  -->
		      	  <span class="date"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${each.createdDate}" /></span>
		      	  <span class="author">${each.writer}</span>
		      	  <span class="comments"></span>
		      </div>
		      <button class="del" data-question-id="${each.questionId}">X</button>
		  </li>
		</c:forEach>
		</ul>
		<!--
		5.
		block 엘리먼트에 id를 footer로 등록하고 button엘리먼트를 감싼다.
		그리고 2번과 차이점을 확인한다.
		
		sample)
		<block-tag>
			<button class="more">더보기</button>
		</block-tag>  
		-->
		<div id="footer">
	    	<button class="more">더보기</button>
	    </div>
	</div>
</body>
<script type="text/javascript" src="/javascripts/list.js"></script>
</html>