package com.link.service.serviceCenter.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.domain.Notice;
import com.link.service.domain.QandA;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.serviceCenter.ServiceCenterDAO;
import com.link.service.serviceCenter.ServiceCenterService;

@Service("ServiceCenterServiceImpl")
public class ServiceCenterServiceImpl implements ServiceCenterService {

	@Autowired
	@Qualifier("ServiceCenterDAOImpl")
	private ServiceCenterDAO serviceCenterDAO;

	public void setNoticeDAO(ServiceCenterDAO serviceCenterDAO) {
		this.serviceCenterDAO = serviceCenterDAO;
	}

	public ServiceCenterServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("ServiceCenterServiceImpl default Constructor");
	}

	@Override
	public void addNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl insertNotice start]\n");

		serviceCenterDAO.addNotice(notice);
		System.out.println("\n[ServiceCenterServiceImpl insertNotice end]\n");

	}

	@Override
	public Notice getNotice(int noticeNo) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl findNotice start]\n");

		Notice notice = serviceCenterDAO.getNotice(noticeNo);
		System.out.println("\n[ServiceCenterServiceImpl findNotice end]\n");

		return notice;
	}

	@Override
	public void updateNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl updateNoticet start]\n");

		
		  serviceCenterDAO.updateNotice(notice);
		 

		System.out.println("\n[ServiceCenterServiceImpl updateNotice end]\n");

	}

	@Override
	public void getCount(int noticeNo) throws Exception {

		serviceCenterDAO.getCount(noticeNo);
	}

	@Override
	public void deleteNotice(int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		serviceCenterDAO.deleteNotice(noticeNo);
	}

//==================================================================여기까지가 Notice	

	@Override
	public Map<String, Object> getReportList(Search search, Report report, String userId) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl getReportList start]\n");
		int totalCount;
		int a;
		if(userId!="") {
			a = 0;
		}else {
			a = 4;
			}
			totalCount = serviceCenterDAO.getTotalCount(search, a); 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("report", report);
			map.put("userId", userId);
			map.put("search", search);
			map.put("totalCount", totalCount);
			System.out.println("\n[ServiceCenterServiceImpl getReportList end]\n");
			return serviceCenterDAO.getReportList(map);

	}

	@Override
	public Map<String, Object> getQandAList(Search search, QandA qandA) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl getQandAList start]\n");
		int totalCount;
		int a;
		if(search.getOrder()==2) { 
			 a = 1 ;//겟
		}else  {	
			 a = 3;	//포스트
		}
			totalCount = serviceCenterDAO.getTotalCount(search, a); 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("qandA", qandA);
			map.put("search", search);
			map.put("totalCount", totalCount);
			System.out.println("\n[ServiceCenterServiceImpl getQandAList end]\n");
			return serviceCenterDAO.getQandAList(map);
		

	}

	@Override
	public Map<String, Object> getNoticeList(Search search, Notice notice) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl getNoticetList start]\n");
		int a = 2;
		int totalCount = serviceCenterDAO.getTotalCount(search, a); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("notice", notice);
		map.put("totalCount", totalCount);
		System.out.println("\n[ServiceCenterServiceImpl getNoticeList end]\n");
		return serviceCenterDAO.getNoticeList(map);
	}

	// ==================================================================여기까지가 List

	@Override
	public void addQandA(QandA qandA) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl addQandA start]\n");

		serviceCenterDAO.addQandA(qandA);

		System.out.println("\n[ServiceCenterServiceImpl addQandA end]\n");

	}

	@Override
	public QandA getQandA(int qandANo) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl getQandA start]\n");

		QandA qandA = serviceCenterDAO.getQandA(qandANo);

		System.out.println("\n[ServiceCenterServiceImpl getQandA end]\n");

		return qandA;
	}

	@Override
	public void updateQandA(QandA qandA) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[ServiceCenterServiceImpl updateQandA start]\n");


		
			serviceCenterDAO.updateQandA(qandA);
		

		System.out.println("\n[ServiceCenterServiceImpl updateQandA end]\n");

	}

	@Override
	public void deleteQandA(int qandA) throws Exception {
		// TODO Auto-generated method stub
		serviceCenterDAO.deleteQandA(qandA);
	}
	// ==================================================================여기까지가 QandA
	@Override
	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ServiceCenterServiceImpl addReport start]\n");
		
		serviceCenterDAO.addReport(report);
		
		System.out.println("\n[ServiceCenterServiceImpl addReport end]\n");

	}

	@Override
	public Report getReport(int reportNo) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ServiceCenterServiceImpl getReport start]\n");
		
		Report report = serviceCenterDAO.getReport(reportNo);
		
		System.out.println("\n[ServiceCenterServiceImpl getReport end]\n");
		
		return report;
	}

    @Override
    public Report getReportDuple(Report report) throws Exception{
    	
    	System.out.println("\n[ServiceCenterServiceImpl getReportDuple start]\n");
 
    	
    	System.out.println("\n[ServiceCenterServiceImpl getReportDuple end]\n");
    	return	serviceCenterDAO.getReportDuple(report);
    }
    
	@Override
	public void updateReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ServiceCenterServiceImpl updateReport start]\n");

		
			serviceCenterDAO.updateReport(report);

		System.out.println("\n[ServiceCenterServiceImpl updateReport end]\n");

	}
	// ==================================================================여기까지가 Report
	
	
	// ==================================================================여기부터가 Push
	
	@Override
	public void addPush(Report push) throws Exception {
		// TODO Auto-generated method stub
		
		serviceCenterDAO.addPush(push);
		
	}
	
	@Override
	public Map<String, Object> getPushList(User user) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("alarm", serviceCenterDAO.getPushList(user));
		map.put("alarmCount", serviceCenterDAO.getPushListTotalCount(user));
	
		return map;
	}
	
	
	// ==================================================================여기까지가 Push
}
