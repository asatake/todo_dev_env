FROM centos:centos7
LABEL manome <manome@axelmark.co.jp>
ARG TZ=Asia/Tokyo

RUN yum update -y && yum clean all
RUN yum reinstall -y glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";

# ENV
ENV LANG ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
CMD date

# middleware
WORKDIR /usr/local/src
RUN yum install -y gcc gcc-c++ make openssl-devel ncurses-devel && yum clean all
RUN yum install -y epel-release.noarch && yum clean all
RUN yum install -y http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_18.1-1~centos~7_amd64.rpm && yum clean all
RUN yum install -y sudo wget git tar bzip2 incron vim nodejs npm && yum clean all
RUN yum install -y mysql && yum clean all

# Erlang
RUN yum install -y ncurses ncurses-devel && yum clean all
RUN wget http://erlang.org/download/otp_src_19.0.tar.gz
RUN tar zxvf otp_src_19.0.tar.gz
WORKDIR /usr/local/src/otp_src_19.0
RUN ./configure
RUN make
RUN sudo make install

# Elixir
ENV ELIXIR_VERSION 1.4.4
WORKDIR /usr/local/src
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /usr/local/src/elixir
RUN git checkout refs/tags/v${ELIXIR_VERSION}
RUN make clean install

# todo
RUN mix new todo --sup
COPY ./src/todo/mix.exs /srv/src/todo/mix.exs
WORKDIR /srv/src/todo
RUN mix local.hex --force
RUN yes | mix local.rebar
RUN yes | mix deps.get
RUN mix ecto.gen.repo -r Todo.Repo
RUN mix ecto.gen.repo -r Todo.TestRepo
COPY ./src/todo/config/config.exs /srv/src/todo/config/config.exs
COPY ./src/todo/lib/todo/application.ex /srv/src/todo/lib/todo/application.ex
COPY ./src/todo/lib/todo/schema.ex /srv/src/todo/lib/todo/schema.ex
RUN mix ecto.gen.migration create_list -r Todo.Repo
RUN mix ecto.gen.migration create_list -r Todo.TestRepo
RUN rm /srv/src/todo/priv/repo/migrations/*.exs
RUN rm /srv/src/todo/priv/test_repo/migrations/*.exs
COPY ./src/todo/priv/repo/migrations/* /srv/src/todo/priv/repo/migrations/20170101000000_create_list.exs
COPY ./src/todo/priv/test_repo/migrations/* /srv/src/todo/priv/test_repo/migrations/20170101000001_create_list.exs
COPY ./src/todo/lib /srv/src/todo/lib
ENTRYPOINT mix ecto.create && mix ecto.migrate && mix compile && mix run --no-halt
