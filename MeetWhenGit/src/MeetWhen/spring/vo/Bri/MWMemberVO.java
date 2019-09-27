package MeetWhen.spring.vo.Bri;

import java.sql.Timestamp;

public class MWMemberVO {
	private String m_id;
	private String m_pw;
	private String m_name;
	private String m_email;
	private String m_friendlist;
	private String m_profile_img;
	private String m_serialnumber;
	private Timestamp registrationdate;

	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_friendlist() {
		return m_friendlist;
	}
	public void setM_friendlist(String m_friendlist) {
		this.m_friendlist = m_friendlist;
	}

		
		public Timestamp getRegistrationdate() {
			return registrationdate;
		}
		public String getM_serialnumber() {
			return m_serialnumber;
		}
		public void setM_serialnumber(String m_serialnumber) {
			this.m_serialnumber = m_serialnumber;
		}
		public void setRegistrationdate(Timestamp registrationdate) {
			this.registrationdate = registrationdate;
		}
		
		public String getM_profile_img() {
			return m_profile_img;
		}
		public void setM_profile_img(String m_profile_img){
			this.m_profile_img= m_profile_img;
		}
	
	}

