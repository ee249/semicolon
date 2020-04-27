## Git 정리

1. [setting] -> [invite a collaborator] 를 누르면 받은 사람은 각자 email에 가서 승인을 누른 후 Fork를 눌러 본인 git에 복제를 해야 합니다. 
2. master는 각 기능별로 issue를 생성합니다.
3. collaborator들은 해당 issue 기능 번호로 [branch]를 만들어서 각자의 repository에 작업을 한 후 완료하면 master에게  [pull request]를 한다.
4. master는 [pull request]를 확인한 후 합친다

1. 브랜치 만들기 (id-issue#)
student@M1504 MINGW64 ~/Desktop/semicolon (master)
$ git branch sui-3

2. 해당 브랜치로 이동하기
student@M1504 MINGW64 ~/Desktop/semicolon (master)
$ git checkout sui-3
Switched to branch 'sui-3'

3. 테스트용 텍스트 파일 만들기
student@M1504 MINGW64 ~/Desktop/semicolon (sui-3)
$ touch file1.txt

4. 깃 스테이지에 올리기
student@M1504 MINGW64 ~/Desktop/semicolon (sui-3)
$ git add .

5. 깃 커밋하기
student@M1504 MINGW64 ~/Desktop/semicolon (sui-3)
$ git commit -m "create file1.txt"
[sui-3 2a5d9c7] create file1.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file1.txt

6. 깃 원격저장소(origin) 푸쉬하기 
student@M1504 MINGW64 ~/Desktop/semicolon (sui-3)
$ git push origin sui-3
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 255 bytes | 255.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote:
remote: Create a pull request for 'sui-3' on GitHub by visiting:
remote:      https://github.com/k1msu2/semicolon/pull/new/sui-3
remote:
To https://github.com/k1msu2/semicolon.git

