package MeetWhen.spring.bean;




import java.util.ArrayList;


import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import MeetWhen.spring.func.BusStationSerch;
import MeetWhen.spring.func.StationBusSerch;
import MeetWhen.spring.func.SubwaySerch;

import MeetWhen.vo.transport.AdressVO;
import MeetWhen.vo.transport.BUSstationVO;
import MeetWhen.vo.transport.SubwayVO;




@Controller
@RequestMapping("/Transport/")
public class mapControler {
	
	@Autowired
	private SqlSessionTemplate sql = null;
	
	@RequestMapping("jusoPopup.mw")
	public String jusoPopup() {
		return "/Transport/jusoPopup";
	}
	
	@RequestMapping("Mainpage.mw")
	public String mainViewpage() {
		return "/Transport/Mainpage";
	}
	

	
	@RequestMapping("selfcheck.mw")
	public String selfcheck(Model model, HttpServletRequest request) {
		double x, y;
		String xs, ys;
		if(request.getParameter("entX")!=null) {
		x = Double.parseDouble(request.getParameter("entX"));
		y = Double.parseDouble(request.getParameter("entY"));
		GeoPoint pt1 = new GeoPoint(x, y);
		GeoPoint tm_pt = GeoTrans.convert(GeoTrans.UTMK, GeoTrans.GEO, pt1);
		xs = String.format("%.7f", tm_pt.x);
		ys = String.format("%.7f", tm_pt.y);
		model.addAttribute("xlat", xs);
		model.addAttribute("ylat", ys);
		}else if(request.getParameter("latX")!=null){
			model.addAttribute("xlat", request.getParameter("latY"));
			model.addAttribute("ylat", request.getParameter("latX"));
		}else {
			model.addAttribute("xlat", "1");
			model.addAttribute("ylat", "1");
		}
		return "/Transport/selfcheck";
	}

	
	@RequestMapping("BusSerch.mw")
	public String BusSerch(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			Model model, String xlat,String ylat,String radius,String entX, String entY) {
		double x, y;
		if(request.getParameter("selfX") != null) {
			xlat = request.getParameter("selfX");
			ylat = request.getParameter("selfY");
		}else{
		x = Double.parseDouble(entX);
		y = Double.parseDouble(entY);
		GeoPoint pt1 = new GeoPoint(x, y);
		GeoPoint tm_pt = GeoTrans.convert(GeoTrans.UTMK, GeoTrans.GEO, pt1);
		xlat = String.format("%.7f", tm_pt.x);
		ylat = String.format("%.7f", tm_pt.y);
		}
		radius= "300";

		BusStationSerch bss = new BusStationSerch();
		ArrayList<BUSstationVO> buslist = bss.main(xlat, ylat, radius);
		ArrayList<String[]> Blist = new ArrayList();
		
		//���߹迭�Լ��� �����Ѵ�(ũ�⸦ �������ִ� �ڵ��)
		String[][] total = new String[buslist.size()][4];
		
		//list�� ��� vo������ ������ ������ �迭�� ����־� �ϳ��ϳ� ����� �۾��̴�.
		for(int i=0;i<buslist.size();i++){
		BUSstationVO bvo = buslist.get(i);
		String ait = "'"+bvo.getB_stationName()+"'";
		String[] arg = {ait, bvo.getB_xlat(), bvo.getB_ylat(),bvo.getB_arsId()};
		Blist.add(arg);
		String[] a = Blist.get(i);
		for(int j=0;j<4;j++) {
			total[i][j] = a[j];
			}
		}
		//total.length�ᵵ �Ǵ� �κ������� �׳� �����ô�.
		model.addAttribute("buslistsize", buslist.size());
		
		//�ǽð� ���� ������ ���� total���߹迭�̴�.
		model.addAttribute("total", total);
		
		//�ؿ� ������ xlat ylat�� ������ �˻��� �ڱ� ��ġ �Ǵ� �˻�����ġ�� ��ǥ�̴�.
		model.addAttribute("myxlat", xlat);   
		model.addAttribute("myylat", ylat);
		return "/Transport/BusSerch";
	}
	
	@RequestMapping(value="returnBSinfo.mw", method=RequestMethod.POST) 
	@ResponseBody
	public String[][] returnBSinfo(@RequestParam(value="arsId") String arsId) throws Exception {
		StationBusSerch sb = new StationBusSerch();	
		List bslist = sb.BSinfo(arsId);
		String[][] bsArray = new String[bslist.size()][6];
		for(int i=0;i<bslist.size();i++) {
			bsArray[i] = (String[])bslist.get(i);
		}
		return bsArray;
	}
	
	@RequestMapping(value="findSB.mw", method=RequestMethod.POST) 
	@ResponseBody
	public String[][] findSB(@RequestParam(value="subfor") String subfor) throws Exception {
		double Nx, Ny, Sx, Sy;
		//�Ѿ�� String�� spilt���� �ɰ� ��Ʈ�� ������ �ش� �� �������� �����ͺ��̼� ���̸��� ��ǥ �̾� �迭�� ��� ���
		
		String[] ancy = subfor.split("/");
		Sx = Double.parseDouble(ancy[0]);
		Sy = Double.parseDouble(ancy[1]);
		Nx = Double.parseDouble(ancy[2]);
		Ny = Double.parseDouble(ancy[3]);
		
		//where Sx < x and Sy < y and Ny > y and Nx > x list
		AdressVO av = new AdressVO();
		av.setNx(Nx);
		av.setNy(Ny);
		av.setSx(Sx);
		av.setSy(Sy);
		String[][] resultSB = null;
		
		List<Object> sublist = new ArrayList();
		
		sublist = sql.selectList("sub.subwayCheck",av);
		
		System.out.println(sublist.size());
		resultSB = new String[sublist.size()][3];
		for(int i=0;i<sublist.size();i++) {
		SubwayVO sv = (SubwayVO)sublist.get(i);
		String xlat = String.format("%.7f", sv.getXlat());
		String ylat = String.format("%.7f", sv.getYlat());
		String[] result = {sv.getSubwayname(),xlat, ylat};
		resultSB[i] = result;
		}
		return resultSB;
	}
	
	
	@RequestMapping(value="returnSBinfo.mw", method=RequestMethod.POST) 
	@ResponseBody
	public String[][] returnSBinfo(@RequestParam(value="stationNm") String stationNm) throws Exception {
		SubwaySerch sb = new SubwaySerch();
		List sblist = sb.SBinfo(stationNm);
		String[][] sbArray = new String[sblist.size()][6];
		for(int i=0;i<sblist.size();i++) {
			sbArray[i] = (String[])sblist.get(i);
		}
		return sbArray;
	}
	
	@RequestMapping(value="returnCenter.mw", method=RequestMethod.POST) 
	@ResponseBody
	public String[][] returnCenter(@RequestParam(value="string") String string) throws Exception {
		BusStationSerch rbs = new BusStationSerch();
		String[] a = string.split("/");
		String lat = a[0];
		String lng = a[1];
		String radius= "300";
				
		List buslist = rbs.reMain(lat, lng, radius);
		
		//���߹迭�Լ��� �����Ѵ�(ũ�⸦ �������ִ� �ڵ��)
		String[][] total = new String[buslist.size()][4];
		
		for(int i=0;i<buslist.size();i++) {
			total[i] = (String[])buslist.get(i);
		}
		return total;
	}
	
	
	
	
	

}