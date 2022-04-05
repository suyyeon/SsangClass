package com.test.java.io;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;

public class Ex63_File {
	
	public static void main(String[] args) {
		
		//Ex63_File.java
		
		/*
		
			1. 파일/디렉토리 조작
			
			2. 파일 입출력
			- 자바 프로그램 <-> (데이터) <-> 저장 장치
			- 메모장
			
			저장 장치(HDD,SSD)
			- 데이터 1,0으로 저장
			- 데이터의 자료형 존재X
			
			인코딩, Encoding
			- 문자 코드(응용 프로그램의 데이터)를 부호화(1,0) 시키는 작업
			- 자바 프로그램("홍길동", String) -> 텍스트 파일("1010100010010") 
			
			디코딩, Decoding
			- 부호 데이터를 문자코드로 변환하는 작업
			- 텍스트 파일("1010100010010") -> 자바 프로그램("홍길동", String) 
			
			
			인코딩/디코딩 규칙
			- 저장 장치 혹은 네트워크 상에서 데이터를 표현하는 규칙
			1. ISO-8859-1
			2. EUC-KR
			3. ANSI
			4. MS949
			5. UTF-8
			6. UTF-16
			
			ANSI(ISO-8859-1, EUC-KR, MS949)
			1. 영어(숫자,특수문자,서유럽): 1byte
			2. 한글(한자,일본어 등): 2byte
			
			UTF-8 *** 이 인코딩을 사용한다.(국제 표준..)
			1. 영어: 1byte
			2. 한글: 3byte
			
			UTF-16
			1. 영어: 2byte
			2. 한글: 2byte
		
		*/
		
		//m1();
		//m2();
		//m3();
		//m4();
		
		//m5();
		//m6();
		//m7();
		//m8();
		
		
		//q07();
		//q08();
		//q09();
		q10();
		
		
	}//main

	private static void q10() {
		
		File dir = new File("C:\\class\\java\\file\\파일_디렉토리_문제\\직원");
		
		File[] list = dir.listFiles();
		
		for (File file : list) {
			if (file.isFile()) {
				
				String filename = file.getName();
				
				//System.out.println(filename);
				
				//Parsing : 의미있는 부분들을 쪼개는 작업
				
				//"홍길동_2022_11.txt"; > 홍길동 : 2022 : 11
				//"홍길동__2022_11.txt"; > 홍길동 : 빈방 : 2022 : 11
				
				
				filename = filename.replace("__", "_"); //정규화
				
				String[] temp = filename.split("_");
				//0 - 직원명
				//1 - 년도
				
				//아무게_2014__17.txt
				//아무게_2014__30.txt
				
				File newDirectory = new File (dir.getAbsolutePath() + "\\" + temp[0] + "\\" + temp[1]);
				
				newDirectory.mkdirs();
				
				
				File moveFile = new File(newDirectory.getAbsolutePath() + "\\" + file.getName());
				file.renameTo(moveFile);
				
				System.out.println("이동");			
				
				
			}
		}
		
	}

	private static void q09() {
		
		File dir = new File("C:\\class\\java\\file\\파일_디렉토리_문제\\크기 정렬");
		ArrayList<File> flist = new ArrayList<File>();
		
		searchFile(dir, flist);
		
		//크기순 정렬 > 버블 정렬
		for (int i=0; i<flist.size() - 1; i++) {
			for (int j=0; j<flist.size() - i - 1; j++) {
				
				if (flist.get(j).length() < flist.get(j+1).length()) {
					
					//swap
					File temp = flist.get(j);
					flist.set(j, flist.get(j+1));
					flist.set(j+1, temp);
					
				}
				
			}
		}
		
		
		for (File f : flist) {
			System.out.println(f.getParent().replace("C:\\class\\java\\file\\파일_디렉토리_문제\\크기 정렬\\", "") + ">" + f.getName() + "::" + f.length());
		}
		
	}

	private static void searchFile(File dir, ArrayList<File> flist) {
		
		File[] list = dir.listFiles();
		
		for (File f : list) {
			if (f.isFile()) {
				flist.add(f);
			}
		}
		
		for (File d : list) {
			if (d.isDirectory()) {
				searchFile(d, flist);
			}
		}
		
	}

