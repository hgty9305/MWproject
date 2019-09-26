package MeetWhen.spring.bean;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Boots/")
public class BootsBean {
	
	@RequestMapping("boots_original.mw")  //BootStrap ����
	public String boots_original() {
		return "/Boots/boots_original";
	}
	@RequestMapping("boots_form.mw")  //���� form
	public String boots_form() {
		return "/Boots/boots_form";
	}
	
	@RequestMapping("boots_menubar.mw")  //���� header
	public String boots_menubar() {
		return "/Boots/boots_menubar";
	}
	
	@RequestMapping("boots_footer.mw")  //���� footer
	public String boots_footer() {
		return "/Boots/boots_footer";
	}
}