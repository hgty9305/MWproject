package MeetWhen.spring.bean;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Member/")
public class MemberBean {
	
	@RequestMapping("join.mw")
	public String join() {
		
		return "/Member/join";
	}
}
