package com.link.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.link.service.domain.User;


/*
 * FileName : LogonCheckInterceptor.java
 *  ㅇ Controller 호출전 interceptor 를 통해 선처리/후처리/완료처리를 수행
 *  	- preHandle() : Controller 호출전 선처리   
 * 			(true return ==> Controller 호출 / false return ==> Controller 미호출 ) 
 *  	- postHandle() : Controller 호출 후 후처리
 *    	- afterCompletion() : view 생성후 처리
 *    
 *    ==> 로그인한 회원이면 Controller 호출 : true return
 *    ==> 비 로그인한 회원이면 Controller 미 호출 : false return
 */
//preHandle : controller로 보내기 전에 이벤트 작동
//postHandle : controller로 보내고 난 후 이벤트 작동

@Configuration
public class LogonCheckInterceptor extends HandlerInterceptorAdapter {
	///Field
	
	///Constructor
	@Autowired
	public LogonCheckInterceptor(){
		System.out.println("\nCommon :: " + this.getClass() + "\n");		
	}
	
	///Method
	@Override
	public boolean preHandle(	HttpServletRequest request,
								HttpServletResponse response, Object handler) throws Exception {
		
//		System.out.println("\n[ LogonCheckInterceptor start ]");
		
		// 로그인 유무확인
				HttpSession session = request.getSession(true);
				User user = (User)session.getAttribute("user");

				// 로그인한 회원
				if(user != null && user.getRole().trim().equals("0"))  {
					// 로그인 상태에서 접근 불가 URI
					String uri = request.getRequestURI();
					if(		uri.indexOf("addUserView")		!= -1 		|| 	uri.indexOf("addUser")	!= -1		|| 
							uri.indexOf("loginView")		!= -1 		||	uri.indexOf("login")	!= -1 		|| 
							uri.indexOf("checkDuplication") != -1       ||  uri.indexOf("getUserList") != -1 
						) {	
						
						request.getRequestDispatcher("/").forward(request, response);
//						System.out.println("[ 로그인 상태 - 로그인 후 불필요한 요구 ]");
//						System.out.println("[ LogonCheckInterceptor end ]\n");
						return false;
					}
					
//					System.out.println("[ 로그인 상태 ]");
//					System.out.println("[ LogonCheckInterceptor end ]\n");
					return true;
				}else if(user == null) {
					// 비회원
					// 로그인 시도 중
//					return true;
					String uri = request.getRequestURI();
//					System.out.println(uri);
//					System.out.println("들어가는 URI ");
//					잠시 테스트 중   getUserList 에서 getUser가 있어서 들어갈 수 있음 조심해야됨
					if(		uri.indexOf("addUserView")		!= -1		|| 	uri.indexOf("addUser")		!= -1 		|| 
							uri.indexOf("loginView")		!= -1 		||	uri.indexOf("login") 		!= -1 		|| 
							uri.indexOf("checkDuplication") != -1 		||	uri.indexOf("getMeeting")	!= -1		||
							uri.indexOf("getClubList")	!= -1           ||  uri.indexOf("getUserId")    != -1		||
							uri.indexOf("getPassword")  != -1 || uri.indexOf("snsLogin") !=-1 ||
							uri.indexOf("addSnsUser") != -1
						  )		
					{						
//						System.out.println("[ 로그 시도 상태 .... ]");
//						System.out.println("[ LogonCheckInterceptor end ]\n");
						return true;
					}
					
					request.getRequestDispatcher("/").forward(request, response);
//					System.out.println("[ 로그인 이전 ]"); 
//					System.out.println("[ LogonCheckInterceptor end ]\n");
					return false;
//					return true;
				}
				else {
					//관리자
					return true;
				}
			}
		}//end of class