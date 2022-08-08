package com.test.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.test.repository.TestDAO;

import lombok.RequiredArgsConstructor;

//어노테이션 방식으로 만든 컨트롤러
//- @Controller > @Component > @Bean > 스프링이 생성하고 관리하는 객체
//- 위의 어노테이션이 동작을 하려면 지정된 공간(패키지)내에 있어야 한다.
//- 스캔 기본 패키지 > 메인 클래스가 포함된 패키지 > com.test.spring


//@Controller
//public class DIController {
//
//	@GetMapping("/test")
//	public String test() {
//		
//		return "test";
//	}
//	
//}



//의존 주입 방법
//1. 생성자 > 유일하게 final 멤버를 의존 주입할 수 있다. > 가장 선호되는 방법
//2. Setter > 거의 사용 안함
//3. 필드 주입 > 종종 사용함




//의존 주입 1.
//- 가장 정석
//- 생성자 주입
//- @Autowired 사용X
//- 생성자가 유일해야 한다.
//@Controller
//public class DIController {
//	
//	private final TestDAO dao;
//	
//	public DIController(TestDAO dao) {
//		this.dao = dao;
//	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}




//의존 주입 2.
//- 생성자 주입
//- 생성자가 여러개라면?
//@Controller
//public class DIController {
//	
//	private TestDAO dao;
//	
//	public DIController() {
//		
//	}
//	
//	//의존 주입에 사용할 생성자라고 역할을 지정해주면 된다.
//	@Autowired
//	public DIController(TestDAO dao) {
//		this.dao = dao;
//	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}







//의존 주입 3.
//- 의존 객체가 클래스가 아니라 인터페이스 구현 객체일 때
//- 인터페이스 변수에 의존 객체 삽입 > (내부) > 스프링이 해당 인터페이스의 구현 객체(클래스)를 찾아서 객체화를 한다. 
//- 가장 흔한 방식
//@Controller
//public class DIController {
//	
//	private IMemberDAO dao;
//	
//	public DIController(IMemberDAO dao) {
//		this.dao = dao;
//	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}







//의존 주입 4.
//- Setter 주입
//- @Autowired가 필요하다.
//- 여러 Setter 중 의존 주입에 사용할 Setter를 지정한다.
//@Controller
//public class DIController {
//	
//	private final IMemberDAO dao;
//	
//	@Autowired
//	public void setDao(IMemberDAO dao) {
//		this.dao = dao;
//	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}








//의존 주입 5.
//- 의존 주입을 여러번 하는 경우
//@Controller
//public class DIController {
//	
//	private TestDAO dao;
//	private IMemberDAO mdao;
//	
//	public DIController(TestDAO dao, IMemberDAO mdao) {
//		this.dao = dao;
//		this.mdao = mdao;
//	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println(mdao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}






//의존 주입 6.
//- 필드 주입
//- 직접 멤버 변수에 @Autowired를 적용한다.
//@Controller
//public class DIController {
//	
//	@Autowired
//	private TestDAO dao;
//	
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}








//의존 주입 7.
//- 인터페이스 사용
//- 인터페이스 구현 객체가 여러개라면? > 이런 상황을 만들면 안된다!! > 의존 주입용으로 사용하는 인터페이스는 반드시 클래스는 1개만 만든다.(*****)
//@Controller
//public class DIController {
//	
//	@Autowired
//	//@Qualifier("adminDAO") //클래스명
//	@Qualifier("admin") //별칭
//	private IMemberDAO dao;
//		
////	public DIController(IMemberDAO dao) {
////		this.dao = dao;
////	}
//
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}






//의존 주입 8.
//- 생성자 주입 + Lombok
//- @RequiredArgsConstructor > 멤버가 있는 생성자를 만들어 준다. > final 필드를 자동으로 매개변수로 넣는다.
//@Controller
//@RequiredArgsConstructor
//public class DIController {
//	
//	private final TestDAO dao;
//	
//	@GetMapping("/test")
//	public String test() {
//		
//		System.out.println(dao.test());
//		System.out.println();
//		
//		return "test";
//	}
//	
//}







@Controller
@RequiredArgsConstructor
public class DIController {
	
	private final TestDAO dao;
	
	@GetMapping("/test")
	public String test(Model model) {
		
		List<String> list = dao.list();
		
		model.addAttribute("list", list);
		
		System.out.println(list);
		
		return "test";
	}
	
}

















