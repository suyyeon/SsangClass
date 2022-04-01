package com.test.java.question.collection;

import java.util.ArrayList;

public class Q01 {
	
	public static void main(String[] args) {
		
		MyArrayList list = new MyArrayList();
		
		list.add("바나나");
		list.add("사과");
		list.add("포도");
		list.add("딸기");
		
		System.out.println(list);
		
		list.add("귤");
		
		System.out.println(list);
			
		//System.out.println(list.get(6));
		
		System.out.println(list.size());
		
		
		//list.set(7, "복숭아");
		
		//System.out.println(list);
		
		
		list.remove(2);
		
		System.out.println(list);
		
		list.add("망고");
		
		System.out.println(list);

		list.add(2, "참외");
		list.add(2, "앵두");
		System.out.println(list.add(2, "토마토"));
		System.out.println(list.add(2, "파파야"));
		
		System.out.println(list);
		
		System.out.println(list.indexOf("딸기"));
		
		
		//list.clear(); //모두 지웠다.. 생각
		
		//System.out.println("과일의 개수: " + list.size());
		
		//list.add("Apple");
		
		System.out.println(list);
		
		list.trimToSize();
		
		System.out.println(list);
		
		
		
	}//main

}
















































