FROM ruby:3.2.2

RUN apt-get update && \
    apt-get install -y nodejs && \
    gem install bundler && \
    echo 'gem: --no-document' > /root/.gemrc

WORKDIR /challenge

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 8

COPY . .

EXPOSE 3000

CMD ["script/init_local"]
