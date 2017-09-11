package com.example.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.BoardAttach;
import com.example.common.Util;
import com.example.dto.Board;
import com.example.dto.BoardComment;
import com.example.dto.Likes;
import com.example.dto.Member;
import com.example.service.OracleBoardService;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class BoardController {

	@Autowired
	@Qualifier("boardService")
	OracleBoardService boardService;
	/**
	 * 날짜를 Binding해주는 메서드 요청 데이터와 컨트롤러 메서드의 전달인자 매핑을 위한 초기화 개별 컨트롤러에서
	 * InitBinder를 함 => 일반적인 컨버팅이 아니라 개별적인 컨버팅 하는 곳
	 * 
	 * @param binder
	 */
	// @InitBinder
	// public void initBinder(WebDataBinder binder){
	// SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	//
	//
	// binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
	// false));
	// }

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	/**
	 * 게시글 등록 화면 이동 Controller
	 * 
	 * @return
	 */
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public ModelAndView registerForm() {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		mav.addObject("board", board);
		mav.setViewName("/board/boardregisterform");
		return mav;
	}

	/**
	 * 게시글 등록 Controller
	 * 
	 * @param board
	 *            사용자가 보낸 게시글 데이터(제목, 작성자, 내용 ...)
	 * @return
	 */
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public ModelAndView register(Board board, MultipartHttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		// 1. Disk에 파일 저장
		
		BoardAttach attach = null;
		MultipartFile file = req.getFile("file");
		if (!file.isEmpty() && file.getOriginalFilename().length() != 0) {
			String path = req.getSession().getServletContext().getRealPath("/WEB-INF/upload");
			String savedFileName = file.getOriginalFilename();
			savedFileName = Util.makeUniqueFileName(savedFileName);
			try {
				file.transferTo(new File(path, savedFileName));
				attach = new BoardAttach();
				attach.setSavedFileName(savedFileName);
				attach.setUserFileName(file.getOriginalFilename());
			} catch (Exception ex) {
			}
		}

		// 2. DB에 데이터 저장
		int newBoardNo = boardService.registerBoard(board);
		if (attach != null) {
			attach.setBoardNo(board.getBoardNo());
			boardService.saveBoardAttach(attach);
		}

		// 게시글 등록시 작성자를 좋아요 누른 사용자들을 조회
		List<Likes> likes = boardService.showLikeList(board.getBoardWriter());
		// 그 데이터를 Message테이블에 등록
		boardService.registerMessage(likes);

		System.out.println(board.getBoardNo() + "들어오는번호");
		
		mav.setViewName("redirect:list");
		mav.addObject("board", board);
		return mav;
	}

	/**
	 * 게시글 조회 Controller
	 * 
	 * @param model
	 *            조회한 결과를 사용자에게 보여주는 객체
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model) {
		model.addAttribute("board", boardService.showList());
		return "/board/list";
	}

	/**
	 * 사용자가 게시글을 눌렀을 때 사용자에게 게시글의 내용을 보여주는 Controller
	 * 
	 * @param boardNo
	 *            게시글의 정보를 찾기위해 필요한 게시글 번호 + 사용자가 해당 게시글에 대해 좋아요를 눌렀는지 안눌렀는지
	 *            조회하기 위해 필요한 게시글 번호 + 게시글에 있는 첨부파일을 조회
	 * @param boardWriter
	 *            사용자가 해당 게시글에 대해 좋아요를 눌렀는지 안눌렀는지 조회하기 위해 필요한 게시글 작성자
	 * @param session
	 *            사용자가 해당 게시글에 대해 좋아요를 눌렀는지 안눌렀는지 조회하기 위해 필요한 로그인 사용자
	 * @return
	 */
	@RequestMapping(value = "detail/{boardNo}&{boardWriter}")
	public ModelAndView detail(@PathVariable(value="boardNo")Integer boardNo,@PathVariable(value="boardWriter")String boardWriter, HttpSession session) {
		Member member = (Member) session.getAttribute("loginmember");

		// 사용자가 클릭한 boardNo를 가지고 DB를 조회하고 가져온다.
		Board board = boardService.detailBoardByBoardNo(boardNo);
		// 사용자가 클릭하면 게시판의 조회수가 1 증가한다.
		boardService.addReadCount(boardNo);
		// boardNo를 가지고 DB를 조회하여 게시글에 있는 댓글을 가져온다.
		List<BoardComment> comments = boardService.findBoardCommentByBoardNo(boardNo);
		// boardNo를 가지고 DB를 조회하여 게시글에 있는 첨부파일을 가져온다
		List<BoardAttach> attaches = boardService.getBoardAttachByBoardNo(boardNo);
		// 사용자와 작성자 글번호를 가지고 DB를 조회하여 좋아요 여부를 결정한다.
		if (member != null) {
			Likes likes = new Likes();
			likes.setBoardWriter(boardWriter);
			likes.setBoardNo(boardNo);
			likes.setMbrId(member.getMbrId());
			Likes rLikes = boardService.checkLikes(likes);

			if (rLikes == null) {
				ModelAndView mav = new ModelAndView();
				mav.addObject("comment", comments);
				mav.setViewName("board/detail");
				mav.addObject("board", board);
				mav.addObject("attach", attaches);
				return mav;
			}

			// JSP에서 사용하려면 저장해야지
			ModelAndView mav = new ModelAndView();
			mav.addObject("comment", comments);
			mav.setViewName("board/detail");
			mav.addObject("board", board);
			mav.addObject("likes", rLikes);
			mav.addObject("attach", attaches);

			return mav;
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("comment", comments);
		mav.setViewName("board/detail");
		mav.addObject("board", board);
		mav.addObject("attach", attaches);
		return mav;
	}

	@RequestMapping(value = "downloadAttach.action")
	public void downloadAttach(Integer boardNo, HttpServletResponse resp) throws Exception {
		List<BoardAttach> attaches = boardService.getFileInfo(boardNo);
		String userFileName = attaches.get(0).getUserFileName();
		String savedFileName = attaches.get(0).getSavedFileName();
		byte fileByte[] = FileUtils.readFileToByteArray(new File(
				"C:\\BIGDATA04\\Labs\\SpringBasic\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\22.spring-badaweb\\WEB-INF\\upload\\"
						+ savedFileName));

		resp.setContentType("application/octet-stream");
		resp.setContentLength(fileByte.length);
		resp.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(userFileName, "UTF-8") + "\";");
		resp.setHeader("Content-Transfer-Encoding", "binary");
		resp.getOutputStream().write(fileByte);
		resp.getOutputStream().flush();
		resp.getOutputStream().close();

	}

	/**
	 * 작성자가 게시글 수정버튼을 눌렀을 때 jsp를 보여주는 Controller
	 * 
	 * @param boardNo
	 *            수정 버튼 눌렀을 때 화면의 내용을 해당 게시글의 내용으로 채우기 위해 필요한 게시글 번호
	 * @return
	 */
	@RequestMapping(value = "update.action")
	public ModelAndView updateForm(Integer boardNo) {
		ModelAndView mav = new ModelAndView();
		Board board = boardService.detailBoardByBoardNo(boardNo);
		mav.addObject("board", board);
		mav.setViewName("board/updateform");
		return mav;
	}

	/**
	 * 게시글 수정 화면에서 수정버튼을 눌렀을 때 사용자가 입력한 데이터로 DB를 갱신하는 Controller
	 * 
	 * @param board
	 *            form에서 넘어온 데이터(제목, 작성자, 내용...)
	 * @return
	 */
	@RequestMapping(value = "update.action", method = RequestMethod.POST)
	public ModelAndView update(Board board) {
		ModelAndView mav = new ModelAndView();
		boardService.updateBoard(board);
		mav.addObject("board", board);
		mav.setViewName(
				"redirect:/detail.action?boardNo=" + board.getBoardNo() + "&boardWriter=" + board.getBoardWriter());
		return mav;
	}

	/**
	 * 글 삭제를 눌렀을 때 DB에서 해당 글을 삭제하는 Controller
	 * 
	 * @param boardNo
	 *            게시글 번호를 이용해 DB를 조회하고 해당 글을 삭제.
	 * @return
	 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ModelAndView delete(Integer boardNo) {
		ModelAndView mav = new ModelAndView();
		boardService.deleteBoardByBoardNo(boardNo);
		mav.setViewName("redirect:list");
		System.out.println(boardNo);
		return mav;
	}

	/**
	 * 검색하는 기능.
	 * 
	 * @param key
	 *            key값을 사용자로부터 입력받아 Board테이블 조회
	 * @return
	 */
	@RequestMapping(value = "searchboard.action", method = RequestMethod.POST)
	public ModelAndView search(@RequestParam(value = "key") String key) {
		ModelAndView mav = new ModelAndView();
		List<Board> boards = boardService.searchBoard(key);
		mav.addObject("board", boards);
		mav.setViewName("/board/list");
		return mav;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////// 댓글///////////////////////////////////////////////////////////
	/**
	 * 걍 댓글등록
	 * 
	 * @param comment
	 * @param pageNo
	 * @return
	 */
	@RequestMapping(value = "writecomment", method = RequestMethod.POST)
	public String writeComment(BoardComment comment, String boardWriter) {
		try {
			boardService.writeComment(comment);
		} catch (Exception e) {
			logger.info("댓글 내용 없음 오류");
		}
		return "redirect:detail/"+comment.getBoardNo()+"&"+boardWriter;
	}

	/**
	 * Ajax를 이용한 댓글 확인
	 * 
	 * @param boardNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "commentlist", method = RequestMethod.POST)
	public String loadCommentList(Integer boardNo, Model model) {
		List<BoardComment> comments = boardService.findBoardCommentByBoardNo(boardNo);
		model.addAttribute("comment", comments);
		return "board/comment-list";
	}

	/**
	 * 댓글 삭제
	 * 
	 * @param comment
	 * @return
	 */
	@RequestMapping(value = "deletecomment", method = RequestMethod.GET)
	public String deleteComment(Integer commentNo, Integer boardNo, String boardWriter) {
		boardService.deleteComment(commentNo);
		return "redirect:detail/"+boardNo+"&"+boardWriter;
	}

	/**
	 * 좋아요 등록
	 * 
	 * @param likes
	 * @return
	 */
	@RequestMapping(value = "like", method = RequestMethod.POST)
	public String like(Likes likes) {
		boardService.addLikes(likes);
		return "redirect:detail/" + likes.getBoardNo() + "&" + likes.getBoardWriter();

	}

	/**
	 * 좋아요를 조회하는 Controller
	 * 
	 * @param likes
	 * @return
	 */
	@RequestMapping(value = "likelist", method = RequestMethod.POST)
	@ResponseBody
	public String showLike(Likes likes) {
		Likes rLikes = boardService.checkLikes(likes);
		if (rLikes == null) {
			System.out.println("조회결과가 없는 것이네");
			return "";
		} else {
			return "";
		}
	}

	/**
	 * 좋아요를 취소하는 Controller
	 * 
	 * @param likes
	 * @return
	 */
	@RequestMapping(value = "likedelete", method = RequestMethod.POST)
	public String likeDelete(Likes likes) {
		boardService.subLikes(likes);
		return "redirect:detail/" + likes.getBoardNo() + "&" + likes.getBoardWriter();

	}

}
