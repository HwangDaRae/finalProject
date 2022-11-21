package com.link.service.serviceCenter;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.Notice;
import com.link.service.domain.QandA;
import com.link.service.domain.Report;
import com.link.service.domain.User;

public interface ServiceCenterDAO {

	public void addNotice(Notice notice) throws Exception;
	
	public Notice getNotice(int noticeNo) throws Exception;
	
	public void updateNotice(Notice notice) throws Exception;
	
	public void getCount(int noticeNo) throws Exception;
	
	public void deleteNotice(int noticeNo) throws Exception;
	
	//==여기까지가 공지사항 Notice ==//
	
	public Map<String, Object> getNoticeList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getReportList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getQandAList(Map<String, Object> map) throws Exception;
	
	//List 들
	
	public void addQandA(QandA qandA) throws Exception;
	
	public QandA getQandA(int qandANo) throws Exception;
	
	public void updateQandA(QandA qandA) throws Exception;
	
	public void deleteQandA(int qandA) throws Exception;
	
	//==여기까지가 큐엔에이 QandA ==//
	
	public void addReport(Report report) throws Exception;
	
	public Report getReport(int reportNo) throws Exception;
	
	public void updateReport(Report report) throws Exception;
	
	public Report getReportDuple(Report report) throws Exception;
	
	//공통 메써드 
	
	public int getTotalCount(Search search, int a) throws Exception;

	
	// ==================================================================여기부터가 Push
	
	public void addPush(Report push) throws Exception;

	public List<Report> getPushList(User user) throws Exception;
	
	public int getPushListTotalCount(User user) throws Exception;
		
	// ==================================================================여기까지가 Push
	
}
