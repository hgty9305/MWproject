package MeetWhen.spring.func;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;



import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.json.simple.parser.JSONParser;

public class SubwaySerch {
	public static List SBinfo(String stationNm)throws Exception {
		
		List SBinfo = new ArrayList(); 

		try {
			String b = URLEncoder.encode(stationNm, "UTF-8");
			String urlst="http://swopenAPI.seoul.go.kr/api/subway/"+
					"4e5379534168677438356e4743686b/"+
					"json/realtimeStationArrival/1/16/"+b;
			URL url = new URL(urlst);

			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String json = br.readLine();
			
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject)parser.parse(json);

			JSONArray item = (JSONArray) obj.get("realtimeArrivalList");

			for(int i = 0 ; i < item.size(); i++) {
			
			JSONObject data = (JSONObject) item.get(i); 
			String subLine = "";

			switch(data.get("subwayId").toString()) {
			case "1001": subLine = "1ȣ��";
			break;
			case "1002": subLine = "2ȣ��";
			break;
			case "1003": subLine = "3ȣ��";
			break;
			case "1004": subLine = "4ȣ��";
			break;
			case "1005": subLine = "5ȣ��";
			break;					
			case "1006": subLine = "6ȣ��";
			break;
			case "1007": subLine = "7ȣ��";
			break;
			case "1008": subLine = "8ȣ��";
			break;
			case "1009": subLine = "9ȣ��";
			break;
			case "1065": subLine = "����ö��";
			break;
			case "1063": subLine = "�����߾Ӽ�";
			break;
			case "1067": subLine = "���ἱ";
			break;
			case "1071": subLine = "���μ�";
			break;
			case "1077": subLine = "�źд缱";
			break;
			case "1075": subLine = "�д缱";
			break;
			default: subLine = "�˼�����";
            break;
			}
			String[] a = {
					subLine,		//0 - ȣ�� ,1 - �����ܼ��������, 2- �����, 3- ������ȣ, 4-�����ġ, 5-
					data.get("updnLine").toString(),
					data.get("trainLineNm").toString(),
					data.get("btrainNo").toString(),
					data.get("arvlMsg2").toString(),
					data.get("arvlCd").toString()};
			
					SBinfo.add(a);
				};

		}catch(Exception e) {
			e.printStackTrace();
		}
		return SBinfo;
	}
}
