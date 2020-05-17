# 크롤링 by 수이

### 이마트 크롤링(동적크롤링) - 서울만

```R
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url <- "https://store.emart.com/branch/list.do"
remDr$navigate(url)
seoulbtn <- remDr$findElement(using='css','#area_A > a')
seoulbtn$clickElement()
storebtn <- remDr$findElement(using='css','#branchType > option:nth-child(2)')
storebtn$clickElement()


#branchList > li:nth-child(1)
#branchList > li:nth-child(1) > a
#branchList > li:nth-child(17) > a
#branchList > li:nth-child(29) > a
#주소
#conts > div > div.map-wrap > div.branch-info > div.branch-info1 > ul > li:nth-child(2) > dl > dd:nth-child(2)
repl<-NULL
sname <- NULL
saddr <- NULL
for (i in 1:30) {
  css2<-paste0('#branchList > li:nth-child(', i ,') > a')
  storename<-remDr$findElement(using ="css selector",css2)
  storename$clickElement()
  Sys.sleep(2)
  css3 <- '#conts > div > div.store-intro > div.store-header > h2'
  css4 <- ' #conts > div > div.map-wrap > div.branch-info > div.branch-info1 > ul > li:nth-child(2) > dl > dd:nth-child(4)'
  storeaddr<-remDr$findElements(using ="css selector",css3)
  repl3 <-sapply(storeaddr,function(x){x$getElementText()})
  #print(repl3)
  sname<-rbind(sname, unlist(repl3))
  storeaddr<-remDr$findElements(using ="css selector",css4)
  repl4 <-sapply(storeaddr,function(x){x$getElementText()})
  #print(repl4)
  saddr<-rbind(saddr, unlist(repl4))
}

df <- data.frame(cbind(sname, saddr))
write.csv(df, "emart.csv")
getwd()
```





## 신세계 백화점 크롤링(정적크롤링) - 전지점

### SC00001 ~ SC00013 (SC00004 제외)

```R
library(httr)
library(rvest)
library(XML)
addrxpath <- '//*[@id="STORE_LOCATION"]/div[2]/div[2]/div[1]/div[2]/span/text()'
namexpath <- '//*[@id="STORE_COMMON_INFO"]/ul/li[1]/div[1]/div/span'
dname <- NULL
daddr <- NULL
for(i in 1:3){
  mainurl <- paste0('https://www.shinsegae.com/store/main.do?storeCd=SC000',sprintf("%02d", i))
  doc <- GET(mainurl, add_headers("Content_Type" = "application/xml"))
  doc2 <- htmlParse(doc, encoding="UTF-8")
  #백화점 명
  tmp1<-  gsub(pattern = " ", replacement = "", x = xpathSApply(doc2, namexpath, xmlValue))
  dname <-rbind(dname, tmp1)
  #주소
  tmp2<- xpathSApply(doc2, addrxpath, xmlValue)
  daddr<-rbind(daddr, tmp2)
}

for(i in 5:13){
  mainurl <- paste0('https://www.shinsegae.com/store/main.do?storeCd=SC000',sprintf("%02d", i))
  doc <- GET(mainurl, add_headers("Content_Type" = "application/xml"))
  doc2 <- htmlParse(doc, encoding="UTF-8")
  #백화점 명
  tmp1<-  gsub(pattern = " ", replacement = "", x = xpathSApply(doc2, namexpath, xmlValue))
  dname <-rbind(dname, tmp1)
  #주소
  tmp2<- xpathSApply(doc2, addrxpath, xmlValue)
  daddr<-rbind(daddr, tmp2)
}

df2<- data.frame(cbind(dname, daddr))
write.csv(df2, "ssgd.csv")
```



## GS편의점(동적크롤링) - 서울만

```R
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url <- 'http://gs25.gsretail.com/gscvs/ko/store-services/locations'
remDr$navigate(url)
seoulgs <- remDr$findElement(using='css','#stb1 > option:nth-child(2)')
seoulgs$clickElement()
Sys.sleep(2)
#pagingTagBox > a.next
#pagingTagBox > a.next
gsnamelist <- NULL
gsaddrlist <- NULL
for(i in 1:599){ #page
  for(j in 1:5){ #list
    #매장명
    gs1 <- paste0('#storeInfoList > tr:nth-child(',j,') > td:nth-child(1) > a')
    gsname<-remDr$findElements(using ="css selector",gs1)
    gsname <-sapply(gsname,function(x){x$getElementText()})
    gsnamelist <- rbind(gsnamelist, gsname)
    

    gs2 <- paste0('#storeInfoList > tr:nth-child(',j,') > td:nth-child(2) > a')
    gsaddr<-remDr$findElements(using ="css selector",gs2)
    gsaddr <-sapply(gsaddr,function(x){x$getElementText()})
    gsaddrlist <- rbind(gsaddrlist, gsaddr)

  }
  nextbtn <- remDr$findElement(using='css','#pagingTagBox > a.next')
  nextbtn$clickElement()
  Sys.sleep(2)
}

df3 <- data.frame(unlist(gsnamelist), unlist(gsaddrlist))
write.csv(df3, "gs.csv")
```







## 세븐일레븐(동적크롤링) - 서울만

