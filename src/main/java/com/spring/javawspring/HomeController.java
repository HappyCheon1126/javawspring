package com.spring.javawspring;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.service.NotifyService;
import com.spring.javawspring.vo.NotifyVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	NotifyService notifyService;
	
	@RequestMapping(value = {"/","/h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		// 첫화면에 공지사항 팝업으로 띄우기
		List<NotifyVO> popupVos = notifyService.getNotifyPopup();
		model.addAttribute("popupVos", popupVos);
		
		return "home";
	}
	
	@RequestMapping("/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린(전송) 파일을, 서버 파일시스템에 실제로 저장할 경로를 결정한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream os = new FileOutputStream(new File(realPath + oFileName));
		os.write(bytes);
		
		// 서버 파일시스템에 저장되어 있는 파일을 브라우저 편집 화면에 보여주기 위한 작업
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
    
		out.flush();
		os.close();
	}
	
	@RequestMapping(value = "/webSocket", method = RequestMethod.GET)
	public String webSocketGet(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "webSocket/webSocket";
	}
	
	@RequestMapping(value = "/webSocket/chat", method = RequestMethod.GET)
	public String chatGet(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "webSocket/chat";
	}
	
	@RequestMapping(value = "/webSocketDb", method = RequestMethod.GET)
	public String webSocketDbGet(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "webSocket/webSocketDb";
	}
	
}
