package MeetWhen.spring.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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
import MeetWhen.vo.airport.CrawlA2VO;
import MeetWhen.vo.airport.CrawlBVO;
import MeetWhen.vo.airport.RegionVO;

@Controller
@RequestMapping("/Crawl/")
public class CrawlBean {
	@Autowired
	private SqlSessionTemplate sql = null;

	/*Crawl_A1 : �⺻ ���� (���̹�) -----------------------------------------------------------------------------------------------------------------*/
	//Map1 ������ ����Ǹ� Ư�� �ð� ���� ������.
	@RequestMapping("doCrawla1.mw")  //��� 4�� 30�� ���� �ҿ�
	public String doCrawla1(HttpServletRequest request) throws Exception{ 
		System.out.println("[doCrawla1-RUNING...!]");
		sql.delete("crawl.deleCrawlA1");  //����
	
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
		//conn.eval("install.packages(\"RSelenium\")");
		conn.eval("library(RSelenium)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\", port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		
		int caseType=0; //���ܺ��� Ÿ��
		for(int i=0;i<conList.size();i++) { 
			conVo = new ContryVO();
			conVo = conList.get(i);
			
			int currentNum=conVo.getC_num(); //�˻��� ������ ��ȣ
			String currentCont = conVo.getC_con();//�˻��� ������ ������

			String cNum=Integer.toString(currentNum);//�̹��� �̸�, ����000 �����ֱ� ����.
			if(currentNum/100 == 0) {	
				if(currentNum%100 < 10) {	//ContNum�� 1-9 ���
					cNum="00"+cNum;
				}else {						//ContNum�� 10-99���
					cNum="0"+cNum;
				}
			}
			//�˻� ����
			conn.eval("remDr$navigate('https://www.naver.com/')");
			conn.eval("Sys.sleep(1)");
			conn.eval("WebEle <- remDr$findElement(using='css',\"[id='query']\")");
			conn.eval("WebEle$sendKeysToElement(list('"+currentCont+"',key=\"enter\"))");
			conn.eval("Sys.sleep(1)");
			//���1) �ٸ� �˻����1 :��,�Ͽ���,ȫ��,��ī��
			//���2) �ٸ� �˻����2 : ������ 
			//���3) �Ϲݰ�� : �׿� ���
			//���3-2) �Ϲݰ��, ȯ������X : ����,�����,��Ƽ���Ǿ�
			if(currentCont.equals("��") |currentCont.equals("�Ͽ���")|currentCont.equals("ȫ��") |currentCont.equals("��ī��")|currentCont.equals("�̰�����")) { 
				//���� ������
				caseType=1;
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
			}else if(currentCont.equals("������")) {//������ ����
				caseType=2;
				//������
				con=currentCont;
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
				caseType=3;
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
				
				/*
				 * conn.eval("imgRes<-GET(flag)"); //���� ������(Ȯ�ο�)���� conn.eval(
				 * "writeBin(content(imgRes,'raw'),sprintf(paste0('C:/save/%03d.png'),"+ContNum+
				 * "))"); //project ���� �� ���� String orgPath = request.getRealPath("img");
				 * //flag���� ��� ��ã�⶧���� img�� ã�� ������ String newPath =
				 * orgPath.replace("\\","/")+"/flag";
				 * 
				 * conn.eval("writeBin(content(imgRes,'raw'),sprintf(paste0('"+newPath+
				 * "/%03d.png'),"+ContNum+"))"); imgSrc="/MeetWhen/img/flag/"+cNum+".png";
				 */
				//���� ȯ��, ��������������� ����ó��
				conn.eval("rate<-remDr$findElements(using='css',\"#dss_nation_tab_summary_content > dl.lst_overv > dd:not(.frst):not(._world_clock) \")");
				conn.eval("rate<-sapply(rate,function(x){x$getElementText()})");
				try {
					conn.eval("rate<-gsub('\\n','',rate[[1]])"); //�����߻�
					rate = conn.eval("rate");
					rat = rate.asString();		
				}catch(RserveException ex) { //ȯ�������� ���� ��� ���� ó��.
					ex.printStackTrace();
					System.out.println("ȯ�� ���� x");
					rat="������ �����ϴ�";
				}
			}

			//��� ����.Ȯ�ο� ���
			System.out.println("[A1] "+currentNum+" "+currentCont+" "+con+" "+cap+" "
					+rat+" "+imgSrc+" "+caseType);

			cwa1Vo = new CrawlA1VO();
			cwa1Vo.setCwa1_num(currentNum);
			cwa1Vo.setCwa1_cont(currentCont);
			cwa1Vo.setCwa1_con(con);
			cwa1Vo.setCwa1_cap(cap);
			cwa1Vo.setCwa1_rat(rat);
			cwa1Vo.setCwa1_img(imgSrc);
			cwa1Vo.setCwa1_type(caseType);
			sql.insert("crawl.insertCrawlA1",cwa1Vo);
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
	
	
	/*Crawl_A2 : �⺻ ���� (����) -----------------------------------------------------------------------------------------------------------------*/
	@RequestMapping("doCrawla2.mw") //��� 5�� ���� �ҿ�
	public String doCrawla2(HttpServletRequest request) throws Exception{
		System.out.println("[doCrawla2-RUNING...!]");
		
		sql.delete("crawl.deleCrawlA2"); 
		List<RegionVO> conList = new ArrayList<RegionVO>();
		RegionVO vo = new RegionVO();
		CrawlA2VO cwa2Vo = null;
		conList = sql.selectList("airport.getRegion");
		
		RConnection conn = new RConnection();
		REXP explain1=null, explain2=null;
		String ex1="",ex2="";

		conn.eval("setwd('C:/R-workspace')");
		conn.eval("library(rvest)");
		conn.eval("library(httr)");
		//conn.eval("install.packages(\"RSelenium\")");
		conn.eval("library(RSelenium)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\", port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		
		for(int i=0;i<conList.size();i++) { 
			vo=conList.get(i);
			int currentNum=vo.getR_num();
			String currentCont = vo.getR_reg();
			System.out.println("[A2] "+currentNum+currentCont);
			
			conn.eval("remDr$navigate('https://www.google.com/')");
			conn.eval("Sys.sleep(1)");
			conn.eval("WebElem <- remDr$findElement(using='css', \"[name='q']\")");
			try {
				conn.eval("WebElem$sendKeysToElement(list('"+currentCont+"',key=\"enter\"))");
			}catch(RserveException ex) {
				System.out.print("[A2] "+currentCont+"�� ��������");
			}			
			//�˻� ����
			if(currentCont.equals("������")|currentCont.equals("Ŭ����������")) {//����
				System.out.println(currentCont+"->���� ����");
				
				conn.eval("c<-remDr$findElements(using='css',\"div.kno-ecr-pt.kno-fb-ctx.PZPZlf.gsmt > span\")");
				conn.eval("c<-sapply(c,function(x){x$getElementText()})");
				explain1 = conn.eval("c[[1]]");
				ex1 = explain1.asString();//�̸�
				
				conn.eval("d<-remDr$findElements(using='css',\"div.SALvLe.farUxc.mJ2Mod > div > div:nth-child(1) > div > div > div > div > span:nth-child(2)\")");
				conn.eval("d<-sapply(d,function(x){x$getElementText()})");
				explain2 = conn.eval("d[[1]]");
				ex2 = explain2.asString();//����
			}
			else {
				conn.eval("a<-remDr$findElements(using='css',\"div.wwUB2c.kno-fb-ctx.PZPZlf.E75vKf > span\")");
				conn.eval("a<-sapply(a,function(x){x$getElementText()})");
				explain1 = conn.eval("a[[1]]");
				ex1 = explain1.asString();//��ġ����
				
				conn.eval("b<-remDr$findElements(using='css',\"div.ifM9O > div:nth-child(2) > div.SALvLe.farUxc.mJ2Mod > div > div:nth-child(1) > div > div > div > div > span:nth-child(2)\")");
				conn.eval("b<-sapply(b,function(x){x$getElementText()})");
				conn.eval("b<-gsub('\\\"','',b[[1]])");
				explain2 = conn.eval("b");
				ex2 = explain2.asString();//����
			}
			cwa2Vo = new CrawlA2VO();
			cwa2Vo.setCwa2_num(currentNum);
			cwa2Vo.setCwa2_cont(currentCont);
			cwa2Vo.setCwa2_ex1(ex1);
			cwa2Vo.setCwa2_ex2(ex2);
			sql.insert("crawl.insertCrawlA2",cwa2Vo);
		}
		conn.eval("remDr$close()");
		conn.close();		
		return "/Crawl/doCrawla2";
	}
	/*Crawl_A2 : �⺻ ���� (����) > ��� */
	@RequestMapping("showCrawla2.mw") 
	public String showCrawla2(HttpServletRequest request) throws Exception{
		String clickCont = request.getParameter("cont");
		System.out.println("[showA2]="+clickCont);
		CrawlA2VO vo = sql.selectOne("crawl.getCrawlA2Click",clickCont);

		request.setAttribute("vo", vo);
		request.setAttribute("cont", clickCont);
		return "/Crawl/showCrawla2";
	}
	
	
	/*Crawl_B : ��� �� ��� ���� -----------------------------------------------------------------------------------------------------------------*/
	@RequestMapping("doCrawlb.mw")
	public String doCrawlb(HttpServletRequest request,int dbNum) throws Exception{
		String topURL="";
		//�⺻ ����
		RConnection conn = new RConnection();
		conn.eval("setwd('C:/R-workspace')");
		conn.eval("library(rvest)");
		conn.eval("library(httr)");
		//conn.eval("install.packages(\"RSelenium\")");
		conn.eval("library(RSelenium)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\", port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		
		if(dbNum==1) {
			System.out.println("[doCrawlB"+dbNum+", ���� -RUNING...!]");
			topURL="https://www.yna.co.kr/international/all";
			sql.delete("crawl.deleCrawlB1");
			System.out.println("[CrawlB"+dbNum+"]-Format Success");
			
		}else if(dbNum==2) {
			System.out.println("[doCrawlB"+dbNum+", ���� -RUNING...!]");
			topURL="https://www.yna.co.kr/international/europe";
			sql.delete("crawl.deleCrawlB2");
			System.out.println("[CrawlB"+dbNum+"]-Format Success");
	
		}else if(dbNum==3) {
			System.out.println("[doCrawlB"+dbNum+", ������ī,�ߵ� -RUNING...!]");
			topURL="https://www.yna.co.kr/international/middleeast-africa";
			sql.delete("crawl.deleCrawlB3");
			System.out.println("[CrawlB"+dbNum+"]-Format Success");
	
		}else if(dbNum==4) {
			System.out.println("[doCrawlB"+dbNum+", �����ƴϾ�&�ƽþ� -RUNING...!]");
			topURL="https://www.yna.co.kr/international/asia-australia";
			sql.delete("crawl.deleCrawlB4");
			System.out.println("[CrawlB"+dbNum+"]-Format Success��");
	
		}else if(dbNum==5) {
			System.out.println("[doCrawlB"+dbNum+", �ϾƸ޸�ī -RUNING...!]");
			topURL=" https://www.yna.co.kr/international/northamerica";
			sql.delete("crawl.deleCrawlB5");
			System.out.println("[CrawlB"+dbNum+"]-Format Success");
	
		}else if(dbNum==6) {
			System.out.println("[doCrawlB"+dbNum+", ���Ƹ޸�ī -RUNING...!]");
			topURL="https://www.yna.co.kr/international/centralsouth-america";
			sql.delete("crawl.deleCrawlB6");
			System.out.println("[CrawlB"+dbNum+"]-Format Success");

		}

		conn.eval("remDr$navigate('"+topURL+"')");
		conn.eval("html<-remDr$getPageSource()[[1]]");
		conn.eval("html<-read_html(html)"); //����->���� ���ε�
		//��� ����
		conn.eval("titles<-html_nodes(html,'#content > div.contents > div.contents01 > div > div.headlines.headline-list > ul > li > div > strong > a')");
		conn.eval("titles<-html_text(titles)");
		conn.eval("titles<-gsub('\\\"',\"\",titles)");
		conn.eval("titles<-head(titles,15)");
		conn.eval("titles");
		conn.eval("articleDf<-titles");
		//��� ��ũ, �̹���
		conn.eval("links<-html_nodes(html,'#content > div.contents > div.contents01 > div > div.headlines.headline-list > ul > li > div > strong > a')");
		conn.eval("links<-html_attr(links,\"href\")");
		conn.eval("links<-head(links,15)");
		conn.eval("links");
		conn.eval("inUrls<-NULL; imgUrls<-NULL");
		conn.eval("for(i in 1:length(links)){" + 
				"  inUrl<-paste0('https:',links[i]);" + 
				"  inUrls<-c(inUrls,inUrl);" + 
				"  inHtml<-read_html(inUrl);" + 
				"  inner_nodes<-html_nodes(inHtml,\"#articleWrap > div.article > div > img\");" + 
				"  if(length(inner_nodes)>0){" + 
				"    href<-html_attr(inner_nodes[1],\"src\");" + 
				"    imgUrl<-paste0('http:',href);" + 
				"    imgUrls<-c(imgUrls,imgUrl);" + 
				"  }" + 
				"}");
		conn.eval("articleDf<-rbind(articleDf,imgUrls)");//������������ �ۼ�  
		conn.eval("articleDf<-rbind(articleDf,inUrls)");
		conn.eval("articleDf<-as.data.frame(articleDf)"); 
		REXP artDf = conn.eval("articleDf");
		RList list = artDf.asList(); 
		//�迭�� ���� ����
		String [][] arr = new String[list.size()][];
		for(int i=0;i<list.size();i++) 
			arr[i]=list.at(i).asStrings();	
		
		//db�� ����(Ȯ�ο� ���)
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<arr[i].length;j++) {
				System.out.println("[B"+dbNum+"] "+arr[i][j]);
			}
			System.out.println();
			//db�� ����
			if(dbNum==1) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB1",cwb1Vo);
			}else if(dbNum==2) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB2",cwb1Vo);
			}else if(dbNum==3) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB3",cwb1Vo);
			}
			else if(dbNum==4) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB4",cwb1Vo);
			}
			else if(dbNum==5) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB5",cwb1Vo);
			}
			else if(dbNum==6) {
				CrawlBVO cwb1Vo = new CrawlBVO();
				cwb1Vo.setCwb_num(i+1);
				cwb1Vo.setCwb_title(arr[i][0]);
				cwb1Vo.setCwb_img(arr[i][1]);
				cwb1Vo.setCwb_url(arr[i][2]);
				sql.insert("crawl.insertCrawlB6",cwb1Vo);
			}
		}
		
		conn.eval("remDr$close()");
		conn.close();
		request.setAttribute("topURL", topURL);
		return "/Crawl/doCrawlb";
	}
	/*Crawl_B : ��� �� ��� ���� > ��� */
	@RequestMapping("showCrawlb.mw")
	public String showCrawlb(HttpServletRequest request,int dbNum) throws Exception{
		System.out.println("[showB "+dbNum+" RUNNING..!]");
		
		String topURL="";
		List allList =null;
		if(dbNum==1) {
			topURL = "https://www.yna.co.kr/international/all";
			allList = sql.selectList("crawl.getCrawlB1");	
		}else if(dbNum==2) {
			topURL = "https://www.yna.co.kr/international/europe";
			allList = sql.selectList("crawl.getCrawlB2");
		}else if(dbNum==3) {
			topURL = "https://www.yna.co.kr/international/middleeast-africa";
			allList = sql.selectList("crawl.getCrawlB3");
		}else if(dbNum==4) {
			topURL = "https://www.yna.co.kr/international/asia-australia";
			allList = sql.selectList("crawl.getCrawlB4");
		}else if(dbNum==5) {
			topURL = "https://www.yna.co.kr/international/northamerica";
			allList = sql.selectList("crawl.getCrawlB5");
		}else if(dbNum==6) {
			topURL = "https://www.yna.co.kr/international/centralsouth-america";
			allList = sql.selectList("crawl.getCrawlB6");
		}
		request.setAttribute("dbNum", dbNum);
		request.setAttribute("topURL", topURL);
		request.setAttribute("allList",allList); //����Ʈ
		return "/Crawl/showCrawlb";
	}
	
	/*Crawl_C : ���� ��õ��� ------{R�ڵ忡 ���� ����, �켱 �ּ� ó��}--------------------------------------------*/
	@RequestMapping("doShowCrawlc.mw")
	public String doShowCrawlc(HttpServletRequest request) throws Exception{
		String clickCont = request.getParameter("cont");
		System.out.println("[showC]="+clickCont);
		/*
		RConnection conn = new RConnection();
		//conn.eval("setwd('D:/R-workspace')");
		conn.eval("library(RSelenium)");
		conn.eval("library(Rserve)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\", port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		conn.eval("remDr$navigate('https://www.google.com/travel/guide')");
		//����˻�
		conn.eval("WebEle <- remDr$findElement(using='css','input.gb_gf')");
		conn.eval("WebEle$sendKeysToElement(list('"+clickCont+"',key='enter'))");
		
		//Ÿ��Ʋ
		conn.eval("Sys.sleep(1)");
		conn.eval("title<-remDr$findElements(using='css',\"[class='ggmJKc GBwJj gws-trips-modules__top-sight-card']\");");
		conn.eval("title<-sapply(title,function(x){x$getElementText()});");
		conn.eval("title<-unlist(title)"); 
		conn.eval("title<-strsplit(title,split='\\n')");
		conn.eval("recomDf<-NULL");
		conn.eval("for(i in 1:5){;" + 
				"  if(is.na(title[[i]][3])==FALSE){;" + 
				"    vec<-c(title[[i]][1],title[[i]][4]);" + 
				"    recomDf<-rbind(recomDf,vec);" + 
				"  }else{;" + 
				"    vec<-c(title[[i]][1],title[[i]][2]);" + 
				"    recomDf<-rbind(recomDf,vec);" + 
				"  };" + 
				"};");
		conn.eval("colnames(recomDf)=c('place','explain')");
		
		//��ũurl
		conn.eval("Sys.sleep(1)");
		conn.eval("webElem1<-remDr$findElements(using='css',\"[data-m_t='lcl_akp']\")");
		conn.eval("href<-sapply(webElem1,function(x){x$getElementAttribute(\"href\")})");
		conn.eval("href<-href[1:5]");
		conn.eval("href<-unlist(href)");
		conn.eval("recomDf<-cbind(recomDf,href)");

		//�̹���src
		conn.eval("Sys.sleep(1)");
		conn.eval("webElem2<-remDr$findElements(using='css',\"[class='j7vNHc Bcr3Ab bh9Cef']\")");
		conn.eval("imgSrc<-sapply(webElem2,function(x){x$getElementAttribute(\"style\")})");
		conn.eval("imgSrc<-imgSrc[1:5]");
		conn.eval("imgSrc<-gsub('background-image: url\\\\(\\\\\"','',imgSrc)");
		conn.eval("imgSrc<-gsub('\\\\\"\\\\)\\\\;','',imgSrc)");
		conn.eval("imgSrc<-unlist(imgSrc)");
		conn.eval("recomDf<-cbind(recomDf,imgSrc)");
		conn.eval("recomDf<-as.data.frame(recomDf)");

		
		REXP Df = conn.eval("recomDf");
		//conn.eval("remDr$close()");
		conn.close();
		RList recom = Df.asList(); 
		String[][] arr = new String[recom.size()][];
		
		System.out.println(recom.size()+" / "+recom.at(1).length());
		//arr�� �� ����.
		for(int i=0;i<recom.size();i++) { 
			arr[i]=recom.at(i).asStrings(); 
		} 
		for(int i=0;i<recom.size();i++) {
			for(int j=0;j<recom.at(1).length();j++) {
				System.out.print(arr[i][j]+" ");
			}
			System.out.println();
		}
		
		//vo���� �� ������ ��.
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Map<String,String> recomPlace=null;
		int dataSize = recom.at(1).length();
		for(int i=0;i<dataSize;i++) {
			recomPlace = new HashMap<>();
			recomPlace.put("place", arr[0][i]);
			recomPlace.put("explain", arr[1][i]);
			recomPlace.put("href", arr[2][i]);
			recomPlace.put("imgSrc", arr[3][i]);
			System.out.println(recomPlace);
			list.add(recomPlace);
		}
		System.out.println(list);
		System.out.println(dataSize);
		request.setAttribute("dataList", list);
		request.setAttribute("dataSize", dataSize);
		
		*/
		request.setAttribute("clickCont", clickCont);
		return "/Crawl/doShowCrawlc";
	}
	/*CrawlControl : DB�� �ֱ������� ����&���� ��Ŵ-----------------------------------------------------------------*/
	@RequestMapping("CrawlControl.mw")
	public String doCrawlControl() {
		System.out.println("[Ư�� �ð��� ������ DB�� ���� ���� �� ���� �ϴ� ������]");
		return"/Crawl/CrawlControl";
	}

}
