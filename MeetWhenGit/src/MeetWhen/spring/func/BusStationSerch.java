package MeetWhen.spring.func;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import MeetWhen.vo.transport.BUSstationVO;

public class BusStationSerch {
	public static ArrayList<BUSstationVO> main(String xlat, String ylat, String radius) {
		ArrayList<BUSstationVO> list = new ArrayList<BUSstationVO>();
		int page =1;
		try {
			String url="http://ws.bus.go.kr/api/rest/stationinfo/getStationByPos?"+
					"serviceKey="+"xQKpf9sLYTrRL7sv1WIbdVA%2FZiy7OnP%2FEjbhbJlEkyBx"+
					"03LXRoRbEL%2B0sktb%2FNS4kP4zpjc69gK9kIyN6%2BQPSQ%3D%3D"+
					"&tmX="+xlat+
					"&tmY="+ylat+
					"&radius="+radius;			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			doc.getDocumentElement().normalize();

			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("itemList");
			
			//파싱한 태그 수의 따른 객체 생성
			for(int temp=0; temp< nList.getLength(); temp++) {	
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					BUSstationVO bvo = new BUSstationVO();
					bvo.setB_arsId(getTagValue("arsId", eElement));
					bvo.setB_stationId(getTagValue("stationId", eElement));
					bvo.setB_xlat(getTagValue("gpsX", eElement));
					bvo.setB_ylat(getTagValue("gpsY", eElement));
					bvo.setB_stationName(getTagValue("stationNm", eElement));
					bvo.setB_dist(getTagValue("dist", eElement));
					bvo.setB_stationType(getTagValue("stationTp", eElement));
					list.add(bvo);
				}
				page += 1;
				if(page>nList.getLength()) {break;}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static List reMain(String lat, String lng, String radius) {
		int page =1;
		List list = new ArrayList();
		try {
			String url="http://ws.bus.go.kr/api/rest/stationinfo/getStationByPos?"+
					"serviceKey="+"xQKpf9sLYTrRL7sv1WIbdVA%2FZiy7OnP%2FEjbhbJlEkyBx"+
					"03LXRoRbEL%2B0sktb%2FNS4kP4zpjc69gK9kIyN6%2BQPSQ%3D%3D"+
					"&tmX="+lng+
					"&tmY="+lat+
					"&radius="+radius;
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			doc.getDocumentElement().normalize();

			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("itemList");
			
			//파싱한 태그 수의 따른 객체 생성
			for(int i=0; i< nList.getLength(); i++) {
				Node nNode = nList.item(i);
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					String[] poket = {
					getTagValue("stationNm", eElement),
					getTagValue("gpsX", eElement),
					getTagValue("gpsY", eElement),
					getTagValue("arsId", eElement)	 };
					list.add(poket);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
				
	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
}
