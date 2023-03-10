package com.spring.javawspring.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawspring.dao.AdminDAO;
import com.spring.javawspring.dao.BoardDAO;
import com.spring.javawspring.dao.DbShopDAO;
import com.spring.javawspring.dao.GuestDAO;
import com.spring.javawspring.dao.InquiryDAO;
import com.spring.javawspring.dao.MemberDAO;
import com.spring.javawspring.dao.PdsDAO;
import com.spring.javawspring.dao.WebMessageDAO;

@Service
public class PageProcess {
	@Autowired
	GuestDAO guestDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	PdsDAO pdsDAO;
	
	@Autowired
	WebMessageDAO webMessageDAO;
	
	@Autowired
	DbShopDAO dbShopDAO;
	
	@Autowired
	InquiryDAO inquiryDAO;
	
	@Autowired
	AdminDAO adminDAO;

	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("member")) {
			totRecCnt = memberDAO.totRecCnt(searchString);
		}
		else if(section.equals("guest")) {
			totRecCnt = guestDAO.totRecCnt();
		}
		else if(section.equals("board")) {
			totRecCnt = boardDAO.totRecCnt();
		}
		else if(section.equals("pds")) {
			totRecCnt = pdsDAO.totRecCnt(part);
		}
		else if(section.equals("webMessage")) {
			String mid = part;
			int mSw = Integer.parseInt(searchString);
			totRecCnt = webMessageDAO.totRecCnt(mid, mSw);
		}
		else if(section.equals("dbMyOrder")) {
			String mid = part;
			totRecCnt = dbShopDAO.totRecCnt(mid);
		}
		else if(section.equals("myOrderStatus")) {
			String mid = part;
			// searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
			String[] searchStringArr = searchString.split("@");
			totRecCnt = dbShopDAO.totRecCntMyOrderStatus(mid,searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("adminDbOrderProcess")) {
			String[] searchStringArr = searchString.split("@");
			totRecCnt = dbShopDAO.totRecCntAdminStatus(searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("inquiry")) {
			totRecCnt = inquiryDAO.totRecCnt(part, searchString);
		}
		else if(section.equals("adminInquiry")) {
			totRecCnt = adminDAO.totRecCntAdmin(part);
		}
		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
}
