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

//	@RequestMapping("main.mw")
//	public String MemberMain(HttpServletRequest request) throws UnsupportedEncodingException {
//		   String clientId = "IFQYtQGmVdD6mqkfDGew";//�븷�뵆由ъ��씠�뀡 �겢�씪�씠�뼵�듃 �븘�씠�뵒媛�";
//		    String clientSecret = "co1qBbOgUD";//�븷�뵆由ъ��씠�뀡 �겢�씪�씠�뼵�듃 �떆�겕由욧컪";
//		    String code = request.getParameter("code");
//		    String state = request.getParameter("state");
//		    String redirectURI = URLEncoder.encode("http://localhost:8080/MeetWhen/member/main.mw", "UTF-8");
//		    String apiURL;
//		    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
//		    apiURL += "client_id=" + clientId;
//		    apiURL += "&client_secret=" + clientSecret;
//		    apiURL += "&redirect_uri=" + redirectURI;
//		    apiURL += "&code=" + code;
//		    apiURL += "&state=" + state;
//		    String access_token = "";
//		    String refresh_token = "";
//		    System.out.println("apiURL="+apiURL);
//		    try {
//		      URL url = new URL(apiURL);
//		      HttpURLConnection con = (HttpURLConnection)url.openConnection();
//		      con.setRequestMethod("GET");
//		      int responseCode = con.getResponseCode();
//		      BufferedReader br;
//		      System.out.print("responseCode="+responseCode);
//		      if(responseCode==200) { // �젙�긽 �샇異�
//		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//		      } else {  // �뿉�윭 諛쒖깮
//		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//		      }
//		      String inputLine;
//		      StringBuffer res = new StringBuffer();
//		      while ((inputLine = br.readLine()) != null) {
//		        res.append(inputLine);
//		      }
//		      br.close();
//		      if(responseCode==200) {
//		        System.out.println(res.toString());
//		      }
//		    } catch (Exception e) {
//		      System.out.println(e);
//		    }
//		return "/Member/main";	
//	}
	@RequestMapping("join.mw")
	public String join() {
		return "Member/join";
	}
	@RequestMapping(value = "joinPro.mw", method = RequestMethod.POST)
	public String joinPro(MultipartHttpServletRequest request, String m_name, String m_id, String m_email_1,
			String m_email_2, String m_pw,Model model) {
		try {
			// �쉶�썝怨좎쑀踰덊샇 @@@@@@@@@@@@@@@@@@@@寃뱀튂�뒗 踰덊샇 諛⑹�肄붾뱶 異붽��삁�젙
			Random rd = new Random();
			String m_serialnumber = Integer.toString(rd.nextInt(9998));
			
			List<String> srlist=sql.selectList("memberSQL.notSameSerial");
			
			for(int i =0; i<srlist.size(); i++) {
				if(m_serialnumber.equals(srlist.get(i))) {
					
				}
				else {continue;}
			}
			MultipartFile mf = request.getFile("m_profile_img"); // �씠履쎌씠 �븞�릺�뒗嫄곌컳���뜲�옞留� //湲곕낯媛� default.png�씤�뜲 �씠寃껊룄�븞李롰옒?洹멸굔紐곕옍
			String path = request.getRealPath("img");
			System.out.println(path);
			String org = mf.getOriginalFilename();
			System.out.println(mf);
			String ext="";
			String img="";
			String newName ="";
			File f= null;
			
			MWMemberVO vo = new MWMemberVO();
			
			newName = "default.png";
			vo.setM_profile_img(newName);
			if(!mf.equals(null)){
			ext = org.substring(org.lastIndexOf("."));
			img = m_id + ext;
			sql.insert("memberSQL.filenumsequence");
			
			int num = sql.selectOne("memberSQL.filemaxnum");
			
			newName = "image" + num + ext;
			f = new File(path + "//" + newName);
			mf.transferTo(f);
			vo.setM_profile_img(newName);
			} 
			System.out.println(newName);
			
			String m_email = m_email_1 + m_email_2;
			
			vo.setM_name(m_name);
			vo.setM_id(m_id);
			vo.setM_pw(m_pw);
			vo.setM_email(m_email);
			vo.setM_serialnumber(m_serialnumber);
			vo.setRegistrationdate(new Timestamp(System.currentTimeMillis()));
			sql.insert("memberSQL.signup", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Main/joinPro";//변경함_ksm
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
		return "Member/boots_login";
	}

	@RequestMapping("myPage.mw")
	public String myPage(HttpSession session, HttpServletRequest request) {
		String id = (String) session.getAttribute("loginUser");

		MWMemberVO ls = sql.selectOne("memberSQL.getMyinfo", id);

		request.setAttribute("vo", ls);

		return "/Member/myPage";
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
		
		String m_id = (String) session.getAttribute("loginUser");
		
		String empty = "empty";
		
		int postal_code = Integer.parseInt(zipNo);
		
		x = Double.parseDouble(entX); //�룊硫대룄 �뮘 �뙆�씪誘명꽣== 寃쎈룄 �눜洹쇰뒭�뼱�룄�맖?�쓳 �븳 9�떆源뚯� �뿴�뀑�뼱�꽌 �뀑�뀑�뀑 �굹�삤�뒛 怨듬��븯�뒓�씪 諛ㅼ깘�벏 �꼫媛�?�궡�씪硫댁젒�씠�씪 �뿉 諛⑺빐�븯�뒗嫄곗븘�땲�깘 �꽩�꽩�뀑�뀑�뀑�뀑�뀑
		y = Double.parseDouble(entY); //�룊硫대룄 �븵 �뙆�씪誘명꽣 == �쐞�룄

	    GeoPoint pt1 = new GeoPoint(x, y);
	    GeoPoint tm_pt = GeoTrans.convert(GeoTrans.UTMK, GeoTrans.GEO, pt1);
										
		String ylat = String.format("%.7f", tm_pt.x);
		
		String xlat = String.format("%.7f", tm_pt.y);
		System.out.println(xlat);
		System.out.println(ylat);
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

			/* 移쒓뎄由ъ뒪�듃 */
	    	
	    	System.out.println("�꽭�뀡 :"+m_id);
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
	
	@RequestMapping("Sfri2.mw")
	public String Sfri2(Model model, String searchFromAll){
		List<MWMemberVO> Slist = null;
		String m_id = (String)session.getAttribute("loginUser");
		try {
    	Map<String, String> map = new HashMap<String, String>();
   	 
    	map.put("searchFromAll", searchFromAll);
    	map.put("m_id", m_id);
    	System.out.println("========="+map.get("searchFromAll"));
    	System.out.println(map.get("m_id"));
    	
      	int count = (int)sql.selectOne("memberSQL.memberSearchCnt", map);
    	System.out.println("寃��깋寃곌낵 媛��닔 :" + count);
    	 Slist = sql.selectList("memberSQL.memberSearch", map);
    	
    	model.addAttribute("slist", Slist);
    	
    	if(count !=0) {
    	model.addAttribute("cntFrnd", count);
    	}
    	else if(count==0) {
    		String NResult = "寃��깋寃곌낵 �뾾�쓬";
    		model.addAttribute("NR", NResult);
    	}
		}catch(Exception e){e.printStackTrace();}
		return "/Member/sfri2";
	}
}
