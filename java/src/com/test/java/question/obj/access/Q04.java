package com.test.java.questino.obj.access;



public class Q04 {

	public static void main(String[] args) {
		

		// 직원(Employee) 클래스를 설계하시오.

		/*
		
		Employee 객체 메소드
		void info() : 직원 정보 확인
		
		*/
		
		Employee e1 = new Employee();

		e1.setName("홍길동");
		e1.setDepartment("홍보부");
		e1.setPosition("부장");
		e1.setTel("010-1234-5678");
		e1.setBoss(null); //직속 상사 없음

		e1.info();


		Employee e2 = new Employee();

		e2.setName("아무개");
		e2.setDepartment("홍보부");
		e2.setPosition("사원");
		e2.setTel("010-2541-8569");
		e2.setBoss(e1); //직속 상사 e1(홍길동)

		e2.info();
		
		
		//java.lang.NullPointerException
		//-> 해당 라인
		
	}

}



class Employee {
	
	private String name;
	private String department;
	private String position;
	private String tel;
	private Employee boss; // boss = null > 주소값 변수가 비어있다.
	
	


	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getDepartment() {
		return department;
	}




	public void setDepartment(String department) {
		//영업부, 기획부, 총무부, 개발부, 홍보부
		
		if (department.equals("영업부")
				|| department.equals("기획부")
				|| department.equals("총무부")
				|| department.equals("개발부")
				|| department.equals("홍보부")) {
			this.department = department;
		}
	}




	public String getPosition() {
		return position;
	}




	public void setPosition(String position) {
		//부장, 과장, 대리, 사원
		if (position.equals("부장")
				|| position.equals("과장")
				|| position.equals("대리")
				|| position.equals("사원")) {
			this.position = position;
		}
	}




	public String getTel() {
		return tel;
	}




	public void setTel(String tel) {
		//010-XXXX-XXXX 형식 확인
		if (tel.startsWith("010")
				|| tel.charAt(3) == '-'
				|| tel.charAt(8) == '-'
				|| tel.length() == 13) {
			this.tel = tel;
		}
	}




	public Employee getBoss() {
		return boss;
	}




	public void setBoss(Employee boss) {
		//직속상사 : 읽기/쓰기, 다른 직원 중 한명, 같은 부서가 아니면 될 수 없음(유효성 검사)
		
		//java.lang.NullPointerException
		if (boss != null) {
			if (this.department.equals(boss.getDepartment())) {
				this.boss = boss;
			}
		}
	}




	public void info() {

		String txt = String.format("[%s]\n- 부서: %s\n- 직위: %s\n- 연락처: %s\n"
									, this.name
									, this.department
									, this.position
									, this.tel);
		
		txt += "- 직속상사: ";
		
		if (this.boss == null) {
			txt += "없음";
		} else {
			txt += String.format("%s(%s %s)"
						, boss.getName()
						, boss.getDepartment()
						, boss.getPosition());
		}
		
		System.out.println(txt);
		
	}
}





















