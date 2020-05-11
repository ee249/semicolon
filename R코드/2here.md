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

