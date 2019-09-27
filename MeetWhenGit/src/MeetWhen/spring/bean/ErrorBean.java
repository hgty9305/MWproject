package MeetWhen.spring.bean;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Error/")
public class ErrorBean {
	
	@RequestMapping("code404.mw")
	public String code404() {
		return "/Error/code404";
	}
	
	@RequestMapping("code500.mw")
	public String code500() {
		return "/Error/code500";
	}
	
	@RequestMapping("cSoon.mw")
	public String cSoon() {
		return "/Error/cSoon";
	}

}
