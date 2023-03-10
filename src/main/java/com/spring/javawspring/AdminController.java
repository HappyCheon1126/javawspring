package com.spring.javawspring;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.AdminService;
import com.spring.javawspring.service.InquiryService;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.vo.InquiryReplyVO;
import com.spring.javawspring.vo.InquiryVO;
import com.spring.javawspring.vo.MemberVO;
import com.spring.javawspring.vo.QrCodeVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	InquiryService inquiryService;
	
	
	@RequestMapping(value = "/adminMain", method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adminLeft", method=RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value = "/adminContent", method=RequestMethod.GET)
	public String adminContentGet() {
		return "admin/adminContent";
	}
	
	@RequestMapping(value = "/member/adminMemberList", method = RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "member", "", mid);
		
		List<MemberVO> vos = memberService.getMemberList(pageVo.getStartIndexNo(), pageSize, mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		
		model.addAttribute("mid", mid);
		
		return "admin/member/adminMemberList";
	}
	
	// ?????? ?????? ????????????
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberLevel", method = RequestMethod.POST)
	public String adminMemberLevelPost(int idx, int level) {
		int res = adminService.setMemberLevelCheck(idx, level);
		return res+"";
	}
	
	// ckeditor????????? ?????? ????????? ????????????
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/file/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/file/fileList";
	}
	
	// ????????? ?????? ??????????????????
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/fileSelectDelete", method = RequestMethod.POST)
	public String fileSelectDeleteGet(HttpServletRequest request, String delItems) {
		// System.out.println("delItems : " + delItems);
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] fileNames = delItems.split("/");
		
		for(String fileName : fileNames) {
			String realPathFile = realPath + fileName;
			new File(realPathFile).delete();
		}
		
		return "1";
	}
	
  // ????????? 1:1 ????????? ????????????
	@RequestMapping(value="/adInquiryList", method = RequestMethod.GET)
	public String adInquiryListGet(
			@RequestParam(name="part", defaultValue="??????", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminInquiry", part, "");
		
    ArrayList<QrCodeVO> vos = adminService.getInquiryListAdmin(pageVo.getStartIndexNo(), pageSize, part);
    
    model.addAttribute("vos", vos);
	  model.addAttribute("pageVo", pageVo);
	  model.addAttribute("part", part);
		
		return "admin/inquiry/adInquiryList";
	}
	
	// ????????? ???????????? ??? ????????????(???????????? ????????? ??????/??????????????????????????? ?????? ???????????? ??????.)
	@RequestMapping(value="/adInquiryReply", method = RequestMethod.GET)
	public String adInquiryReplyGet(int idx,
			@RequestParam(name="part", defaultValue="??????", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model) {
		InquiryVO vo = adminService.getInquiryContent(idx);
		InquiryReplyVO reVo = adminService.getInquiryReplyContent(idx);
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("vo", vo);
		model.addAttribute("reVo", reVo);
		return "admin/inquiry/adInquiryReply";
	}
	
	// ????????? ???????????? ????????????
	@ResponseBody
	@RequestMapping(value="/adInquiryReplyInput", method = RequestMethod.POST)
	public String adInquiryReplyInputPost(InquiryReplyVO vo, Model model) {
		adminService.setInquiryInputAdmin(vo);
		adminService.setInquiryUpdateAdmin(vo.getInquiryIdx());
		
		return "admin/inquiry/adInquiryReply";
	}
	
	// ????????? ????????? ????????????
	@ResponseBody
	@RequestMapping(value="/adInquiryReplyUpdate", method = RequestMethod.POST)
	public String adInquiryReplyUpdatePost(InquiryReplyVO reVo) {
		adminService.setInquiryReplyUpdate(reVo);	// ???????????? ???????????? ??????????????? ????????????
		return "";
	}
	
	// ????????? ????????? ????????????
	@ResponseBody
	@RequestMapping(value="/adInquiryReplyDelete", method = RequestMethod.POST)
	public String adInquiryReplyDeletePost(int reIdx, int inquiryIdx) {
		adminService.setInquiryReplyDelete(reIdx);	// ???????????? ???????????? ??????????????? ????????????
		adminService.setInquiryUpdateAdmin2(inquiryIdx);
		return "";
	}
	
	// ????????? ???????????? ????????? ????????????
	@RequestMapping(value="/adInquiryDelete", method = RequestMethod.GET)
	public String adInquiryDeleteGet(Model model, int idx, String fSName, int reIdx, int pag) {
		adminService.setInquiryReplyDelete(reIdx);	// ???????????? ???????????? ??????????????? ????????????
		inquiryService.setInquiryDelete(idx, fSName);
		model.addAttribute("pag", pag);
		return "redirect:/msg/adInquiryDeleteOk";
	}
	
}
