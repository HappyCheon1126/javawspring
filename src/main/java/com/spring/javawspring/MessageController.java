package com.spring.javawspring;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="mid", defaultValue = "", required = false) String mid,
			@RequestParam(value="flag", defaultValue = "", required = false) String flag,
			@RequestParam(value="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(value="pag", defaultValue = "1", required = false) int pag) {
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되었습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원 가입 완료!!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "중복된 아이디 입니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberNickNameCheckNo")) {
			model.addAttribute("msg", "중복된 닉네임 입니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberNickNameCheckNo2")) {
			model.addAttribute("msg", "중복된 닉네임 입니다.");
			model.addAttribute("url", "member/memberPwdUpdate");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자가 아니시군요...");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인후 사용하세요");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("levelCheckNo")) {
			model.addAttribute("msg", "등급을 확인하세요");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일을 정상적으로 전송했습니다.");
			model.addAttribute("url", "study/mail/mailForm");
		}
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시비밀번호를 발송하였습니다.\\n메일을 확인하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "아이디와 이메일주소를 확인해 주세요~~");
			model.addAttribute("url", "member/memberPwdSearch");
		}
		else if(msgFlag.equals("memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일이 업로드 실패~~");
			model.addAttribute("url", "study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 틀립니다. 확인해 보세요.");
			model.addAttribute("url", "member/memberPwdUpdate?flag=pwdCheck");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 틀립니다. 확인해 보세요.");
			model.addAttribute("url", "member/memberPwdUpdate?flag=pwdCheck");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 정보가 수정되었습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원 정보 수정실패~~");
			model.addAttribute("url", "member/memberPwdUpdate?flag=pwdCheck");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", mid+"님 회원에서 탈퇴되었습니다.\\n같은 아이디로 1달이내 재가입 하실수 없습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "board/boardInput");
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "board/boardList"+flag);
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url", "board/boardList"+flag);
		}
		else if(msgFlag.equals("pdsInputOk")) {
			model.addAttribute("msg", "자료실에 파일이 업로드 되었습니다.");
			model.addAttribute("url", "pds/pdsList");
		}
		else if(msgFlag.equals("wmMemberIdNo")) {
			model.addAttribute("msg", "가입된 회원이 아닙니다.");
			model.addAttribute("url", "webMessage/webMessage?mSw=0");
		}
		else if(msgFlag.equals("wmInputOk")) {
			model.addAttribute("msg", "메세지 전송 완료!!!");
			model.addAttribute("url", "webMessage/webMessage?mSw=1");
		}
		else if(msgFlag.equals("wmDeleteAll")) {
			model.addAttribute("msg", "휴지통을 모두 비웠습니다.");
			model.addAttribute("url", "webMessage/webMessage?mSw=1");
		}
		else if(msgFlag.equals("dbProductInputOk")) {
			model.addAttribute("msg", "신규 상품이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbShopList");
		}
		else if(msgFlag.equals("dbOptionInputOk")) {
			model.addAttribute("msg", "옵션 항목이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbOption");
		}
		else if(msgFlag.equals("dbOptionInput2Ok")) {
			model.addAttribute("msg", "옵션 항목이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbOption2?productName="+flag);
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "dbShop/dbCartList");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "dbShop/dbProductList");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "dbShop/dbProductList");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 정상적으로 완료되었습니다.");
			model.addAttribute("url", "dbShop/paymentResultOk");
		}
		else if(msgFlag.equals("thumbnailCreateOk")) {
			model.addAttribute("msg", "썸네일 이미지가 저장되었습니다.");
			model.addAttribute("url", "study/thumbnailResult");
		}
		else if(msgFlag.equals("notifyInputOk")) {
			model.addAttribute("msg", "공지사항이 저장되었습니다.");
			model.addAttribute("url", "notify/notifyList");
		}
		else if(msgFlag.equals("notifyUpdateOk")) {
			model.addAttribute("msg", "공지사항이 수정되었습니다.");
			model.addAttribute("url", "notify/notifyList");
		}
		else if(msgFlag.equals("midSameSearch")) {
			model.addAttribute("msg", "같은 아이디가 존재하기에 로그인할 수 없습니다.\\n신규회원 가입후 로그인하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("midSameSearch")) {
			model.addAttribute("msg", "같은 아이디가 존재하기에 로그인할 수 없습니다.\\n신규회원 가입후 로그인하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("msg", "1:1 문의사항이 등록되었습니다.");
			model.addAttribute("url", "inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryUpdateOk")) {
			model.addAttribute("msg", "1:1 문의사항이 수정되었습니다.");
			model.addAttribute("url", "inquiry/inquiryView?idx="+idx);
		}
		else if(msgFlag.equals("inquiryDeleteOk")) {
			model.addAttribute("msg", "1:1 문의사항이 삭제되었습니다.");
			model.addAttribute("url", "inquiry/inquiryList?pag="+pag);
		}
		else if(msgFlag.equals("adInquiryDeleteOk")) {
			model.addAttribute("msg", "1:1 문의글과 답변글이 삭제되었습니다.");
			model.addAttribute("url", "admin/adInquiryList?pag="+pag);
		}

		
		
		return "include/message";
	}
}
