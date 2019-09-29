package MeetWhen.spring.bean;

import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import MeetWhen.vo.calendar.CalendarVO;
import MeetWhen.vo.calendar.UpdataVO;

@Controller
@RequestMapping("/Main/")
public class CalenderBean {
	
	@Autowired
	private SqlSessionTemplate sql = null;
	@Autowired
	HttpSession session;
	
	@RequestMapping("boots_calendar.mw")
	public String boots_calendar(Model model) {
		
		String seeName = (String)session.getAttribute("loginName");
		
		
		String tablename = "MWMEETGROUP";
		
		
		
		
		
		
		model.addAttribute("groupList", seeName);
		model.addAttribute("seeName", seeName);
		return "/Main/boots_calendar";
	}

	
	@RequestMapping("calendar_Form.mw")
	public String calendar_Form() {
		return "/Main/calendar_Form";
	}
	
	
	
	
	
	
	//CreateCalendar.mw
		@RequestMapping(value="CreateCalendar.mw", method=RequestMethod.POST, produces = "application/text; charset=utf8")
		@ResponseBody
		public void CreateCalendar (@RequestBody Map<String, Object> map)throws NoSuchFieldException, NoSuchMethodException, IllegalAccessException, InvocationTargetException{
			CalendarVO cv = new CalendarVO();
			String jsonSt ="";
			JSONObject obj = new JSONObject();
			try {		
	        for( Map.Entry<String, Object> entry : map.entrySet() ) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            jsonSt += JSONObject.toString(key, value);
	            obj.put(key, value);
	        }
			}catch(Exception e) {}
			cv.setGroupid("hgty9305");
			cv.setTitle(obj.get("title").toString());
			cv.setC_start(obj.get("start").toString());
			cv.setC_end(obj.get("end").toString());
			cv.setType(obj.get("type").toString());
			cv.setM_id(obj.get("username").toString());
			cv.setBackgroundColor(obj.get("backgroundColor").toString());
			cv.setTextColor(obj.get("textColor").toString());
			cv.setAllDay(obj.get("allDay").toString());
			cv.setDescription(obj.get("description").toString());
			cv.setCdata(new Timestamp(System.currentTimeMillis()));
			sql.insert("calendar.insertData", cv);
		}
		
		@RequestMapping(value="SelectCalendar.mw", method=RequestMethod.POST, produces = "application/text; charset=utf8") 
		@ResponseBody
		public String SelectCalendar (@RequestParam(value="groupid") String groupid) throws NoSuchFieldException, NoSuchMethodException, IllegalAccessException, InvocationTargetException{	
			Map<String, Object> map = new LinkedHashMap();
			JSONArray jsonArray = new JSONArray();
			List rsList = new ArrayList(); 
			rsList = sql.selectList("calendar.serchData", groupid);		
			for(int i=0;i<rsList.size();i++) {
				CalendarVO cv = (CalendarVO)rsList.get(i);	
				boolean a = false;
				if(cv.getAllDay()=="true") {
					a = true;
				}
				map.put("allDay", a);
				map.put("textColor", cv.getTextColor());
				map.put("backgroundColor", cv.getBackgroundColor());
				map.put("username", cv.getM_id());
				map.put("type", cv.getType());
				map.put("description", cv.getDescription());
				map.put("end", cv.getC_end());
				map.put("start", cv.getC_start());
				map.put("title", cv.getTitle());
				map.put("_id", cv.getNum());
		
				JSONObject obj = new JSONObject();
		        for( Map.Entry<String, Object> entry : map.entrySet() ) {
		            String key = entry.getKey();
		            Object value = entry.getValue();
		            obj.put(key, value);   
		        }
		        jsonArray.add(obj);
			}	
			String jsonSt =""; 
			jsonSt = jsonArray.toString();		 
			return jsonSt;
		}
		
		
		@RequestMapping(value="UpdateCalendar.mw", method=RequestMethod.POST, produces = "application/text; charset=utf8")
		@ResponseBody
		public void UpdateCalendar (@RequestBody Map<String, Object> map)throws NoSuchFieldException, NoSuchMethodException, IllegalAccessException, InvocationTargetException{
			String jsonSt ="";
			JSONObject obj = new JSONObject();
	        for( Map.Entry<String, Object> entry : map.entrySet() ) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            jsonSt += JSONObject.toString(key, value);
	            obj.put(key, value);
	        }
	        String id = obj.get("num").toString();
	        int a = Integer.parseInt(id);
	        List list = new ArrayList(); 
			list = sql.selectList("calendar.onecall", a);	
			CalendarVO cv = (CalendarVO)list.get(0);
			cv.setTitle(obj.get("title").toString());
			cv.setC_start(obj.get("start").toString());
			cv.setC_end(obj.get("end").toString());
			cv.setType(obj.get("type").toString());
			cv.setBackgroundColor(obj.get("backgroundColor").toString());
			cv.setAllDay(obj.get("allDay").toString());
			cv.setDescription(obj.get("description").toString());
			sql.update("calendar.updateData", cv); 
		}
		
		@RequestMapping("DeleteCalendar.mw")
		public void DeleteCalendar(@RequestParam(value="num") int num)throws NoSuchFieldException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
			sql.delete("calendar.deleteData", num);
		}
		
		@RequestMapping("DropUpdate.mw")
		public void DropUpdate(@RequestParam(value="result") String result) {
			String[] a = result.split("@");
			String start = a[0];
			String end = a[1];
			int num = Integer.parseInt(a[2]);
			UpdataVO uvo = new UpdataVO();
			uvo.setC_start(start);
			uvo.setC_end(end);
			uvo.setNum(num);
			sql.update("calendar.dataUpdate", uvo);
		}
		
		
		
}
