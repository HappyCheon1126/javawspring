package com.spring.javawspring;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.WebMessageService;
import com.spring.javawspring.vo.WebMessageVO;

@Controller
@RequestMapping("/webMessage")
public class WebMessageController {
	
	@Autowired
	WebMessageService webMessageService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/webMessage", method = RequestMethod.GET)
	public String webMessageGet(Model model, HttpSession session,
			@RequestParam(name="mSw", defaultValue = "1", required = false) int mSw,
			@RequestParam(name="mFlag", defaultValue = "1", required = false) int mFlag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		String mid = (String) session.getAttribute("sMid");
		
		if(mSw == 0) {	// 메세지 작성하기
			
		}
		else if(mSw == 6) {	// 메세지 내용 상세보기
			WebMessageVO vo = webMessageService.getWmMessageOne(idx, mid, mFlag);
			model.addAttribute("vo", vo);
		}
		else {	// 받은메세지, 새메세지, 보낸메세지, 수신확인, 휴지통
			PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "webMessage", mid, mSw+"");
			List<WebMessageVO> vos = webMessageService.getWmMessageList(mid, mSw, pageVo.getStartIndexNo(), pageSize);

			model.addAttribute("vos", vos);
			model.addAttribute("pageVo", pageVo);
		}
		model.addAttribute("mSw", mSw);
		
		return "webMessage/wmMessage";
	}
}
