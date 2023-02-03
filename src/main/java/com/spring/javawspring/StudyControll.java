package com.spring.javawspring;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.common.ARIAUtil;
import com.spring.javawspring.common.SecurityUtil;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.service.StudyService;
import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.KakaoAddressVO;
import com.spring.javawspring.vo.MailVO;
import com.spring.javawspring.vo.MemberVO;
import com.spring.javawspring.vo.PayMentVO;
import com.spring.javawspring.vo.QrCodeVO;
import com.spring.javawspring.vo.TransactionVO;

@Controller
@RequestMapping("/study")
public class StudyControll {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	
	@RequestMapping(value="/ajax/ajaxMenu", method = RequestMethod.GET)
	public String ajaxMenuGet() {
		return "study/ajax/ajaxMenu";
	}
	
	// 일반 String값의 전달 1(숫자/영문자)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1_1", method=RequestMethod.POST)
	public String ajaxTest1_1Post(int idx) {
		idx = (int)(Math.random()*idx) + 1;
		String res = idx + " : Happy a Good Time!!!";
		return res;
	}
	
	// 일반 String값의 전달 2(숫자/영문자/한글)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1_2", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String ajaxTest1_2Post(int idx) {
		idx = (int)(Math.random()*idx) + 1;
		String res = idx + " : 안녕하세요.... Happy a Good Time!!!";
		return res;
	}
	
	// 일반 배열값의 전달 폼
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/ajaxTest2_1";
	}
	
	// 일반 배열값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
