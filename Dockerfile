FROM rubylang/ruby:2.6.0-bionic

RUN apt update && apt install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libmysqlclient-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev yarn netcat curl

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

RUN mkdir /app

WORKDIR /app

RUN gem install bundler

COPY Gemfile ./

RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["sh", "./config/docker/startup.sh"]
