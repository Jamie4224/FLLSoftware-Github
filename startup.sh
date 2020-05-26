#!/bin/bash
git clone -b master https://$TOKEN:x-oauth-basic@github.com/Jamie4224/FLLSoftware.git /repo/
cp -R /repo/* /usr/src/app/repository/

cp /config/.env /usr/src/app/repository/web


chown app:app -R /usr/src/app/repository/

cd /usr/src/app/repository/web

composer install --optimize-autoloader --no-dev

npm install
npm run production

php artisan config:cache

echo "Done."