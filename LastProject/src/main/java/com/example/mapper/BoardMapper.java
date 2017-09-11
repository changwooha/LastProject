package com.example.mapper;

import java.util.List;

import com.example.dto.Board;
import com.example.dto.BoardAttach;
import com.example.dto.BoardComment;
import com.example.dto.Likes;

public interface BoardMapper {
	
	int insertBoardByName(Board board);
	List<Board> selectBoardByName(String mbrId);
	void deleteBoardByBoardNo(int board);
	void updateBoardByBoardNo(Board board);
	List<Board> selectBoard();
	Board selectBoardByBoardNo(int boardNo);
	void updateReadCountByBoardNo(int boardNo);
	void insertComment(BoardComment comment);
	void updateComment(BoardComment comment);
	void deleteComment(int commentNo);
	List<BoardComment>selectCommentByBoardNo(int boardNo);
	void insertLikes(Likes likes);
	Likes selectLikesByIdAndWriter(Likes likes);
	void deleteLikesByIdAndWriter(Likes likes);
	List<Likes> selectLikesByBoardWriter(String boardWriter);
	void insertMessage(Likes likes);
	List<Board> selectBoardByKey(String key);
	void insertBoardAttach(BoardAttach attach);
	List<BoardAttach> selectBoardAttachByBoardNo(int boardNo);
	List<BoardAttach> selectFileInfo(int boardNo);
}
