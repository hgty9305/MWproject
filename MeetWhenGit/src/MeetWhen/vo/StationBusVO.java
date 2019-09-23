package MeetWhen.vo;

public class StationBusVO {

	private String b_stNm;
	//정류소 명

	private String b_adirection;
	//방향
	
	private String b_arrmsg1;
	//첫번째도착예정버스의 도착정보메시지
	
	private String b_arrmsg2;
	//2번째도착예정버스의 도착정보메시지
	
	private String b_rerideNum1;
	//첫번째도착예정버스의 재차인원
	
	private String b_rerideNum2;
	//2번째도착예정버스의 재차인원

	
	
	public String getB_stNm() {
		return b_stNm;
	}
	
	public void setB_stNm(String b_stNm) {
		this.b_stNm = b_stNm;
	}

	public String getB_adirection() {
		return b_adirection;
	}

	public void setB_adirection(String b_adirection) {
		this.b_adirection = b_adirection;
	}

	public String getB_arrmsg1() {
		return b_arrmsg1;
	}

	public void setB_arrmsg1(String b_arrmsg1) {
		this.b_arrmsg1 = b_arrmsg1;
	}

	public String getB_arrmsg2() {
		return b_arrmsg2;
	}

	public void setB_arrmsg2(String b_arrmsg2) {
		this.b_arrmsg2 = b_arrmsg2;
	}

	public String getB_rerideNum1() {
		return b_rerideNum1;
	}

	public void setB_rerideNum1(String b_rerideNum1) {
		this.b_rerideNum1 = b_rerideNum1;
	}

	public String getB_rerideNum2() {
		return b_rerideNum2;
	}

	public void setB_rerideNum2(String b_rerideNum2) {
		this.b_rerideNum2 = b_rerideNum2;
	}
	
	
}
