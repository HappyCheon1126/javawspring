package com.spring.javawspring.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.ChartVO;
import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.KakaoAddressVO;
import com.spring.javawspring.vo.QrCodeVO;
import com.spring.javawspring.vo.TransactionVO;

public interface StudyDAO {

	public GuestVO getGuestMid(@Param("name") String mid);

	public ArrayList<GuestVO> getGuestNames(@Param("name") String mid);

	public void setQrCreateDB(@Param("idx") String idx, @Param("qrCode") String qrCode, @Param("bigo") String bigo);

	public QrCodeVO qrCodeSearch(@Param("idx") String idx);

	public KakaoAddressVO getKakaoAddressName(@Param("address") String address);

	public void setKakaoAddressName(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getAddressNameList();

	public void setKakaoAddressDelete(@Param("address") String address);

	public ArrayList<KakaoAddressVO> getKakaoList();

	public void setTransInput1(@Param("vo") TransactionVO vo);

	public void setTransInput2(@Param("vo") TransactionVO vo);

	public List<TransactionVO> setTransList();

	public void setTransInput(@Param("vo") TransactionVO vo);

	public List<ChartVO> getRecentlyVisitCount(@Param("i") int i);

}
