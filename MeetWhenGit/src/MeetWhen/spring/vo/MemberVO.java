package MeetWhen.spring.vo;

public class MemberVO {//��ȿ�� �˻� �߰��ϱ�.
	
	private int m_num;     //������ȭ
	private int m_state;   //ȸ������
	private String m_id;   //id
	private String m_pw;   //password
	private String m_name; //�Ǹ�
	private String m_email;//�̸���(������)
	private String m_phone;//��ȭ��ȣ
	private String m_add;  //�� �ּ�
	
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
	}
	public int getM_state() {
		return m_state;
	}
	public void setM_state(int m_state) {
		this.m_state = m_state;
	}
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
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_add() {
		return m_add;
	}
	public void setM_add(String m_add) {
		this.m_add = m_add;
	}
}
