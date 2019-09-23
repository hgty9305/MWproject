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
			case "1001": subLine = "1호선";
			break;
			case "1002": subLine = "2호선";
			break;
			case "1003": subLine = "3호선";
			break;
			case "1004": subLine = "4호선";
			break;
			case "1005": subLine = "5호선";
			break;					
			case "1006": subLine = "6호선";
			break;
			case "1007": subLine = "7호선";
			break;
			case "1008": subLine = "8호선";
			break;
			case "1009": subLine = "9호선";
			break;
			case "1065": subLine = "공항철도";
			break;
			case "1063": subLine = "경의중앙선";
			break;
			case "1067": subLine = "경춘선";
			break;
			case "1071": subLine = "수인선";
			break;
			case "1077": subLine = "신분당선";
			break;
			case "1075": subLine = "분당선";
			break;
			default: subLine = "알수없음";
            break;
			}
			String[] a = {
					subLine,		//0 - 호선 ,1 - 내선외선하향상향, 2- 어디방면, 3- 열차번호, 4-어디위치, 5-
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
