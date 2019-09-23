package MeetWhen.vo;

public class BUSstationVO {
	private String b_stationId; //정류소아이디
	private String b_stationName;	//정류소 이름
	private String b_xlat;	// 정류소 gps x좌표
	private String b_ylat;	// 정류소 gps y좌표
	private String b_dist;	// 지정위치와 정류소와의 거리(m단위)
	private String b_arsId;	// 정류소 외부id
	private String b_stationType;	// 정류소 타입.
	public String getB_stationId() {
		return b_stationId;
	}
	public void setB_stationId(String b_stationId) {
		this.b_stationId = b_stationId;
	}
	public String getB_stationName() {
		return b_stationName;
	}
	public void setB_stationName(String b_stationName) {
		this.b_stationName = b_stationName;
	}
	public String getB_xlat() {
		return b_xlat;
	}
	public void setB_xlat(String b_xlat) {
		this.b_xlat = b_xlat;
	}
	public String getB_ylat() {
		return b_ylat;
	}
	public void setB_ylat(String b_ylat) {
		this.b_ylat = b_ylat;
	}
	public String getB_dist() {
		return b_dist;
	}
	public void setB_dist(String b_dist) {
		this.b_dist = b_dist;
	}
	public String getB_arsId() {
		return b_arsId;
	}
	public void setB_arsId(String b_arsId) {
		this.b_arsId = b_arsId;
	}
	public String getB_stationType() {
		return b_stationType;
	}
	public void setB_stationType(String b_stationType) {
		this.b_stationType = b_stationType;
	}
	
	
	
}
