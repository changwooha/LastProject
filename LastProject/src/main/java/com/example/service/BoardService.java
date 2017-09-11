package com.example.service;

import java.util.List;

import com.example.dto.Board;
import com.example.dto.BoardAttach;
import com.example.dto.BoardComment;
import com.example.dto.Member;

public interface BoardService {

	int registerBoard(Board board);
	List<Board> showList(String mbrId);
	List<Board> showList();
	void deleteBoardByBoardNo(int boardNo);
	Board detailBoardByBoardNo(int boardNo);
	void updateBoard(Board board);
	void addReadCount(Integer boardNo);
	void writeComment(BoardComment comment);
	void deleteComment(int commentNo);
	void updateComment(BoardComment comment);
	List<BoardComment> findBoardCommentByBoardNo(int boardNo);
	void saveBoardAttach(BoardAttach attach);
	List<BoardAttach> getBoardAttachByBoardNo(int boardNo);
	List<BoardAttach> getFileInfo(Integer boardNo);
}