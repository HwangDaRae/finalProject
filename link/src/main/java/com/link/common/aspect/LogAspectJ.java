package com.link.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public class LogAspectJ {

	public LogAspectJ() {
		// TODO Auto-generated constructor stub
		System.out.println("\nCommon :: " + this.getClass() + "\n");
	}

	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable{
		
		System.out.println("[Around before] : "
				+ joinPoint.getTarget().getClass().getName() + "." 
				+ joinPoint.getSignature().getName());
		
		if(joinPoint.getArgs().length != 0) {
			for(int i = 0 ; i < joinPoint.getArgs().length ; i++) {
				System.out.println("[Around before] : " + joinPoint.getArgs()[i]);
			}
		}
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] : " + obj);
		System.out.println("");
		
		return obj;
	}
}
