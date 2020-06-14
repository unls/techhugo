git add -A
set COMMIT_NAME=
set /P COMMIT_NAME="コミット名を入力してください: "
git commit -m "%COMMIT_NAME%"
git push origin -u master