```R
url <- "http://www.7-eleven.co.kr/"
remDr$navigate(url)

#점포찾기 메뉴 버튼 클릭
findcss<- '#header > div > div > div.head_util > a.util_store.store_open'
findbtn <- remDr$findElement(using='css',findcss)
findbtn$clickElement()
Sys.sleep(2)

#서울시 xx구 css
gucss <-'#storeLayGu'
#구리스트 뽑아오기
gulist <- remDr$findElements(using='css',gucss)
gulist <-sapply(gulist,function(x){x$getElementText()})
gulist <- unlist(strsplit(unlist(gulist), '\n'))[-1]
length(gulist) #25
gulist[1]

seven11name <- NULL
seven11addr <- NULL
for(i in 2:26){
  print(gulist[i])
  #구별 검색
  gu <- paste0('#storeLayGu > option:nth-child(',i,')')
  gubtn <- remDr$findElement(using='css',gu)
  gubtn$clickElement()
  Sys.sleep(2)
  #검색 버튼 css
  scss <- '#storeButton1'
  searchbtn <- remDr$findElement(using='css',scss)
  searchbtn$clickElement()
  Sys.sleep(2)
  #리스트 첫번째 원소
  #매장명
  slist <- '#storeForm > div:nth-child(4) > div.list_stroe > ul > li > a'
  slist <- remDr$findElements(using='css',slist)
  slist <- sapply(slist,function(x){x$getElementText()})
  strsplit(unlist(slist), '\n')->slist

  seven11name <- rbind(data.frame(seven11name), data.frame(sapply(slist, function(x){x[1]})))
  seven11addr <- rbind(data.frame(seven11addr), data.frame(sapply(slist, function(x){x[2]})))

}
df4 <- data.frame(seven11name, seven11addr)
write.csv(df4, "seven11_2.csv")
```



# 이디야(강서구, 중구 제외)

강서구, 중구 => 세미님

```R


#gugu <- c("강남구","강동구","강북구", "강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구",
#          "동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구", "용산구","은평구", 
#          "종로구","중구",  "중랑구")
gugu <- c("강남구","강동구","강북구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구",
          "동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구", "용산구","은평구", 
          "종로구","중랑구")

length(gugu)

eurl <- 'https://www.ediya.com/contents/find_store.html'
remDr$navigate(eurl)



ediyalist <- NULL
for(i in 1:24){
  #storename
  jusotab <- '#contentWrap > div.contents > div > div.store_search_pop > ul > li:nth-child(2) > a'
  jusotab <- remDr$findElement(using='css',jusotab)
  jusotab$clickElement()
  
  guname <- gugu[i]
  webElem <- remDr$findElement(using = 'css', "input[id='keyword']")
  webElem$sendKeysToElement(list(guname))
  searchbtn <- '#keyword_div > form > button'
  searchbtn <- remDr$findElement(using='css',searchbtn)
  searchbtn$clickElement()
  Sys.sleep(2)
  plist <- '#placesList'
  plist <- remDr$findElements(using='css',plist)
  plist <- sapply(plist,function(x){x$getElementText()})
  strsplit(unlist(plist), '\n') -> elist
  unlist(elist) -> elist
  length(elist) -> elen
  elist[1:elen*2] -> col2
  elist[1:elen*2-1] -> col1
  
  ediyalist <- rbind(ediyalist,data.frame(name = col1[!is.na(col1)], addr = col2[!is.na(col2)]))
}

write.csv(ediyalist, "ediya1.csv")
View(ediyalist)
```



# 롯데마트(서울만)

```R
# 서브 페이지에 데이터가 있을 경우에 메인페이지에서 태그를 못찾음.
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
#main URL
url1 <- 'https://company.lottemart.com/bc/branch/main.do'
remDr$navigate(url1)
#iframe URL(참고용)
url2 <- 'https://company.lottemart.com/bc/branchSearch/branchSearch.do?schBrnchTypeCd=BC0701'
#전국 - 서울 클릭
remDr$findElement(using='css','#txtRegnNm')$clickElement()
Sys.sleep(2)
remDr$findElement(using='css','#inpBC0101')$clickElement()
Sys.sleep(2)
# 페이지 변경 src
# 하이퍼링크 -> onClick 일경우
src <- "if($('#inpSchBrnchNm').val() == '주소 또는 지점명'){
		$('#inpSchBrnchNm').val('');
	}
	
	$('#inpPageIndex').val(arguments[0]);
	$('#frmDefault').attr({'action': '/bc/branchSearch/branchSearch.do', 'target': 'ifrmContentsNm', 'method': 'get'}).submit();
	
	if($('#inpSchBrnchNm').val() == ''){
		$('#inpSchBrnchNm').val('주소 또는 지점명');
	}
"
slist <- NULL
for(i in 1:3){ # 페이지수
  #페이지 클릭
  #main switch
  remDr$switchToFrame(NULL)
  #i = arguments[0] = page
  remDr$executeScript(src,list(toString(i)))
  #RSelenuim manpage 사용법
  #webElem <- remDr$findElement(using = "name", value = "contents")
  #remDr$switchToFrame(webElem$elementId)
  #webElem$elementId 값이 갱신.
  #0으로 하드코딩해서 쓰기로 함.
  #iframe 으로 Switch
  remDr$switchToFrame(0)
  #지점명
  slist2 <- remDr$findElements(using='css', '#contents > ul > li> div > div.article1 > h3')
  slist2 <- sapply(slist2,function(x){x$getElementText()})
  slist2 <- unlist(slist2)
  #지점주소
  slist3 <- remDr$findElements(using='css', '#contents > ul > li > div > div.article2 > ul:nth-child(4) > li:nth-child(1)')
  slist3 <- sapply(slist3,function(x){x$getElementText()})
  slist3 <- gsub("신\n","",slist3)
  slist <- rbind(slist, data.frame(slist2, slist3))
  Sys.sleep(3)
}
write.csv(slist, "lottmart.csv")
```

