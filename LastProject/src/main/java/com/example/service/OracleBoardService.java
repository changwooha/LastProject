package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.dao.OracleBoardDao;
import com.example.dto.Board;
import com.example.dto.BoardAttach;
import com.example.dto.BoardComment;
import com.example.dto.Likes;
import com.example.dto.Member;

@Service(value = "boardService")
public class OracleBoardService implements BoardService {

	@Autowired
	@Qualifier(value = "boardDao")
	OracleBoardDao boardDao;

	///////////////////////////////////////////////////////
	//////////////////// Board/////////////////////////////
	/**
	 * 데이터베이스에 사용자가 작성한 글 삽입
	 */
	@Override
	public int registerBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDao.insertBoardByName(board);
	}
	/**
	 * 보드번호를 이용해 그 보드번호에 첨부파일을 등록
	 */
	@Override
	public void saveBoardAttach(BoardAttach attach){
		boardDao.insertBoardAttach(attach);
	}
	/**
	 * 보드번호를 이용해 그 보드번호에 첨부파일을 조회
	 */
	@Override
	public List<BoardAttach> getBoardAttachByBoardNo(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardAttachByBoardNo(boardNo);
	}
	/**
	 * 보드번호를 이용해 그 보드번호에 있는 첨부파일을 다운 로드
	 */
	@Override
	public List<BoardAttach> getFileInfo(Integer boardNo) {
		return boardDao.selectFileInfo(boardNo);
		// TODO Auto-generated method stub
		
	}
	/**
	 * 사용자가 삭제버튼을 누른 게시글의 번호를 이용해 글 삭제
	 */
	@Override
	public void deleteBoardByBoardNo(int boardNo) {
		// TODO Auto-generated method stub
		boardDao.deleteBoardByBoardNo(boardNo);
	}
	/**
	 * 사용자 본인이 작성한 글 조회
	 */
	@Override
	public List<Board> showList(String mbrId) {
		// TODO Auto-generated method stub
		List<Board> boards = boardDao.selectBoardByName(mbrId);
		return boards;
	}
	/**
	 * 게시글 조회
	 */
	@Override
	public List<Board> showList() {
		// TODO Auto-generated method stub
		List<Board> boards = boardDao.selectBoard();
		return boards;
	}
	/**
	 * 사용자가 누른 게시글을 게시글번호를 이용해 보기
	 */
	@Override
	public Board detailBoardByBoardNo(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardByBoardNo(boardNo);
	}
	/**
	 * 사용자가 수정버튼을 눌렀을 때 게시글 번호를 이용해 수정
	 */
	@Override
	public void updateBoard(Board board) {
		// TODO Auto-generated method stub

		boardDao.updateBoardByBoardNo(board);
	}
	/**
	 * 사용자가 게시글을 눌렀을 때 조회수 증가 처리
	 */
	@Override
	public void addReadCount(Integer boardNo) {
		// TODO Auto-generated method stub
		boardDao.updateReadCountByBoardNo(boardNo);
	}
	
	/**
	 * 좋아요 등록.
	 * @param likes
	 */
	public void addLikes(Likes likes) {
		// TODO Auto-generated method stub
		boardDao.insertLikes(likes);
	}
	/**
	 * 좋아요 조회
	 * @param likes
	 */
	public Likes checkLikes(Likes likes) {
		// TODO Auto-generated method stub
		return boardDao.selectLikesByIdAndWriter(likes);
	}
	/**
	 * 등록된 좋아요 삭제
	 * @param likes
	 */
	public void subLikes(Likes likes) {
		// TODO Auto-generated method stub
		boardDao.deleteLikes(likes);
	}
	
	/**
	 * key값을 가지고 Board테이블을 조회.
	 * @param key
	 */
	public List<Board> searchBoard(String key) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardByKey(key);
	}

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////

	///////////////////////////////////////////////////////
	///////////////////// Comment//////////////////////////
	/**
	 * 댓글 등록
	 */
	@Override
	public void writeComment(BoardComment comment) {
		boardDao.insertComment(comment);
	}
	/**
	 * 댓글 삭제
	 */
	@Override
	public void deleteComment(int commentNo) {
		boardDao.deleteComment(commentNo);
	}
	/**
	 * 댓글 갱신
	 */
	@Override
	public void updateComment(BoardComment comment) {
		boardDao.updateComment(comment);
	}
	
	/**
	 * boardNo를 이용해 BoardComment에 저장된 댓글을 조회한다.
	 * @param boardNo
	 * @return
	 */
	@Override
	public List<BoardComment> findBoardCommentByBoardNo(int boardNo) {
		List<BoardComment> comments = boardDao.selectCommentByBoardNo(boardNo);
		return comments;
	}
	/////////////////////////////////////////////////////
	/////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////
	//////////////////Message///////////////////////////	
	public List<Likes> showLikeList(String boardWriter) {
		// TODO Auto-generated method stub
		List<Likes> likes = boardDao.selectLikesByBoardWriter(boardWriter);
		return likes;
		
	}

	public void registerMessage(List<Likes> likes) {
		// TODO Auto-generated method stub
		boardDao.insertMessage(likes);
	}






}