	private static void q08() {
		
		File dir = new File("C:\\class\\java\\file\\파일_디렉토리_문제\\폴더 삭제\\delete");
		
		//dir.delete();
		
		deleteDirectory(dir);
		
	}

	private static void deleteDirectory(File dir) {
		
		//1.
		File[] list = dir.listFiles();
		
		//2.
		for (File f : list) {
			if (f.isFile()) {
				System.out.println(f.delete());
			}
		}
		
		//3.
		for (File d : list) {
			if (d.isDirectory()) {
				deleteDirectory(d); //재귀
			}
		}
		
		//여기까지 도달 > dir이 빈폴더가 되었음.
		dir.delete();
		
	}

	private static void q07() {
		
		File dirA = new File("C:\\class\\java\\file\\파일_디렉토리_문제\\동일 파일\\MusicA");
		File dirB = new File("C:\\class\\java\\file\\파일_디렉토리_문제\\동일 파일\\MusicB");
		
		String[] listA = dirA.list();
		String[] listB = dirB.list();
		
//		for (String s1 : listA) {
//			for (String s2 : listB) {
//				if (s1.equals(s2)) {
//					System.out.println(s1);
//					break;
//				}
//			}
//		}
		
		//HashSet > 중복값
		//1. 수업 중 
		//2. 안 배운 기능도 추가
		
		//Set > 집합 > 교집합, 합집합, 차집합..
		HashSet<String> set1 = new HashSet<String>();
		HashSet<String> set2 = new HashSet<String>();
		
		set1.add("빨강");
		set1.add("노랑");
		set1.add("파랑");
		set1.add("주황");
		set1.add("검정");
		
		set2.add("빨강"); //v
		set2.add("녹색");
		set2.add("분홍");
		set2.add("주황"); //v
		set2.add("검정"); //v
		
		//set1.addAll(set2);
		//System.out.println(set1); //set1 + set2 = 합집합
		
		//set1.retainAll(set2);
		//System.out.println(set1); //교집합
		
		//set1.removeAll(set2);
		//System.out.println(set1); //차집합+
		
		
		
		HashSet<String> list1 = new HashSet<String>();
		HashSet<String> list2 = new HashSet<String>();
		
		for (String s : listA) {
			list1.add(s);
		}
		
		for (String s : listB) {
			list2.add(s);
		}
		
		list1.retainAll(list2);
		
		System.out.println(list1);
		
		
	}

