package com.test.spring;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {

	private BoardDAO dao;
	
	@Autowired
	public BoardServiceImpl(BoardDAO dao) {
		this.dao = dao;
	}
	
	@Override
	public int add(BoardDTO dto) {
	
		return dao.add(dto);
	}
	
	@Override
	public List<BoardDTO> list() {
		
		return dao.list();
	}
	
	@Override
	public BoardDTO get(String seq) {
	
		return dao.get(seq);
	}
	
}






















