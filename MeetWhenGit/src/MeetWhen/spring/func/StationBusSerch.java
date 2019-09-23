package MeetWhen.spring.func;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class StationBusSerch {
	
	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null)
	        return null;
	    return nValue.getNodeValue();
	}
	
	public static List BSinfo(String arsId)throws Exception {
		
		List BSinfo = new ArrayList(); 

		try {
			//¿ÀÇÂ api Å° °ª
			String url="http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid?"+
					"serviceKey=xQKpf9sLYTrRL7sv1WIbdVA%2FZiy7OnP%2FEjbhbJlEkyBx"+
					"03LXRoRbEL%2B0sktb%2FNS4kP4zpjc69gK9kIyN6%2BQPSQ%3D%3D"+
					"&arsId="+ arsId;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			doc.getDocumentElement().normalize();

			// ÆÄ½ÌÇÒ tag
			NodeList nList = doc.getElementsByTagName("itemList");
			
			for(int i=0; i< nList.getLength(); i++) {
				Node nNode = nList.item(i);
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					String[] a = {
					getTagValue("rtNm", eElement),
					getTagValue("adirection", eElement),
					getTagValue("arrmsg1",eElement),
					getTagValue("rerideNum1",eElement),
					getTagValue("arrmsg2",eElement),
					getTagValue("rerideNum2",eElement) };
					BSinfo.add(a);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return BSinfo;
	}
}
