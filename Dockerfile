FROM hexalink_blog_base:latest AS build

WORKDIR /opt/nguyenvinhlinh.github.io
COPY . /opt/nguyenvinhlinh.github.io

RUN bundle exec jekyll build --destination=/opt/nguyenvinhlinh.github.io/dist

FROM scratch AS release
COPY --from=build  /opt/nguyenvinhlinh.github.io/dist /
