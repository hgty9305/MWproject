package MeetWhen.vo.bri;

public class MWAddressVO {
	private int adnum;

	public int getAdnum() {
		return adnum;
	}
	public void setAdnum(int adnum) {
		this.adnum = adnum;
	}

	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public String getLat1() {
		return lat1;
	}
	public void setLat1(String lat1) {
		this.lat1 = lat1;
		/* this.latOne = Double.parseDouble(lat1); */
	}
	public String getLong1() {
		return long1;
	}
	public void setLong1(String long1) {
		this.long1 = long1;
		/* this.longOne = Double.parseDouble(long1); */
	}
	public String getLat2() {
		return lat2;
	}
	public void setLat2(String lat2) {
		this.lat2 = lat2;
		/* this.latTwo = Double.parseDouble(lat2); */
							 
	}
	public String getLong2() {
		return long2;
	}
	public void setLong2(String long2) {
		this.long2 = long2;
		/* this.longTwo = Double.parseDouble(long2); */
	}
	public String getLat3() {
		return lat3;
	}
	public void setLat3(String lat3) {
		this.lat3 = lat3;
		/* this.latThrd = Double.parseDouble(lat3); */
	}
	public String getLong3() {
		return long3;
	}
	public void setLong3(String long3) {
		this.long3 = long3;
		/* this.longThrd = Double.parseDouble(long3); */
	}
	private int postal_code;
	public int getPostal_code() {
		return postal_code;
	}
	public void setPostal_code(int postal_code) {
		this.postal_code = postal_code;
	}
	private String m_id;
	private String address1;
	private String address2;
	private String address3;
	
	private String lat1;
	private String long1;
	private String lat2;
	private String long2;
	private String lat3;
	private String long3;
	private int status;
	
	  private double latOne; private double longOne; private double latTwo; private
	  double longTwo; private double latThrd; private double longThrd;
	 

	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