//		String[] strArr = new String[100];
//		strArr = studyService.getCityStringArr(dodo);
//		return strArr;
		return studyService.getCityStringArr(dodo);
	}
	
  // 객체배열(ArrayList)값의 전달 폼
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/ajaxTest2_2";
	}
	
	// 객체배열(ArrayList)값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest2_2Post(String dodo) {
		return studyService.getCityArrayListArr(dodo);
	}
	
	// Map(HashMap<k,v>)값의 전달 폼
	@RequestMapping(value = "/ajax/ajaxTest2_3", method = RequestMethod.GET)
	public String ajaxTest2_3Get() {
		return "study/ajax/ajaxTest2_3";
	}
	
	// Map(HashMap<k,v>)값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest2_3Post(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		vos = studyService.getCityArrayListArr(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	// DB를 활용한 값의 전달 폼
	@RequestMapping(value = "/ajax/ajaxTest3", method=RequestMethod.GET)
	public String ajaxTest3Get() {
		return "study/ajax/ajaxTest3";
	}
	
	// DB를 활용한 값의 전달1(vo)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_1", method=RequestMethod.POST)
	public GuestVO ajaxTest3_1Post(String mid) {
//		GuestVO vo = studyService.getGuestMid(mid);
//		return vo;
		return studyService.getGuestMid(mid);
	}
	
	// DB를 활용한 값의 전달2(vos)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_2", method=RequestMethod.POST)
	public ArrayList<GuestVO> ajaxTest3_2Post(String mid) {
//		ArrayList<GuestVO> vos = studyService.getGuestNames(mid);
//		return vos;
		return studyService.getGuestNames(mid);
	}
	
	// 암호화연습(sha256)
	@RequestMapping(value = "/password/sha256", method = RequestMethod.GET)
	public String sha256Get() {
		return "study/password/sha256";
	}
	
	// 암호화연습(sha256) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/sha256", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String sha256Post(String pwd) {
		String encPwd = SecurityUtil.encryptSHA256(pwd);
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		return pwd;
	}
	
	// 암호화연습(aria)
	@RequestMapping(value = "/password/aria", method = RequestMethod.GET)
	public String ariaGet() {
		return "study/password/aria";
	}
	
	// 암호화연습(sha256) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/aria", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String ariaPost(String pwd) {
		String encPwd = "";
		String decPwd = "";
		try {
			encPwd = ARIAUtil.ariaEncrypt(pwd);		// 암호화
			decPwd = ARIAUtil.ariaDecrypt(encPwd);	// 복호화
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd + " / 복호화된 비밀번호 : " + decPwd;
		return pwd;
	}
	
	// 암호화연습(bCryptPassword) 폼
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.GET)
	public String bCryptPasswordGet() {
		return "study/password/security";
	}
	
	// 암호화연습(bCryptPassword) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd);		// 암호화
		
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	// SMTP 메일 보내기
	// 메일작성 폼
	@RequestMapping(value = "/mail/mailForm", method=RequestMethod.GET)
	public String mailFormGet(Model model, String email) {
		
		ArrayList<MemberVO> vos = memberService.getMemberList(0, 1000, "");
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", vos.size());
		model.addAttribute("email", email);
		
		return "study/mail/mailForm";
	}
	
	// 주소록 호출하기
	
	
	
	// 메일 전송하기
	@RequestMapping(value = "/mail/mailForm", method=RequestMethod.POST)
	public String mailFormPost(MailVO vo, HttpServletRequest request) {
		try {
			String toMail = vo.getToMail();
			String title = vo.getTitle();
			String content = vo.getContent();
			
			// 메일을 전송하기위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
			content = content.replace("\n", "<br/>");
			content += "<br><hr><h3>CJ Green에서 보냅니다.</h3><hr><br>";
			content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen/'>CJ Green프로젝트</a></p>";
			content += "<hr>";
			messageHelper.setText(content, true);
			
			// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다. 그리고, 보관함에 다시 저장시켜준다.
			FileSystemResource file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\main.jpg");
			messageHelper.addInline("main.jpg", file);
			
			// 첨부파일 보내기(서버 파일시스템에 있는 파일)
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\chicago.jpg");
			messageHelper.addAttachment("chicago.jpg", file);
			
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\images.zip");
			messageHelper.addAttachment("images.zip", file);
			
			// file = new FileSystemResource(request.getRealPath("/resources/images/paris.jpg"));
			file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/paris.jpg"));
			messageHelper.addAttachment("paris.jpg", file);
			
			
			// 메일 전송하기
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/mailSendOk";
	}
	
	// UUID 입력폼
	@RequestMapping(value = "/uuid/uuidForm", method=RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
	// UUID 처리하기
	@ResponseBody
	@RequestMapping(value = "/uuid/uuidProcess", method=RequestMethod.POST)
	public String uuidFormPost() {
		UUID uid = UUID.randomUUID();
		return uid.toString();
	}
	
	// 파일 업로드 폼
	@RequestMapping(value = "/fileUpload/fileUploadForm", method = RequestMethod.GET)
	public String fileUploadFormGet() {
		return "study/fileUpload/fileUploadForm";
	}
	
	// 파일 업로드 처리하기
	@RequestMapping(value = "/fileUpload/fileUploadForm", method = RequestMethod.POST)
	public String fileUploadFormPost(MultipartFile fName) {
		int res = studyService.fileUpload(fName);
		if(res == 1) return "redirect:/msg/fileUploadOk";
		else  return "redirect:/msg/fileUploadNo";
	}
	
	// 달력내역 가져오기
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendarGet() {
		studyService.getCalendar();
		return "study/calendar/calendar";
	}
	
	// QR Code 작성 폼
	@RequestMapping(value = "/qrCode", method = RequestMethod.GET)
	public String qrCodeGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "study/qrCode/qrCode";
	}
	
	// QR Code 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String qrCodePost(HttpServletRequest request,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="moveFlag", defaultValue = "", required = false) String moveFlag) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		
		String qrCodeName = studyService.qrCreate(mid, moveFlag, realPath);
		
		return qrCodeName;
	}
	
	// QR Code 생성하기2
	@ResponseBody
	@RequestMapping(value = "/qrCode2", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String qrCode2Post(HttpServletRequest request,
			@RequestParam(name="moveFlag", defaultValue = "", required = false) String moveFlag) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		
		String qrCodeName = studyService.qrCreate2(moveFlag, realPath);
		
		return qrCodeName;
	}
	
	// QR Code 내역 검색하기
	@ResponseBody
	@RequestMapping(value = "/qrCodeSearch", method = RequestMethod.POST)
	public QrCodeVO qrCodeSearchPost(HttpServletRequest request,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx) {
//		QrCodeVO vo = studyService.qrCodeSearch(idx);
//		System.out.println("vo : " + vo);
		return studyService.qrCodeSearch(idx);
	}
	
	// 카카오맵 기본 지도보기
	@RequestMapping(value = "/kakaomap/kakaomap", method = RequestMethod.GET)
	public String kakaomapGet() {
		return "study/kakaomap/kakaomap";
	}
	
	// 카카오맵 '마커표시/DB저장'
	@RequestMapping(value = "/kakaomap/kakaoEx1", method = RequestMethod.GET)
	public String kakaoEx1Get() {
		return "study/kakaomap/kakaoEx1";
	}
	
	// 카카오맵 '마커표시/DB저장'
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoEx1", method = RequestMethod.POST)
	public String kakaoEx1Post(KakaoAddressVO vo) {
		KakaoAddressVO searchVo = studyService.getKakaoAddressName(vo.getAddress());
		if(searchVo != null) return "0";
		studyService.setKakaoAddressName(vo);
		
		return "1";
	}
	
	// 카카오맵 'DB저장된 지역의 검색/삭제'
	@RequestMapping(value = "/kakaomap/kakaoEx2", method = RequestMethod.GET)
	public String kakaoEx2Get(Model model,
			@RequestParam(name="address", defaultValue = "그린컴퓨터", required = false) String address) {
		KakaoAddressVO vo = studyService.getKakaoAddressName(address);
		List<KakaoAddressVO> vos = studyService.getAddressNameList();
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		model.addAttribute("address", address);
		
		return "study/kakaomap/kakaoEx2";
	}
	
	// 선택된 지역을 카카오 DB에서 삭제하기
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoEx2Delete", method = RequestMethod.POST)
	public String kakaoEx2DeletePost(String address) {
		studyService.setKakaoAddressDelete(address);
		
		return "";
	}
	
	// 카카오맵 검색후 '위도/경도/장소명' 알아내어 내DB에 저장하는 폼호출..
	@RequestMapping(value = "/kakaomap/kakaoEx3", method = RequestMethod.GET)
	public String kakaoEx3Get(Model model, 
			@RequestParam(name="address", defaultValue = "", required = false) String address) {
		model.addAttribute("address", address);
		return "study/kakaomap/kakaoEx3";
	}
	
	//	EX5 페이지 이동 뷰
	@RequestMapping(value = "/kakaomap/kakaoEx5", method=RequestMethod.GET)
	public String kakaoEx5Get(Model model) {
		ArrayList<KakaoAddressVO> vos = studyService.getDistanceList();
		
		model.addAttribute("vos",vos);
		
		return "study/kakaomap/kakaoEx5";
	}
	
	// 트랜젝션 연습폼 호출
	@RequestMapping(value = "/transaction/transaction", method = RequestMethod.GET)
	public String transactionGet() {
		return "study/transaction/transaction";
	}
	
	// 트랜젝션 입력1번폼(개별처리)
	@Transactional
	@RequestMapping(value = "/transaction/input1", method = RequestMethod.POST)
	public String transactionInput1Post(TransactionVO vo) {
		studyService.setTransInput1(vo);		// user에 등록
		studyService.setTransInput2(vo);		// user2에 등록
		
		return "study/transaction/transaction";
	}
	
	// 트랜젝션 입력2번폼(일괄처리)
	@RequestMapping(value = "/transaction/input2", method = RequestMethod.POST)
	public String transactionInput2Post(TransactionVO vo) {
		studyService.setTransInput(vo);		// user, user2에 등록
		
		return "study/transaction/transaction";
	}
	
	// 트랜젝션 리스트
	@RequestMapping(value = "/transaction/transactionList", method = RequestMethod.GET)
	public String transactionListGet(Model model) {
		List<TransactionVO> vos = studyService.setTransList();
		model.addAttribute("vos", vos);
		
		return "study/transaction/transactionList";
	}
	
	// 결제 연습하기 폼..
	@RequestMapping(value = "/merchant", method = RequestMethod.GET)
	public String merchantGet() {
		return "study/merchant/merchant";
	}
	
	// 결제창 호출하기
	@RequestMapping(value = "/merchant", method = RequestMethod.POST)
	public String merchantPost(Model model, HttpSession session, PayMentVO vo) {
		session.setAttribute("sPayMentVO", vo);
		model.addAttribute("vo", vo);
		return "study/merchant/sample";
	}
	
	// 결제처리완료창 호출하기
	@RequestMapping(value = "/merchantOk", method = RequestMethod.GET)
	public String merchantOkGet(Model model, HttpSession session) {
		PayMentVO vo = (PayMentVO) session.getAttribute("sPayMentVO");
		model.addAttribute("vo", vo);
		session.removeAttribute("sPayMentVO");
		return "study/merchant/merchantOk";
	}
}
