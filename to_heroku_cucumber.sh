tar czf features.tar.gz features/
git add .
git commit -m "$1" -a
git push heroku master
bundle exec cucumber features
if ($2 == "git")
then
  git push origin master &
fi
