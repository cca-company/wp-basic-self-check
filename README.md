#### 1. Tomcat 서버를 시작할 때 웹 애플리케이션이 초기화하는 과정을 설명하라.
* WebServerLuncher를 통해 톰캣 서버가 실행된다
* 서버가 실행되면 ContextLoaderListener가 알림을 받고 컨텍스트 초기화가 실행된다
* 그후 서블릿 클래스가 초기화된다. 
 * DispatcherServlet클래스에서 RequestMapping을 초기화한다
 * RequestMapping에서는 요청 url을 해당하는 컨트롤러를 생성하여 매핑시키는 작업을 한다

#### 2. Tomcat 서버를 시작한 후 http://localhost:8080으로 접근시 호출 순서 및 흐름을 설명하라.
* Tomcat 서버에서 request와 response 객체가 생성된다
* 해당 url에 매핑된 서블릿으로 생성된 객체를 전달한다
* 매핑된 url이 없으므로 index.jsp를 실행시킨다
 * 이때 index.jsp에 의해 /list.next url로 리다이렉트된다
* /list.next에 매핑된 ListController가 실행된다
 * 컨트롤러의 처리를 거쳐 list.jsp가 mav로 넘겨진다
* 넘겨받은 mav를 렌더해 최종적으로 질문 리스트 화면을 브라우저가 파싱한다

#### 9. ListController와 ShowController가 멀티 쓰레드 상황에서 문제가 발생하는 이유에 대해 설명하라.
* 멀티 쓰레드 상황의 각각의 쓰레드에서 메소드 내의 변수는 독자적인 스택에 생성되나 인스턴스는 공유된다.
 * 이때 공유되는 인스턴스에 여러 쓰레드에서 동시에 접근시 동기화 문제가 발생할수 있다.
 * 따라서 공유되서는 안되는 자원은 동기화 처리를 하거나, 메소드 내에서 초기화하므로써 해결할수 있다.

