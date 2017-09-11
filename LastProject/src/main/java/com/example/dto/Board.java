package com.example.dto;

import java.util.ArrayList;
import java.util.Date;

public class Board {

	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private int boardReadCount;
	private Date boardDate;
	private String boardContent;

	ArrayList<BoardComment> boardComments;

	
	public ArrayList<BoardComment> getComments() {
		return boardComments;
	}

	public void setComments(ArrayList<BoardComment> boardComments) {
		this.boardComments = boardComments;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardWriter() {
		return boardWriter;
	}

	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}

	public int getBoardReadCount() {
		return boardReadCount;
	}

	public void setBoardReadCount(int boardReadCount) {
		this.boardReadCount = boardReadCount;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

}
