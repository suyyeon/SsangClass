package com.test.java.question.operator;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Q07 {

	public static void main(String[] args) throws Exception {
		
		
		//코드 리뷰
		//- 현업
		//- 작성된 코드를 리뷰
		
		//코드 리뷰 형태
		//1. 상급자 > 하급자 리뷰 > 검사
		//2. 동급자 > 브레인스토밍 
		//3. 상급자 + 하급자 > 브레인스토밍
		
		//코드 리뷰 목적
		//1. 자신의 코드 상태 > 명확하게 인지
		//2. 다른 사람의 코드 상태 > 견문 확장
		
		
		
		//소회의실 > 팀별 > 팀원들 참여 > 화상 회의
		//주제 > 모든 문제.. 1~7번까지
		//방식 > 
		//산출물 > 코드 리뷰 > 제출 > 형식 제출
		
		
		/*
		//가독성 높음
		int a = 10; //국어점수
		int b = 20; //수학점수
		
		
		//가독성 낮음
		int a = 10, b = 20; //국어점수, 수학점수
		
		
		int a = 10, //국어점수 
		    b = 20; //수학점수
		
		*/
		
		
	
		//요구사항] 영문 소문자를 1글자 입력받은 후 대문자로 변환해서 출력하시오.
		//문자 입력 : a
		//소문자 'a'의 대문자는 'A'입니다.
		
		
		//바로 코딩 시작(X)
		//무조건 설계!!!!!
		
		//운동, 요리, 집짓기..
		
		
		//문제를 풀기 위한 프로세스..
		
		//1. 라벨을 출력한다. > "소문자 입력: "
		//2. BufferdReader를 생성한다. > throws Exception 적는다.
		//3. 소문자를 입력받는다. > reader.readLine()
		//4. 3의 반환값(문자열)을 받아서 char형으로 바꾼다. 입력값.charAt(0)
		//5. 4의 char의 문자 코드값을 얻는다. > 형변환
		//6. 5의 문자 코드값에서 -32 > 대문자의 문자 코드값
		//7. 6의 문자 코드값을 char 형변환
		//8. 콘솔에 "소문자 'a'의 대문자는 'A'입니다." 출력한다.
		
		
		//코드 작성 > Rework 검색
		System.out.print("소문자 입력: ");
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		
		String input = reader.readLine();
		
		
		
		
		
	}
	
}

















































