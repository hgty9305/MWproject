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
		sql.delete("crawl.deleCrawlA1");  //DB리셋
	
		List<ContryVO> conList = new ArrayList<ContryVO>();
		conList = sql.selectList("airport.getContry");
		ContryVO conVo = null;	  //나라정보를 담을 vo
		CrawlA1VO cwa1Vo = null;  //크롤링 결과를 담을 vo
		
		RConnection conn = new RConnection();
		REXP contry=null, capital=null, rate=null,imageSrc=null;//R결과를 담을 변수
		String con="", cap="", rat="",imgSrc="";//R결과를 형변환하여 담을 변수
		conn.eval("setwd('C:/R-workspace')");
		conn.eval("library(rvest)");
		conn.eval("library(httr)");
		conn.eval("library(RSelenium)");
		conn.eval("remDr <- remoteDriver(remoteServerAdd=\"localhost\","
				+ "port=4445, browserName=\"chrome\")");
		conn.eval("remDr$open()");
		int caseType=0; //예외변수 타입
		for(int i=0;i<conList.size();i++) { 
			conVo = new ContryVO();
			conVo = conList.get(i);
			int currentNum=conVo.getC_num(); //검색한 나라의 번호
			String currentCont = conVo.getC_con();//검색한 나라의 국가명

			String cNum=Integer.toString(currentNum); 	//이미지 이름, 단위000 맞춰주기 위함
			if(currentNum/100 == 0) {	
				if(currentNum%100 < 10) //ContNum이 1-9 경우
					cNum="00"+cNum;
				else 					//ContNum이 10-99경우
					cNum="0"+cNum;				
			}
			conn.eval("remDr$navigate('https://www.naver.com/')");
			conn.eval("Sys.sleep(1)");
			conn.eval("WebEle <- remDr$findElement(using='css',\"[id='query']\")");
			conn.eval("WebEle$sendKeysToElement(list('"+currentCont+"',key=\"enter\"))");
			conn.eval("Sys.sleep(1)");
			if(currentCont.equals("괌") |currentCont.equals("하와이")|currentCont.equals("홍콩") |currentCont.equals("마카오")|currentCont.equals("싱가포르")) { 				
				caseType=1;	//예외1
				//정식 국가명
				conn.eval("contry<-remDr$findElements(using='css',\"div.overseas_thumb > div > div > strong.title_text\")");
				conn.eval("contry<-sapply(contry,function(x){x$getElementText()})");
				conn.eval("contry<-contry[[1]]");
				contry = conn.eval("contry");
				con=contry.asString();
				//수도대신, 위치
				conn.eval("spot<-remDr$findElements(using='css',\"div.city_info > dl > dd:nth-child(2)\")");
				conn.eval("spot<-sapply(spot,function(x){x$getElementText()})");
				conn.eval("spot<- gsub(' 위치보기','',spot[[1]])");
				capital = conn.eval("spot");
				cap=capital.asString();
				//환율 
				conn.eval("trvBtn <- remDr$findElements(using='css', 'li._second_tab > a')");
				conn.eval("sapply(trvBtn, function(x){x$clickElement()})");
				conn.eval("rate<-remDr$findElements(using='css',\"div.rate_area > ul > li:nth-child(1) > span.info_text\")");
				conn.eval("rate<-sapply(rate,function(x){x$getElementText()})");
				conn.eval("rate<- gsub(' 환율정보','',rate[[1]])");
				rate = conn.eval("rate");
				rat=rate.asString();
				imgSrc="/MeetWhenGit/img/flag/"+cNum+".png";//국기는 파일에있는것으로 지정.
			}else if(currentCont.equals("사이판")) {
				caseType=2;	//예외2
				con=currentCont;//국가명
				//위치
				conn.eval("remDr$navigate('https://terms.naver.com/entry.nhn?docId=1107822&cid=40942&categoryId=33295')");
				conn.eval("spot<-remDr$findElements(using='css',\"div.wr_tmp_profile > div > table > tbody > tr:nth-child(1) > td\")");
				conn.eval("spot<-sapply(spot,function(x){x$getElementText()})");
				capital = conn.eval("spot[[1]]");
				cap = capital.asString();
				//환율대신 통화
				conn.eval("cash<-remDr$findElements(using='css',\"div.wr_tmp_profile > div > table > tbody > tr:nth-child(10) > td\")");
				conn.eval("cash<-sapply(cash,function(x){x$getElementText()})");
				rate = conn.eval("cash[[1]]");
				rat=rate.asString();
				imgSrc="/MeetWhenGit/img/flag/"+cNum+".png";//국기는 파일에있는것으로 지정.
			}else {	
				caseType=3; //예외3(일반 검색 결과)
				//정식 국가명
				conn.eval("contry<-remDr$findElements(using='css',\"#main_pack > div.content_search.section > div > div.contents03_sub > div > div.nacon_area._info_area > div.naflag_box > dl > dt\")");
				conn.eval("contry<-sapply(contry,function(x){x$getElementText()})");
				conn.eval("contry<-gsub('\\n',' _ ',contry[[1]])");
				contry = conn.eval("contry");
				con = contry.asString();			
				//국가 수도
				conn.eval("capital<-remDr$findElements(using='css',\"#main_pack > div.content_search.section > div > div.contents03_sub > div > div.nacon_area._info_area > div.naflag_box > dl > dd:nth-child(2) > a\")");
				conn.eval("capital<-sapply(capital,function(x){x$getElementText()})");
				capital = conn.eval("capital[[1]]");
				cap = capital.asString();
				//국기 
				conn.eval("html<-remDr$getPageSource()[[1]]");
				conn.eval("html<-read_html(html)");
				conn.eval("flag<-html_node(html,\"[alt='flag']\")");
				conn.eval("flag<-html_attr(flag,\"src\")");
				imageSrc =conn.eval("flag");
				imgSrc = imageSrc.asString();
				//국가 환율, 존재하지않을경우 예외처리
				conn.eval("rate<-remDr$findElements(using='css',\"#dss_nation_tab_summary_content > dl.lst_overv > dd:not(.frst):not(._world_clock) \")");
				conn.eval("rate<-sapply(rate,function(x){x$getElementText()})");
				try {
					conn.eval("rate<-gsub('\\n','',rate[[1]])"); //에러발생 가능 존재
					rate = conn.eval("rate");
					rat = rate.asString();		
				}catch(RserveException ex) { //환율정보가 없을 경우 예외 처리.
					ex.printStackTrace();
					System.out.println("환율 정보 x");
					rat="정보가 없습니다";
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
			sql.insert("crawl.insertCrawlA1",cwa1Vo);//DB삽입
		}
		conn.eval("remDr$close()");
		conn.close();
		return "/Crawl/doCrawla1";
	}
	
	/*Crawl_A1 : 기본 정보 (네이버) > 출력*/
	@RequestMapping("showCrawla1.mw")
	public String showCrawla1(HttpServletRequest request) throws Exception{
		String clickCont = request.getParameter("cont");
		System.out.println("[showA1] "+clickCont);
		
		CrawlA1VO vo = sql.selectOne("crawl.getCrawlA1Click",clickCont);
		request.setAttribute("vo", vo);
		return "/Crawl/showCrawla1";
	}	

}
