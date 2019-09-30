package MeetWhen.vo.calendar;

import java.sql.Timestamp;

public class GroupVO {
	private String groupid;
	private String M_id;
	private String title;
	private String friendlist;
	private String infoshare;
	private String status;
	private Timestamp regidate;
	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getM_id() {
		return M_id;
	}
	public void setM_id(String m_id) {
		M_id = m_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFriendlist() {
		return friendlist;
	}
	public void setFriendlist(String friendlist) {
		this.friendlist = friendlist;
	}
	public String getInfoshare() {
		return infoshare;
	}
	public void setInfoshare(String infoshare) {
		this.infoshare = infoshare;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Timestamp getRegidate() {
		return regidate;
	}
	public void setRegidate(Timestamp regidate) {
		this.regidate = regidate;
	}
	
	
}
