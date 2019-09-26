package MeetWhen.spring.bean;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import MeetWhen.vo.airport.LContryVO;
import MeetWhen.vo.airport.LRegionVO;
/*������ ���õ� ��� �� */
@Controller
@RequestMapping("/Map/")
public class MapBean {
	@Autowired
	private SqlSessionTemplate sql = null;
			
		//--------------------------------------------------------��� Map ������
		@RequestMapping("map1.mw")
		public String map1(HttpServletRequest request) {			
			List<LContryVO> dataList = new ArrayList<LContryVO>();
			dataList = sql.selectList("latlon.getLContry"); 
			int listSize = dataList.size();
			
			String [][] total = new String[listSize][4];
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLc_con();
					total[i][1] = Double.toString(dataList.get(i).getLc_lon());
					total[i][2] = Double.toString(dataList.get(i).getLc_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLc_cnt());
			}
			
			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map1";
		}
		
		@RequestMapping("map2.mw")
		public String map2(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map2";
		}
		
		@RequestMapping("map3.mw")
		public String map3(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}
			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map3";
		}
		@RequestMapping("map4.mw")
		public String map4(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map4";
		}
		@RequestMapping("map5.mw")
		public String map5(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map5";
		}
		@RequestMapping("map6.mw")
		public String map6(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map6";
		}
		@RequestMapping("map7.mw")
		public String map7(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map7";
		}
		@RequestMapping("map8.mw")
		public String map8(HttpServletRequest request) {			
			List<LRegionVO> dataList = new ArrayList<LRegionVO>();
			dataList = sql.selectList("latlon.getLRegion"); //��� ���� ��������
			int listSize = dataList.size();//infoList�� ����
			
			String [][] total = new String[listSize][4];	
			for(int i=0;i<listSize;i++) {
					total[i][0] = dataList.get(i).getLr_reg();
					total[i][1] = Double.toString(dataList.get(i).getLr_lon());
					total[i][2] = Double.toString(dataList.get(i).getLr_lat());
					total[i][3] = Integer.toString(dataList.get(i).getLr_cnt());
			}

			request.setAttribute("total", total);	
			request.setAttribute("listSize", listSize);
			return "/Map/map8";
		}
}
