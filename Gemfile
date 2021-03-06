source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails',                      '6.0.3'
gem 'bcrypt',                     '3.1.15'
gem 'bootstrap',                  '4.5.2'
gem 'jquery-rails',               '4.4.0'
gem 'puma',                       '4.3.4'
gem 'sassc-rails',                '2.1.2'
gem 'autoprefixer-rails',         '9.8.6.5'
gem 'webpacker',                  '4.0.7'
gem 'turbolinks',                 '5.2.0'
gem 'jbuilder',                   '2.9.1'
gem 'bootsnap',                   '1.4.5', require: false
gem 'kaminari',                   '1.2.1' #ページネーション用
gem 'bootstrap4-kaminari-views',  '1.0.1'
gem 'faker',                      '2.15.1'#ダミーデータ作成用
gem 'rails-i18n',                 '6.0.0' #他言語化gem
gem 'gimei',                      '0.5.1' #日本語版faker
gem 'gon'                          #js内でインスタンス変数を使うためのgem
gem 'geocoder',                   '1.6.4' #ジオコーディング用
gem 'carrierwave',                '2.1.0' #画像アップロード用g
gem 'fog-aws',                    '3.8.0' #本番環境の画像保存場所でawsを使えるようにするgem
gem 'mini_magick',                '4.11.0'#画像のリサイズ用

group :development, :test do
  gem 'sqlite3',            '1.4.1'
  gem 'byebug',             '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',        '4.0.1'
  gem 'factory_bot_rails',  '6.1.0'
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
end

group :production do
  gem 'pg', '1.1.4'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]