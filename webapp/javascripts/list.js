var List = {
	"listPage" : 0,
	"init" : function() {
		this.bind();
	},
	"bind" : function() {
		// 1-1. del클래스를 가진 버튼에 del함수를 click이벤트에 바인딩 한다.
		// 1-2. more클래스를 가진 버튼에 more함수를 click이벤트에 바인딩 한다.

		document.querySelector('ul#content').addEventListener('click', this.del.bind(this), false);

		document.querySelector('.more').addEventListener('click',
				this.more.bind(this), false);
	},
	"del" : function(e) {
		// 2-1. del클래스를 가진 엘리먼트를 click하면 해당 질문 목록을 삭제할 수 있다.
		// 2-2. this의 context가 List객체여야 한다.
		
		var target = e.target;
		if(target.className == "del"){
			var questionId = target.dataset.questionId;
			 var url = "/api/deletequestion.next";
			 var params = "questionId=" + questionId;
			 
			 var request = new XMLHttpRequest();
			 request.open("POST", url, true);
			 request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			 
			 request.onreadystatechange = function() {
				 if(request.readyState == 4 && request.status == 200) {
					 var result = JSON.parse(request.responseText).result;
					 if(result){
						 target.closest("li.post").remove();
					 }else{
						 alert("질문을 삭제할수 없습니다");
					 }
				 }
			 }
			 
			 request.send(params);
		}
		
	},
	"more" : function(e) {
		// 3-1. more클래스를 가진 엘리먼트를 click하면 Ajax로 비동기 통신을 하여 질문 목록을 10개 가져온다.
		// 3-2. 가져온 질문 목록을 template pattern을 사용하여 넣는다.
		// 3-3. this의 context가 List객체여야 한다.
		// 3-4. 새로 등록한 엘리먼트들로 del클래스를 가진 엘리먼트를 click하면 해당 질문 목록을 삭제할 수 있다.(event
		// delegate pattern활용)
		this.listPage++;

		var url = "/api/morelist.next";
		var params = "?page=" + this.listPage;

		var request = new XMLHttpRequest();
		request.open("GET", url + params, true);
		request.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");

		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
				var questions = JSON.parse(request.responseText).questions;
				var nodeList = [];
				for (var i = 0; i < questions.length; ++i) {
					var question = questions[i];
					var newNode = document.querySelector("li.post.first")
							.cloneNode(true);
					var date = new Date(question.createdDate);
					var dateString = date.getFullYear() + "-" + date.getMonth()
							+ "-" + date.getDay() + " " + date.getHours() + ":"
							+ date.getMinutes() + ":" + date.getSeconds();

					newNode.className = "post";
					newNode.querySelector(".title a").href = "/show.next?questionId="
							+ question.questionId;
					newNode.querySelector(".title a").textContent = question.title;
					newNode.querySelector(".date").textContent = dateString;
					newNode.querySelector(".author").textContent = question.writer;
					newNode.querySelector(".del").dataset.questionId = question.questionId;

					document.querySelector("ul#content").appendChild(newNode);
				}
				// document.querySelector("ul#content").insertAdjacentHTML(nodeList);
			}
		}

		request.send(null);
	}
};

List.init();