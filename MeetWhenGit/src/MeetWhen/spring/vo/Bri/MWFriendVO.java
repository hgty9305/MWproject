package MeetWhen.spring.vo.Bri;

import java.sql.Timestamp;

public class MWFriendVO {
	private String m_id;
	private String link_m_id;
	private String link_type;
	private String accept;
	private Timestamp request_date;
	private Timestamp createdate;
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getLink_m_id() {
		return link_m_id;
	}
	public void setLink_m_id(String link_m_id) {
		this.link_m_id = link_m_id;
	}
	public String getLink_type() {
		return link_type;
	}
	public void setLink_type(String link_type) {
		this.link_type = link_type;
	}
	public String getAccept() {
		return accept;
	}
	public void setAccept(String accept) {
		this.accept = accept;
	}
	public Timestamp getRequest_date() {
		return request_date;
	}
	public void setRequest_date(Timestamp request_date) {
		this.request_date = request_date;
	}
	public Timestamp getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Timestamp createdate) {
		this.createdate = createdate;
	}
}
