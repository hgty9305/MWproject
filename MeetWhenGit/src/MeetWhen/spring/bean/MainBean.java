package MeetWhen.spring.bean;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Main/")
public class MainBean {
	
	@RequestMapping("boots_original.mw")  //BootStrap ����
	public String boots_original() {
		return "/Main/boots_original";
	}
	@RequestMapping("boots_form.mw")  //���� form
	public String boots_form() {
		return "/Main/boots_form";
	}
	
	@RequestMapping("boots_menubar.mw")  //���� header
	public String boots_menubar() {
		return "/Main/boots_menubar";
	}
	
	@RequestMapping("boots_footer.mw")  //���� footer
	public String boots_footer() {
		return "/Main/boots_footer";
	}
	
	@RequestMapping("main.mw")  //���� ȭ��
	public String main() {
		return "/Main/main";
	}
}