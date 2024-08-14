FROM ruby:3.3.4 as build

WORKDIR /opt/nguyenvinhlinh.github.io
COPY . /opt/nguyenvinhlinh.github.io

RUN bundle config set --local deployment true
RUN bundle install
RUN bundle exec jekyll build --destination=/opt/nguyenvinhlinh.github.io/dist

FROM scratch as release
COPY --from=build  /opt/nguyenvinhlinh.github.io/dist /
