## here? here!

#### 동적크롤링

- 9호선 노선도(웹페이지 크롤링-다음) : 주소 위치가 다르기 때문에 주소만 가져오지 못함(실패)

```R
install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url<-"https://search.daum.net/search?w=tot&q=%EC%84%9C%EC%9A%B8%20%EA%B0%9C%ED%99%94%EC%97%AD&rtmaxcoll=SUB&scckey=1C||SES0901&DA=BBL"
remDr$navigate(url)
Sys.sleep(3)
pageLink <- NULL
reple_v <- NULL

repeat{
  try(nextSite <- remDr$findElement(using='css', '#subwaystationColl > div.coll_cont > div > div.subway_line.line_s9 > dl.next > dd > a'))
  if(length(nextSite) == 0) break;
  nextSite$clickElement()
  Sys.sleep(1)
  doms1 <- remDr$findElements(using = "css","#subwayStationBody_0 > div > div > dl:nth-child(4) > dd")
  reple <-sapply(doms1,function(x){x$getElementText()})
  reple_v <- c(reple_v, unlist(reple))
}
print(reple_v)
```



- 9호선 노선도(웹페이지 크롤링 - 메트로9 홈페이지)(성공)

```R
# 웹 크롤링과 스크래핑

install.packages("rvest") 
library(rvest)

url <- "https://search.daum.net/search?w=tot&q=%EC%84%9C%EC%9A%B8%20%EA%B0%9C%ED%99%94%EC%97%AD&rtmaxcoll=SUB&scckey=1C||SES0901&DA=BBL"
text <- read_html(url)
text #페이지 소스를 가지고 온다.
str(text)

nodes <- html_nodes(text, "#subwaystationColl > div.coll_cont > div > div.subway_line.line_s9 > div.wrap_station > strong > span.f_l")
nodes
title <- html_text(nodes) #content 읽어주는 함수이다.->vector로 리턴해준
title

node1 <- html_nodes(text, "#subwayStationBody_0 > div > div > dl:nth-child(4) > dd")
node1
juso <- html_text(node1)
juso

install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url<-"https://www.metro9.co.kr/site/program/station/info?menuid=001001002&station_code=901"
remDr$navigate(url)
Sys.sleep(3)
reple_v <- NULL
reple_v0 <- NULL
reple_v1 <- NULL

for(i in 1:38){
  nextCss <- paste("#content > div.station_div > div.st_choise > div > ul > li:nth-child(",i,") > a", sep="") 
  # #content > div.station_div > div.st_choise > div > ul > li:nth-child(38) > a
  try(nextSite <- remDr$findElement(using='css', nextCss))
  if(length(nextSite) == 0) break;
  nextSite$clickElement()
  Sys.sleep(1)
  doms0 <- remDr$findElements(using = "css",'#content > div.station_div > div > p > span')
  doms1 <- remDr$findElements(using = "css",'#content > div.inner > div.table_type_h1.mt2 > table > tbody > tr > td:nth-child(5)')
  reple0 <-sapply(doms0,function(x){x$getElementText()})
  reple1 <-sapply(doms1,function(x){x$getElementText()})
  reple_v0 <- c(reple_v0,unlist(reple0))
  reple_v1 <- c(reple_v1,unlist(reple1))
}
print(reple_v0)
print(reple_v1)

reple_d <- data.frame(reple_v0,reple_v1)
names(reple_d) <- c("역이름","도로명")
View(reple_d)
write.csv(reple_d, file="data/ninetrain.csv")

```



- ministop(웹페이지 크롤링, ministop 홈페이지)

```R
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url<-"https://www.ministop.co.kr/MiniStopHomePage/page/store/store.do"
remDr$navigate(url)

pageLink_S <- NULL
pageLink_s1 <- NULL
reple_v <- NULL
reple_v0 <- NULL

Sys.sleep(2)
pageLink_S <- remDr$findElement(using='css', "#area1 > option:nth-child(2)")
pageLink_S$clickElement()
Sys.sleep(2)
pageLink_S1 <- remDr$findElement(using='css', "#section > div.inner.wrap > div > div.store_content > div.store_txt > div.area > a") 
pageLink_S1$clickElement()

for(i in 0:399){
  connect <- paste0("#section > div.inner.wrap > div > div.store_content > div.store_txt > div.area > ul > li:nth-child(",i,")")
  # #section > div.inner.wrap > div > div.store_content > div.store_txt > div.area > ul > li:nth-child(399)
  doms0 <- remDr$findElements(using="css",connect)
  reple0 <-sapply(doms0,function(x){x$getElementText()})
  print(reple0)
  reple_v0 <- c(reple_v0,unlist(reple0))
}

value <- data.frame(reple_v0)
Vi(reple_v0)
str(value)
value2 <- strsplit(reple_v0,'\n')
data1 <-sapply(value2, function(x){x[1]})
data2 <- sapply(value2, function(x){x[2]})

write.csv(data.frame(data1,data2),file="data/ministop2.csv")
```



- 롯데시네마

