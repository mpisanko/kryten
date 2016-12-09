FROM elixir:1.3-slim

ADD . /app
WORKDIR /app
RUN mix local.hex --force && mix local.rebar --force && mix do deps.get compile

EXPOSE 3000

CMD mix run --no-halt
