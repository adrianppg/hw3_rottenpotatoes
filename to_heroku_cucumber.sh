git add .
git commit -m "$1" -a
git push heroku master
bundle exec cucumber features $2
#git push origin master &
