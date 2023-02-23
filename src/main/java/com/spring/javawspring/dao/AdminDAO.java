package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.InquiryReplyVO;
import com.spring.javawspring.vo.InquiryVO;
import com.spring.javawspring.vo.QrCodeVO;

public interface AdminDAO {

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int level);

	public ArrayList<QrCodeVO> getInquiryListAdmin(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public InquiryVO getInquiryContent(@Param("idx") int idx);

	public void setInquiryInputAdmin(@Param("vo") InquiryReplyVO vo);

	public InquiryReplyVO getInquiryReplyContent(@Param("idx") int idx);

	public void setInquiryReplyUpdate(@Param("reVo") InquiryReplyVO reVo);

	public void setInquiryReplyDelete(@Param("reIdx") int reIdx);

	public void setInquiryUpdateAdmin(@Param("inquiryIdx") int inquiryIdx);

	public int totRecCntAdmin(@Param("part") String part);

	public void setInquiryUpdateAdmin2(@Param("inquiryIdx") int inquiryIdx);
	
}
