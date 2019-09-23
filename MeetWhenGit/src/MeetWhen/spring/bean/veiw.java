package MeetWhen.spring.bean;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class veiw {
	@RequestMapping("boots_menubar.mw")
	public String boots_menubar() {
		return "/boots_menubar";
	}
	@RequestMapping("boots_footer.mw")
	public String boots_footer() {
		return "/boots_footer";
	}
	

}
