package MeetWhen.spring.vo.Bri;

import java.sql.Timestamp;

public class MWCalendarVO {
	private String m_id;
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public String getIsallday() {
		return isallday;
	}
	public void setIsallday(String isallday) {
		this.isallday = isallday;
	}
	public String getIsshare() {
		return isshare;
	}
	public void setIsshare(String isshare) {
		this.isshare = isshare;
	}
	public Timestamp getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Timestamp createdate) {
		this.createdate = createdate;
	}
	public Timestamp getEditdate() {
		return editdate;
	}
	public void setEditdate(Timestamp editdate) {
		this.editdate = editdate;
	}
	private String m_name;
	private String title;
	private int start;
	private int end;
	private String isallday;
	private String isshare;
	private Timestamp createdate;
	private Timestamp editdate;
}
