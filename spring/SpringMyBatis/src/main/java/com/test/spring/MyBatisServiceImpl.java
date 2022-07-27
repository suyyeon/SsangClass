package com.test.spring;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class MyBatisServiceImpl implements MyBatisService {

	@Autowired
	@Qualifier("dao")
	private MyBatisDAO dao;
	
	@Override
	public void test() {
		
		System.out.println("2. " + (this.dao == null));
		
		dao.test();
	}
	
	@Override
	public void m1() {
		
		dao.m1();	
	}
	
	@Override
	public int m2(String seq) {
		
		return dao.m2(seq);
	}
	
	@Override
	public int m3(String seq) {
		
		return dao.m3(seq);
	}
	
	@Override
	public int m4(MyBatisDTO dto) {
	
		return dao.m4(dto);
	}
	
	@Override
	public int m5(String seq) {
	
		return dao.m5(seq);
	}
	
	@Override
	public MyBatisDTO m6(String seq) {
	
		return dao.m6(seq);
	}
	
	@Override
	public List<String> m7() {
		
		return dao.m7();
	}
	
	@Override
	public List<MyBatisDTO> m8() {
	
		return dao.m8();
	}
	
	@Override
	public int m9(String table) {
		
		return dao.m9(table);
	}
	
	@Override
	public List<MyBatisDTO> m10(String word) {
	
		return dao.m10(word);
	}
	
	@Override
	public List<String> m11(String type) {
		
		return dao.m11(type);
	}
	
}



