	private static void m8() {
		
		//파일 읽기
		try {
			
			File file = new File("C:\\class\\java\\JavaTest\\src\\com\\test\\java\\Ex28_String.java");
			
			if (file.exists()) {
				
				BufferedReader reader = new BufferedReader(new FileReader(file));
				
				String line = null;
				int n = 1;
				
				while ((line = reader.readLine()) != null) {
					
					System.out.printf("%3d: %s\n", n, line);
					n++;
					
				}
				
				reader.close();
				
			} else {
				System.out.println("읽은 파일을 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			System.out.println("Ex63_File.m8");
			e.printStackTrace();
		}
		
	}

	private static void m7() {
		
		//파일 쓰기
		//- FileWriter or BufferdWriter
		
		//파일 읽기
		//- BufferedReader
		
		
		//파일 읽기
		try {
			
			//BufferedReader reader
			//	= new BufferedReader(new InputStreamReader(System.in)); //키입력
			
			BufferedReader reader
				= new BufferedReader(new FileReader("C:\\class\\java\\file\\할일.txt"));//파일입력
			
			//int code = reader.read();
			
			//파일의 한줄을 읽기
//			String line = reader.readLine(); //사용자 경험 유지
//			System.out.println(line);
//			
//			line = reader.readLine();
//			System.out.println(line);
//			
//			line = reader.readLine();
//			System.out.println(line);
//			
//			line = reader.readLine();
//			System.out.println(line);
			
			
			String line = null;
			
			while ((line = reader.readLine()) != null) {
				
				System.out.println(line);
			}
			
			
			reader.close();
			
			
		} catch (Exception e) {
			System.out.println("Ex63_File.m7");
			e.printStackTrace();
		}
		
	}

	private static void m6() {
		
		//파일 읽기
		try {
			
			//FileWriter
			//FileReader
			
			FileReader reader = new FileReader("C:\\class\\java\\file\\할일.txt");
			
//			int code = reader.read();
//			System.out.println(code);
			
			int code = -1;
			
			while ((code = reader.read()) != -1) {
				System.out.print((char)code);
			}
			
			reader.close();
			
						
			
		} catch (Exception e) {
			System.out.println("Ex63_File.m6");
			e.printStackTrace();
		}
		
	}

	private static void m5() {
		
		//파일 읽기
		try {
			
			//FileOutStream
			//FileInputStream
			
			FileInputStream stream = new FileInputStream("C:\\class\\java\\file\\data.txt");
			
//			int code = stream.read();			
//			System.out.println(code);
//			
//			code = stream.read();			
//			System.out.println(code);
//			
//			code = stream.read();			
//			System.out.println(code);
//			
//			code = stream.read();			
//			System.out.println(code);
//			
//			code = stream.read();			
//			System.out.println(code);
//			
//			code = stream.read();			
//			System.out.println(code);
			
			int code = -1;
			
			while ((code = stream.read()) != -1) {
				
				System.out.print((char)code);
			}
			
			stream.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void m4() {
		
		//파일 쓰기
		try {
			
			//범용 도구
			//- 설정에 따라 다양한 소스를 입출력 도구
			//- BufferedReader reader;
			//- BufferedWriter writer;
			
			//전용 도구
			//- 파일을 대상으로 입출력 도구
			//- FileReader reader;
			//- FileWriter writer;
			
			BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\class\\java\\file\\list.txt"));
			
			writer.write("안녕하세요.");
			writer.newLine(); //writer.write("\n")
			writer.write("홍길동입니다.");
			
			writer.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void m3() {
		
		//메모장 쓰기 > 콘솔 버전
		try {
			
			Scanner scan = new Scanner(System.in);
			
			System.out.print("저장할 파일명: ");
			String filename = scan.nextLine(); //reader.readLine()
						
			FileWriter writer 
				= new FileWriter("C:\\class\\java\\file\\" + filename + ".txt");
			
			boolean loop = true;
			
			while (loop) {
				System.out.print("입력: ");
				String line = scan.nextLine();
				
				if (line.equals("exit")) {
					break;
				}
				
				writer.write(line); //한줄 입력 > 한줄 쓰기
				writer.write("\n");
			}
			
			//자원 해제 코드, Clean-up Code
			scan.close();
			writer.close();
			
			System.out.println("쓰기 종료");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void m2() {
		
		//쓰기 스트림
		try {
			
			FileWriter writer
				= new FileWriter("C:\\class\\java\\file\\member.txt", true);
			
			writer.write("\n");
			writer.write("홍길동");
			writer.write("\n");
			writer.write("아무개");
			writer.write("\n");
			writer.write("하하하");
			
			writer.close();
			
			//스트림은 닫으면 끝!!
			
			writer = new FileWriter("C:\\class\\java\\file\\member.txt", true);
			writer.write("추가 기록");
			writer.close();
			
			System.out.println("종료");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void m1() {
		
		//파일 입출력
		
		//파일 쓰기 > 파일 출력
		//- 스트림 생성(도구)
		
		//쓰기 스트림 객체
		//1. 생성 모드(=덮어쓰기), Create Mode > 더 많이 사용!!!!
		//	- 기본 방식
		//	a. 파일이 존재하지 않으면 자동으로 생성한다.
		//	b. 항상 파일을 덮어쓰기한다.
		
		//2. 추가 모드(=이어쓰기), Append Mode
		//	a. 파일이 존재하지 않으면 자동으로 생성한다.
		//	b. 파일이 존재하면.. 기존 내용을 그대로 두고, 추가로 데이터 저장한다.
		
		try {
			
			File file = new File("C:\\class\\java\\file\\data.txt");
			
			
			//스트림 열기
			//- 바이트 단위 쓰기(1byte)
			FileOutputStream stream = new FileOutputStream(file);
			
			//stream.write(68); //문자코드
			//stream.write(69);
			//stream.write(70);
			//stream.write('가');
			
			String txt = "Hello~ Hong~";
			
			for (int i=0; i<txt.length(); i++) {
				stream.write(txt.charAt(i));
			}
			
			
			
			//스트림 닫기
			//- 저장이 안된다.
			//- 잠긴 파일이 된다.
			stream.close();
			
			System.out.println("종료");
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		
	}

}//Ex63







