```R
# 롯데시네마 페이지 들어가기

library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url<-"https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=%EB%A1%AF%EB%8D%B0%EC%8B%9C%EB%84%A4%EB%A7%88"
remDr$navigate(url)
Sys.sleep(3)
pageLink <- NULL
title <- NULL
jijum <- NULL

doms0 <- remDr$findElements(using = "css selector", "#main_pack > div.content_search.section._movie_theater > div > div.contents03_sub._theater_search_container > div > div._wrap_list_type > div > div._wrap_theater_list > div.mvhu_list._wrap_not_empty > table > tbody > tr > th > span > a")
doms1 <- remDr$findElements(using = "css selector", "#main_pack > div.content_search.section._movie_theater > div > div.contents03_sub._theater_search_container > div > div._wrap_list_type > div > div._wrap_theater_list > div.mvhu_list._wrap_not_empty > table > tbody > tr > td  > span")
Sys.sleep(1)
reple_v0 <- sapply(doms0, function (x) {x$getElementText()})
reple_v1 <- sapply(doms1, function (x) {x$getElementText()})
title <- append(title, unlist(reple_v0))
jijum <- append(jijum, unlist(reple_v1))

for(i in 1:4){
  print("1")
  b_tn <- remDr$findElement(using='css', "#main_pack > div.content_search.section._movie_theater > div > div.contents03_sub._theater_search_container > div > div._wrap_list_type > div > div._wrap_theater_list > div.mvhu_list._wrap_not_empty > div > div > a.nxt._btn_next.on")
  b_tn$clickElement()
  print("2")
  Sys.sleep(2)
  
  doms0 <- remDr$findElements(using = "css selector", "#main_pack > div.content_search.section._movie_theater > div > div.contents03_sub._theater_search_container > div > div._wrap_list_type > div > div._wrap_theater_list > div.mvhu_list._wrap_not_empty > table > tbody > tr > th > span > a")
  doms1 <- remDr$findElements(using = "css selector", "#main_pack > div.content_search.section._movie_theater > div > div.contents03_sub._theater_search_container > div > div._wrap_list_type > div > div._wrap_theater_list > div.mvhu_list._wrap_not_empty > table > tbody > tr > td  > span")  
   Sys.sleep(1)
  reple_v0 <- sapply(doms0, function (x) {x$getElementText()})
  reple_v1 <- sapply(doms1, function (x) {x$getElementText()})
  title <- append(title, unlist(reple_v0))
  jijum <- append(jijum, unlist(reple_v1))
}

data <- data.frame(title,jijum)
names(data) <- c("지점","도로명")
View(data)
write.csv(data,file="data/lotteC.csv")
```



- 할리스커피

\- 다음페이지가 고정이고 1, 2, 3, ... 9, 10을 누른뒤 >를 누르면 11로 이동하고 또 다시 12,13, ... ,16이렇게 진행

```R
# 할리스 페이지 들어가기
library(RSelenium)
remDr<-remoteDriver(remoteServerAddr= "localhost",port = 4445, browserName= "chrome")
remDr$open()
remDr$navigate("http://www.hollys.co.kr/store/korea/korStore.do?pageNo=1&sido=%EC%84%9C%EC%9A%B8&gugun=&store=")


title <- NULL 
jijum <- NULL
Andflag <- TRUE // for문에서 나오기 위해서 만듬

#지역 클릭
search <- list()
search<- remDr$findElement(using='id',"mySelect1")
search$clickElement()
Sys.sleep(1)

#서울지역으로 클릭
seoul<- remDr$findElement(using='css',"#mySelect1 > option:nth-child(2)")
seoul$clickElement()
Sys.sleep(1)


doms0 <- remDr$findElements(using = "css selector","#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(2) > a")
doms1 <- remDr$findElements(using = "css selector", "#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(4) > a")

reple_v0 <- sapply(doms0, function (x) {x$getElementText()})
reple_v1 <- sapply(doms1, function (x) {x$getElementText()})

title <- append(title, unlist(reple_v0))
jijum <- append(jijum, unlist(reple_v1)) 

for(j in 1:2){
 for(i in 3:11){
    
    nextCss <- paste0("#contents > div.content > fieldset > div.paging > a:nth-child(",i,")")
    nextbtn <- NULL
    try(nextbtn <- remDr$findElement(using='css', nextCss) , silent=TRUE)
    if(is.null(nextbtn)){
      print(nextbtn)
      Andflag <- FALSE
      break;
    } 
    
    nextbtn$clickElement()
    
    doms0 <- remDr$findElements(using = "css selector", "#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(2)")
    doms1 <- remDr$findElements(using = "css selector", "#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(4) > a")
    
    reple_v0 <- sapply(doms0, function (x) {x$getElementText()})
    reple_v1 <- sapply(doms1, function (x) {x$getElementText()})
    
    title <- append(title, unlist(reple_v0))
    jijum <- append(jijum, unlist(reple_v1)) 
    
 }
  
  if(Andflag == FALSE) break; 
  
  nextPage<-remDr$findElement(using='css',
                              "#contents > div.content > fieldset > div.paging > a:nth-child(12) > img")
  nextPage$clickElement()
  Sys.sleep(1)
  
  doms0 <- remDr$findElements(using = "css selector","#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(2) > a")
  doms1 <- remDr$findElements(using = "css selector", "#contents > div.content > fieldset > div.tableType01 > table > tbody > tr > td:nth-child(4) > a")
  
  reple_v0 <- sapply(doms0, function (x) {x$getElementText()})
  reple_v1 <- sapply(doms1, function (x) {x$getElementText()})
  
  title <- append(title, unlist(reple_v0))
  jijum <- append(jijum, unlist(reple_v1)) 
}


data <- data.frame(title, jijum)
names(data) <- c("지점","도로명")
View(data)
write.csv(data,file="data/hs.csv")

```

