package MeetWhen.spring.bean;

//���̹� �α��� ���� ����
//���̹�, īī����, ���� �غ���.
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/Naver/")
public class PortalLoginBean {
	
	
	@RequestMapping(value="naverLogin.mw", method=RequestMethod.GET)
	public String naverLogin() {	
		
		
		return "/Naver/naverLogin";
	}
	@RequestMapping(value="naverCallback.mw", method=RequestMethod.GET)
	public String naverCallback(HttpSession session) throws Exception {
		
		return "/Naver/naverCallback";
	}
}
