package com.example.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.dto.Board;
import com.example.dto.BoardAttach;
import com.example.dto.BoardComment;
import com.example.dto.Likes;
import com.example.mapper.BoardMapper;

@Repository(value = "boardDao")
public class OracleBoardDao {

	@Autowired
	@Qualifier(value = "jdbcTemplate")
	JdbcTemplate jdbcTemplate;

	@Autowired
	@Qualifier(value = "dataSource")
	DataSource dataSource;

	@Autowired
	@Qualifier("boardMapper")
	private BoardMapper boardMapper;

	public int insertBoardByName(Board board) {
		// TODO Auto-generated method stub
		 return boardMapper.insertBoardByName(board);
	}
	public List<BoardAttach> selectBoardAttachByBoardNo(int boardNo){
		
		return boardMapper.selectBoardAttachByBoardNo(boardNo);
		
	}
	public void insertBoardAttach(BoardAttach attach){
		boardMapper.insertBoardAttach(attach);
	}

	public List<Board> selectBoardByName(String mbrId) {
		// TODO Auto-generated method stub
		String sql = "select * from board where boardwriter = ? order by boardno desc";
		List<Board> boards = jdbcTemplate.query(sql, new Object[] { mbrId }, new RowMapper<Board>() {

			@Override
			public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Board board = new Board();
				board.setBoardNo(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setBoardWriter(rs.getString(3));
				board.setBoardDate(rs.getDate(4));
				board.setBoardReadCount(rs.getInt(5));
				board.setBoardContent(rs.getString(6));

				return board;
			}

		});

		return boards;
	}

	public void deleteBoardByBoardNo(int boardNo) {
		// TODO Auto-generated method stub
		boardMapper.deleteBoardByBoardNo(boardNo);
	}

	public void updateBoardByBoardNo(Board board) {
		// TODO Auto-generated method stub
		boardMapper.updateBoardByBoardNo(board);

	}

	public List<Board> selectBoard() {
		// TODO Auto-generated method stub
		List<Board>boards = boardMapper.selectBoard();
		return boards;
	}

	public Board selectBoardByBoardNo(int boardNo) {
		// TODO Auto-generated method stub
		return boardMapper.selectBoardByBoardNo(boardNo);
	}

	public List<Board> selectBoardByKey(String key) {
		// TODO Auto-generated method stub
		return boardMapper.selectBoardByKey(key);
		
		
	}

	public void updateReadCountByBoardNo(Integer boardNo) {
		// TODO Auto-generated method stub
		boardMapper.updateReadCountByBoardNo(boardNo);
	}
	
	public void insertLikes(Likes likes){
		HashMap<String, Object> params = new HashMap<>();
		params.put("boardWriter",likes.getBoardWriter());
		params.put("mbrId",likes.getMbrId());
		params.put("boardNo",likes.getBoardNo());
		boardMapper.insertLikes(likes);
		
	}
	
	public void deleteLikes(Likes likes) {
		// TODO Auto-generated method stub
		HashMap<String, Object> params = new HashMap<>();
		params.put("boardWriter",likes.getBoardWriter());
		params.put("mbrId",likes.getMbrId());
		params.put("boardNo",likes.getBoardNo());
		boardMapper.deleteLikesByIdAndWriter(likes);
	}
	
	public Likes selectLikesByIdAndWriter(Likes likes) {
		// TODO Auto-generated method stub
		HashMap<String, Object> params = new HashMap<>();
		params.put("boardWriter",likes.getBoardWriter());
		params.put("mbrId",likes.getMbrId());
		params.put("boardNo",likes.getBoardNo());
		return boardMapper.selectLikesByIdAndWriter(likes);
		
	}

	public void insertComment(BoardComment comment) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("boardNo",comment.getBoardNo());
		params.put("writer",comment.getWriter());
		params.put("content",comment.getContent());
		boardMapper.insertComment(comment);
	}

	public void updateComment(BoardComment comment) {
		boardMapper.updateComment(comment);
	}

	public void deleteComment(int commentNo) {
		boardMapper.deleteComment(commentNo);
	}

	public List<BoardComment> selectCommentByBoardNo(int boardNo) {
		List<BoardComment> comments = boardMapper.selectCommentByBoardNo(boardNo);
		return (ArrayList<BoardComment>) comments;
	}

	public List<Likes> selectLikesByBoardWriter(String boardWriter) {
		// TODO Auto-generated method stub
		return boardMapper.selectLikesByBoardWriter(boardWriter);
	}

	public void insertMessage(List<Likes> likes) {
		// TODO Auto-generated method stub
		
		for(int i = 0 ; i< likes.size();i++){
			HashMap<String, Object> params = new HashMap<>();
			params.put("boardWriter",likes.get(i).getBoardWriter());
			params.put("mbrId",likes.get(i).getMbrId());
			boardMapper.insertMessage(likes.get(i));
		}
		
	}
	public List<BoardAttach> selectFileInfo(Integer boardNo) {
		// TODO Auto-generated method stub
		return boardMapper.selectFileInfo(boardNo);
	}






}
