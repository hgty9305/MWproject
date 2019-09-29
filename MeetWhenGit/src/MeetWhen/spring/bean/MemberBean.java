package MeetWhen.spring.bean;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import MeetWhen.spring.bean.GeoPoint;
import MeetWhen.spring.bean.GeoTrans;
import MeetWhen.vo.bri.MWAddressVO;
import MeetWhen.vo.bri.MWFriendVO;
import MeetWhen.vo.bri.MWMemberVO;


@Controller
@RequestMapping("/Member/")
public class MemberBean {

	@Autowired
	private SqlSessionTemplate sql = null;

	@Autowired
	HttpSession session;
	@RequestMapping("join.mw")
	public String join() {
		return "Member/join";
	}
	@RequestMapping(value = "joinPro.mw", method = RequestMethod.POST)
	public String joinPro(MultipartHttpServletRequest request, String m_name, String m_id, String m_email_1,
			String m_email_2, String m_pw,Model model) {
		try {
			
			Random rd = new Random();
			String m_serialnumber = Integer.toString(rd.nextInt(9998)); //회원고유번호 생성 후 스트링으로 변환
			MultipartFile mf = request.getFile("m_profile_img"); 	//type ="file"의 name값으로 파라미터?받음
			String path = request.getRealPath("img");				//절대경로  path에 저장
			String org = mf.getOriginalFilename();					//파일의 원래 이름
			String ext="";											//원래이름에서 확장자명을 뺸 변수
			String img="";											//회원아이디로 중복되는 파일이름을 갖지않게함
			String newName ="";										//디비에 등록되는 파일명
			File f= null;											
			
			MWMemberVO vo = new MWMemberVO();
			
			newName = "default.png";
			vo.setM_profile_img(newName);
			
			if(!mf.equals(null)){									//업로드할 파일을 선택했을때
				ext = org.substring(org.lastIndexOf("."));
				img = m_id + ext;
				sql.insert("memberSQL.filenumsequence");
				
				int num = sql.selectOne("memberSQL.filemaxnum");	//DB테이블에 있는 가장 높은 num을 가져옴
				
				newName = "image" + num + ext;						
				f = new File(path + "//" + newName);
				mf.transferTo(f);									//업로드
				vo.setM_profile_img(newName);
			} 
			
			String m_email = m_email_1 + m_email_2;					// 1: 회원 이메일  2: 검색엔진 (google, daum..)
			vo.setM_name(m_name);
			vo.setM_id(m_id);
			vo.setM_pw(m_pw);
			vo.setM_email(m_email);
			vo.setM_serialnumber(m_serialnumber);
			vo.setRegistrationdate(new Timestamp(System.currentTimeMillis()));
			sql.insert("memberSQL.signup", vo);						//회원정보를 DB에 삽입
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Main/main";
	}
	@RequestMapping("confirmId.mw")
	public String MemberConfirmId(String m_id, Model model) {
		int check = (Integer) sql.selectOne("memberSQL.confirmId", m_id);
		model.addAttribute("confirm", check);
		model.addAttribute("m_id", m_id);
		return "Member/confirmId";
	}
	@RequestMapping("login.mw")
	public String login() {
		String result="";
		if (session.getAttribute("loginUser") == null) 
			result="Member/login";
		else 
			result="Main/main";
		return result;
	}
	@RequestMapping("loginPro.mw")
	public String loginPro(@RequestParam Map<String, String> paramMap, Model model, MWMemberVO vo) {
		String returnPage = "Member/login";
		boolean loginState = true;
		String userId = paramMap.get("m_id");
		String userPw = paramMap.get("m_pw");

		try {
			vo.setM_id(userId);
			vo.setM_pw(userPw);
			MWMemberVO User = (MWMemberVO) sql.selectOne("memberSQL.loginPro", vo);
			if (User == null) {
				loginState = false;
				session.setAttribute("loginUser", null); // 받는값없으면 세션에 null대입
			} else {
				loginState = true;
				session.setAttribute("loginUser", User.getM_id());
				returnPage = "Main/main"; // 로그인 성공시 메인페이지로 이동
			}
			model.addAttribute("loginState", loginState);
		} catch (Exception ex) {
			model.addAttribute("loginState", loginState);
			ex.printStackTrace();
		}
		return returnPage;
	}

	@RequestMapping("logOut.mw")
	public String logOut() {
		session.invalidate();
		return "Member/login";
	}
	

	@RequestMapping("boots_calendar.mw")// 삭제해야하는 건가?_ksm
	public String Calendar() {
		return "/Member/boots_calendar";
	}

	@RequestMapping("mapOnView.mw")
	public String mapOnView() {

		return "/Member/mapOnView";
	}

	@RequestMapping("editInfo.mw")
	public String editInfo(HttpServletRequest request) throws UnsupportedEncodingException {

		return "/Member/editInfo";
	}

	@RequestMapping("regitPlace.mw")
	public String regitPlace() {

		return "/Member/regitPlace";
	}

	@RequestMapping("regitPlacePro.mw")
	public String regitPlacePro(HttpSession session, HttpServletRequest request, MWAddressVO avo, int addressTarget,
			String confmKey, String zipNo, String roadAddrPart1, String addrDetail, String roadAddrPart2, String entX,
			String entY, Double x, Double y) {		
		String m_id = (String) session.getAttribute("loginUser");		//sql문 조건에 들어갈 회원아이디
		String empty = "empty";											//주소1에 값을 삽일할떄 주소2,3에 String = "empty"를 넣음
		
		int postal_code = Integer.parseInt(zipNo);						//파라미터로 받은 우편번호 int로 변환
		
		x = Double.parseDouble(entX); 									//평면도 x
		y = Double.parseDouble(entY); 									//평면도 y

	    GeoPoint pt1 = new GeoPoint(x, y);
	    GeoPoint tm_pt = GeoTrans.convert(GeoTrans.UTMK, GeoTrans.GEO, pt1); //평면도(UTMK)를 위도,경도(GEO) 값으로 변환 
										
		String ylat = String.format("%.7f", tm_pt.x);						//소수점 7자리까지의 위,경도를 문자로 변환
		String xlat = String.format("%.7f", tm_pt.y);

		avo.setLat1(xlat);
		avo.setLong1(ylat);
		String address1 = "";
		String address2 = "";
		String address3 = "";

		avo.setM_id(m_id);
		avo.setPostal_code(postal_code);
		avo.setAddress2(empty);
		avo.setAddress3(empty);
		avo.setLat2(empty);
		avo.setLong2(empty);
		avo.setLat3(empty);
		avo.setLong3(empty);
		avo.setStatus(1);
		
		if (addressTarget == 1) {
			address1 = roadAddrPart1 + addrDetail + " " + roadAddrPart2;
			avo.setAddress1(address1);
		} else if (addressTarget == 2) {
			address2 = roadAddrPart1 + addrDetail + " " + roadAddrPart2;
			avo.setAddress2(address2);
			avo.setLat2(xlat);
			avo.setLong2(ylat);
		} else if(addressTarget == 3) {
			address3 = roadAddrPart1 + addrDetail + " " + roadAddrPart2;
			avo.setAddress3(address3);
			avo.setLat3(xlat);
			avo.setLong3(ylat);
		}		
		int check1 = (int)sql.selectOne("address.searchAdd1",m_id);
		String check2 = sql.selectOne("address.searchAdd2",m_id);	
		String check3 = sql.selectOne("address.searchAdd3",m_id);	
		if(addressTarget==1&&check1==0) {
			sql.insert("address.insertadd1", avo);
		}
		
		if(addressTarget==1&&check1==1) {
				sql.update("address.updateAdd1", avo);
		}
		if(addressTarget==2&&check1==1&&!check2.equals(null)) {
				sql.update("address.updateAdd2", avo);
		}
		if(addressTarget==3&&check1==1&&!check2.equals(null)&&!check3.equals(null)) {
				sql.update("address.updateAdd3", avo);
		}
		return "/Member/regitPlacePro";
	}

	@RequestMapping("jusoPopup.mw")
	public String JusoPopup() {
		return "/Member/jusoPopup";
	}

	@RequestMapping("selectPlace.mw")
	public String selectPlace(Model model, HttpSession session) {
		String m_id = (String) session.getAttribute("loginUser");

		String returnPage = "/Member/selectPlace";
		try {
			MWAddressVO vo = (MWAddressVO) sql.selectOne("address.selectPlace", m_id);
			
			model.addAttribute("addressInfo", vo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return returnPage;
	}
	@RequestMapping("currentPostion.mw")
	public String currentPostion(HttpSession session,Model model,MWAddressVO addressInfo,String id) {
		String m_id = (String)session.getAttribute("loginUser"); 
		
		MWAddressVO avo =(MWAddressVO)sql.selectOne("address.getOnesdata", m_id);
		
		if(Integer.parseInt(id)==1) {
			
		}
		if(Integer.parseInt(id)==2) {
			
		}
		if(Integer.parseInt(id)==3) {
			
		}
		
		model.addAttribute("getAddInfo", avo);
		model.addAttribute("addressInfo",addressInfo);
		
		
		return "currentPostion";
	}
	@RequestMapping("addFriends.mw")
	public String addFriends (HttpSession session, String SearchId, Model model,String searchFromAll) {
			String m_id = (String)session.getAttribute("loginUser");
	    try {

			List<MWFriendVO> flist= sql.selectList("memberSQL.frilist", m_id); 
			int listCount = (int)sql.selectOne("memberSQL.countfrilist", m_id);
			
			model.addAttribute("friendList", flist); 
			model.addAttribute("CntfriendList", listCount);
			
	    } catch(Exception e) {e.printStackTrace();}

		return "/Member/addFriends";
	}
	@RequestMapping("searchFriends.mw")
	public String searchFriends(){
		
		return "/Member/searchFriends";
	}
	
	@RequestMapping("Sfri.mw")
	@ResponseBody
	public List Sfri(Model model, String searchFromAll){
		List<MWMemberVO> Slist = null;
		System.out.print(searchFromAll);
		String m_id = (String)session.getAttribute("loginUser");
		try {
    	Map<String, String> map = new HashMap<String, String>();
   	 
    	map.put("searchFromAll", searchFromAll);
    	map.put("m_id", m_id);
    	System.out.println(map.get("searchFromAll"));
    	System.out.println(map.get("m_id"));
    	
      	int count = (int)sql.selectOne("memberSQL.memberSearchCnt", map);
    	System.out.println("寃��깋寃곌낵 媛��닔 :" + count);
    	 Slist = sql.selectList("memberSQL.memberSearch", map);
    	
    	System.out.println("寃��깋 寃곗쥖 泥ル쾲吏�  �냸 : " + Slist.get(0).getM_id());
    	System.out.println("寃��깋 寃곗쥖 2踰덉㎏  �냸 : " + Slist.get(1).getM_id());
    	model.addAttribute("slist", Slist);
    	
    	if(count !=0) {
    	model.addAttribute("cntFrnd", count);
    	}
    	else if(count==0) {
    		String NResult = "寃��깋寃곌낵 �뾾�쓬";
    		model.addAttribute("NR", NResult);
    	}
		}catch(Exception e){e.printStackTrace();}
		return Slist;
	}
	
	@RequestMapping("searchResult.mw")
	public String searchResult(Model model, String searchFromAll){

		List<MWMemberVO> Slist = null;
		String m_id = (String)session.getAttribute("loginUser");
		try {
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("searchFromAll", searchFromAll);
    	map.put("m_id", m_id);
    	
      	int count = (int)sql.selectOne("memberSQL.memberSearchCnt", map); //검색 결과 갯수
    	Slist = sql.selectList("memberSQL.memberSearch", map);
    	model.addAttribute("slist", Slist);
    	if(count !=0) {
    	model.addAttribute("cntFrnd", count);
    	}
    	else if(count==0) {
    		String NResult = "결과값이 없습니다.";
    		model.addAttribute("NR", NResult);
    	}
		}catch(Exception e){e.printStackTrace();}
		return "/Member/searchResult";
	}
	
	@RequestMapping("/searchFriendsPop")
	public String searchFriendsPop() {
		
		return"/Member/searchFriendsPop";
	}
	@RequestMapping("/position")
	public String Postion(HttpSession session, Model model) {
		String id = (String)session.getAttribute("loginUser");
		
		String a = "user1";
		String b = "user2";
		String c = "user3";
		MWAddressVO vo1 = sql.selectOne("memberSQL.getAdress", a);
		MWAddressVO vo2 = sql.selectOne("memberSQL.getAdress", b);
		MWAddressVO vo3 = sql.selectOne("memberSQL.getAdress", c);
		
		model.addAttribute("user1", vo1);
		model.addAttribute("user2", vo2);
		model.addAttribute("user3", vo3);
		return "/Member/position";
	}
	//마이페이지 -----------------------------------------------------------------------
	@RequestMapping("myPage.mw")
	public String myPage(HttpSession session, HttpServletRequest request) {
		String id = (String) session.getAttribute("loginUser");

		MWMemberVO ls = sql.selectOne("memberSQL.getMyinfo", id);

		request.setAttribute("vo", ls);

		return "/MyPage/myPage";
	}
	
	@RequestMapping("myInfo.mw")
	public String myInfo(HttpSession session, HttpServletRequest request) {
		String id = (String) session.getAttribute("loginUser");

		MWMemberVO ls = sql.selectOne("memberSQL.getMyinfo", id);

		request.setAttribute("vo", ls);

		return "/MyPage/myInfo";
	}
	
	
	@RequestMapping("modify.mw")
	public String modify(HttpServletRequest request, HttpSession session) {
		String id=(String)session.getAttribute("loginUser");
		
		MWMemberVO vo = sql.selectOne("memberSQL.getMyinfo", id);
		request.setAttribute("vo",vo);
		
		return"/MyPage/modify";
	}
	@RequestMapping("modifyPro.mw")
	public String modifyPro(MultipartHttpServletRequest request,
					HttpSession session, String email, String passwd) {
		//이미지 처리
		String id = (String) session.getAttribute("loginUser");
		MWMemberVO orgVo = sql.selectOne("memberSQL.getMyinfo", id);
		
		MWMemberVO vo = new MWMemberVO();
		//이미지 
		vo.setM_name(orgVo.getM_name());
		vo.setM_id(orgVo.getM_id());
		vo.setM_pw(passwd);
		vo.setM_email(email);
		vo.setM_serialnumber(orgVo.getM_serialnumber());
		vo.setRegistrationdate(orgVo.getRegistrationdate());
		//vo로 가능한지 모르겟움..
		//sql.update("member.modifyInfo",vo);
		return"/MyPage/modifyPro";
	}
	
	@RequestMapping("delete.mw")
	public String delete() {
		return"/MyPage/delete";
	}
	@RequestMapping("deletePro.mw")
	public String deletePro(HttpSession session, String passwd, Model model) {
		String id = (String)session.getAttribute("loginUser");
		MWMemberVO vo = new MWMemberVO();
		vo.setM_id(id);
		vo.setM_pw(passwd);
		
		int check = (Integer)sql.selectOne("memberSQL.confirmUser",vo);
		if(check==1) {
			System.out.println("탈퇴성공");
			sql.delete("memberSQL.deleteMember",id);
			session.invalidate();
			model.addAttribute("check",check);
		}		
		return"/MyPage/deletePro";
	}


	
	
}
