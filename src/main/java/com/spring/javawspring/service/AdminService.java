package com.spring.javawspring.service;

import java.util.ArrayList;

import com.spring.javawspring.vo.InquiryReplyVO;
import com.spring.javawspring.vo.InquiryVO;
import com.spring.javawspring.vo.QrCodeVO;

public interface AdminService {

	public int setMemberLevelCheck(int idx, int level);

	public ArrayList<QrCodeVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part);

	public InquiryVO getInquiryContent(int idx);

	public void setInquiryInputAdmin(InquiryReplyVO vo);

	public InquiryReplyVO getInquiryReplyContent(int idx);

	public void setInquiryReplyUpdate(InquiryReplyVO reVo);

	public void setInquiryReplyDelete(int reIdx);

	public void setInquiryUpdateAdmin(int inquiryIdx);

	public void setInquiryUpdateAdmin2(int inquiryIdx);
	
}
