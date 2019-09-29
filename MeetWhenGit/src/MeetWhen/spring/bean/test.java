package MeetWhen.spring.bean;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import MeetWhen.vo.airport.ContryVO;
import MeetWhen.vo.airport.CrawlA1VO;
import MeetWhen.vo.airport.LContryVO;
import MeetWhen.vo.airport.LRegionVO;
import MeetWhen.vo.airport.RegionVO;

@Controller

public class test {
	@Autowired
	private SqlSessionTemplate sql = null;
	@RequestMapping("doCrawla1.mw")  
	public String doCrawla1(HttpServletRequest request) throws Exception{
		sql.delete("crawl.deleCrawlA1");  //DB����
	
		List<ContryVO> conList = new ArrayList<ContryVO>();
		conList = sql.selectList("airport.getContry");
		ContryVO conVo = null;	  //���������� ���� vo
		CrawlA1VO cwa1Vo = null;  //ũ�Ѹ� ����� ���� vo
		
		RConnection conn = new RConnection();
		REXP contry=null, capital=null, rate=null,imageSrc=null;//R����� ���� ����
		String con="", cap="", rat="",imgSrc="";//R����� ����ȯ�Ͽ� ���� ����
		conn.eval("setwd('C:/R-workspace')");
		conn.eval("library(rvest)");
		conn.eval("library(httr)");
		conn.eval("library(RSelenium)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\","
				+ "port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		int caseType=0; //���ܺ��� Ÿ��
		for(int i=0;i<conList.size();i++) { 
			conVo = new ContryVO();
			conVo = conList.get(i);
			int currentNum=conVo.getC_num(); //�˻��� ������ ��ȣ
			String currentCont = conVo.getC_con();//�˻��� ������ ������

			String cNum=Integer.toString(currentNum); 	//�̹��� �̸�, ����000 �����ֱ� ����
			if(currentNum/100 == 0) {	
				if(currentNum%100 < 10) //ContNum�� 1-9 ���
					cNum="00"+cNum;
				else 					//ContNum�� 10-99���
					cNum="0"+cNum;				
			}
			conn.eval("remDr$navigate('https://www.naver.com/')");
			conn.eval("Sys.sleep(1)");
			conn.eval("WebEle <- remDr$findElement(using='css',\"[id='query']\")");
			conn.eval("WebEle$sendKeysToElement(list('"+currentCont+"',key=\"enter\"))");
			conn.eval("Sys.sleep(1)");
			if(currentCont.equals("��") |currentCont.equals("�Ͽ���")|currentCont.equals("ȫ��") |currentCont.equals("��ī��")|currentCont.equals("�̰�����")) { 				
				caseType=1;	//����1
				//���� ������
				conn.eval("contry<-remDr$findElements(using='css',\"div.overseas_thumb > div > div > strong.title_text\")");
				conn.eval("contry<-sapply(contry,function(x){x$getElementText()})");
				conn.eval("contry<-contry[[1]]");
				contry = conn.eval("contry");
				con=contry.asString();
				//�������, ��ġ
				conn.eval("spot<-remDr$findElements(using='css',\"div.city_info > dl > dd:nth-child(2)\")");
				conn.eval("spot<-sapply(spot,function(x){x$getElementText()})");
				conn.eval("spot<- gsub(' ��ġ����','',spot[[1]])");
				capital = conn.eval("spot");
				cap=capital.asString();
				//ȯ�� 
				conn.eval("trvBtn <- remDr$findElements(using='css', 'li._second_tab > a')");
				conn.eval("sapply(trvBtn, function(x){x$clickElement()})");
				conn.eval("rate<-remDr$findElements(using='css',\"div.rate_area > ul > li:nth-child(1) > span.info_text\")");
				conn.eval("rate<-sapply(rate,function(x){x$getElementText()})");
				conn.eval("rate<- gsub(' ȯ������','',rate[[1]])");
				rate = conn.eval("rate");
				rat=rate.asString();
				imgSrc="/MeetWhenGit/img/flag/"+cNum+".png";//����� ���Ͽ��ִ°����� ����.
			}else if(currentCont.equals("������")) {
				caseType=2;	//����2
				con=currentCont;//������
				//��ġ
				conn.eval("remDr$navigate('https://terms.naver.com/entry.nhn?docId=1107822&cid=40942&categoryId=33295')");
				conn.eval("spot<-remDr$findElements(using='css',\"div.wr_tmp_profile > div > table > tbody > tr:nth-child(1) > td\")");
				conn.eval("spot<-sapply(spot,function(x){x$getElementText()})");
				capital = conn.eval("spot[[1]]");
				cap = capital.asString();
				//ȯ����� ��ȭ
				conn.eval("cash<-remDr$findElements(using='css',\"div.wr_tmp_profile > div > table > tbody > tr:nth-child(10) > td\")");
				conn.eval("cash<-sapply(cash,function(x){x$getElementText()})");
				rate = conn.eval("cash[[1]]");
				rat=rate.asString();
				imgSrc="/MeetWhenGit/img/flag/"+cNum+".png";//����� ���Ͽ��ִ°����� ����.
			}else {	
				caseType=3; //����3(�Ϲ� �˻� ���)
				//���� ������
				conn.eval("contry<-remDr$findElements(using='css',\"#main_pack > div.content_search.section > div > div.contents03_sub > div > div.nacon_area._info_area > div.naflag_box > dl > dt\")");
				conn.eval("contry<-sapply(contry,function(x){x$getElementText()})");
				conn.eval("contry<-gsub('\\n',' _ ',contry[[1]])");
				contry = conn.eval("contry");
				con = contry.asString();			
				//���� ����
				conn.eval("capital<-remDr$findElements(using='css',\"#main_pack > div.content_search.section > div > div.contents03_sub > div > div.nacon_area._info_area > div.naflag_box > dl > dd:nth-child(2) > a\")");
				conn.eval("capital<-sapply(capital,function(x){x$getElementText()})");
				capital = conn.eval("capital[[1]]");
				cap = capital.asString();
				//���� 
				conn.eval("html<-remDr$getPageSource()[[1]]");
				conn.eval("html<-read_html(html)");
				conn.eval("flag<-html_node(html,\"[alt='flag']\")");
				conn.eval("flag<-html_attr(flag,\"src\")");
				imageSrc =conn.eval("flag");
				imgSrc = imageSrc.asString();
				//���� ȯ��, ��������������� ����ó��
				conn.eval("rate<-remDr$findElements(using='css',\"#dss_nation_tab_summary_content > dl.lst_overv > dd:not(.frst):not(._world_clock) \")");
				conn.eval("rate<-sapply(rate,function(x){x$getElementText()})");
				try {
					conn.eval("rate<-gsub('\\n','',rate[[1]])"); //�����߻� ���� ����
					rate = conn.eval("rate");
					rat = rate.asString();		
				}catch(RserveException ex) { //ȯ�������� ���� ��� ���� ó��.
					ex.printStackTrace();
					System.out.println("ȯ�� ���� x");
					rat="������ �����ϴ�";
				}
			}
			cwa1Vo = new CrawlA1VO();
			cwa1Vo.setCwa1_num(currentNum);
			cwa1Vo.setCwa1_cont(currentCont);
			cwa1Vo.setCwa1_con(con);
			cwa1Vo.setCwa1_cap(cap);
			cwa1Vo.setCwa1_rat(rat);
			cwa1Vo.setCwa1_img(imgSrc);
			cwa1Vo.setCwa1_type(caseType);
			sql.insert("crawl.insertCrawlA1",cwa1Vo);//DB����
		}
		conn.eval("remDr$close()");
		conn.close();
		return "/Crawl/doCrawla1";
	}
	
	/*Crawl_A1 : �⺻ ���� (���̹�) > ���*/
	@RequestMapping("showCrawla1.mw")
	public String showCrawla1(HttpServletRequest request) throws Exception{
		String clickCont = request.getParameter("cont");
		System.out.println("[showA1] "+clickCont);
		
		CrawlA1VO vo = sql.selectOne("crawl.getCrawlA1Click",clickCont);
		request.setAttribute("vo", vo);
		return "/Crawl/showCrawla1";
	}	

}
