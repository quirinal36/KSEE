package www.ksee.kr.service;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import www.ksee.kr.dao.UserDAO;

@Service
public class TaskService {
	protected final Logger logger = LoggerFactory.getLogger(getClass());
	final String WINDOWS_OS = "Windows";
	
	@Autowired
	private UserDAO dao;
	/**
	 * 매일 밤 0시 0분 0초에 스케쥴 시작
	 * 
	 * 
	 */
	@Scheduled(cron="0 0 0 * * ?")
	public void RecipeStatusChangeScheduler() {
		// 투표 날짜가 지난 레시피 저장장소
		logger.info("--------------------cron start----------------------------");
		
		final String OSNAME = System.getProperty("os.name");
		if(OSNAME.contains(WINDOWS_OS)) {
			
			String log = "scheduler operated";
			try (BufferedWriter writer = new BufferedWriter(new FileWriter("task_log.txt"))){
				writer.write(log);
				logger.info("log writed");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return;
		}
		
		logger.info("--------------------cron finished-------------------------");
	}
}
