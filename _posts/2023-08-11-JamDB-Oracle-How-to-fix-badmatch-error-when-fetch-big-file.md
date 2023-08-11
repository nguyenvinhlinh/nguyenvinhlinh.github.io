---
layout: post
title: "JamDB Oracle - How to fix :badmatch error when fetch big file?"
date: 2023-08-11 11:08:47
update:
location: Saigon
tags:
- oracle
- jamdb_oracle
categories: Elixir
seo_description: jamdb_oracle, :badmatch error when fetching big file from oracle database
seo_image: /image/posts/2023-08-11-JamDB-Oracle-How-to-fix-badmatch-error-when-fetch-big-file/1.png
comments: true
---

{% include image.html url="/image/posts/2023-08-11-JamDB-Oracle-How-to-fix-badmatch-error-when-fetch-big-file/1.png" description="JamDB Oracle: :badmatch error" %}

Example error:
{% highlight elixir %}
iex(2)> App.OracleRepo.get(App.BigBigBigDocument, 3573564)
** (DBConnection.ConnectionError) {:badmatch, <<253, 249, 243, 207, 63, 219, 35, 182, 23, 177, 72, ...>>}
    (ecto_sql 3.8.3) lib/ecto/adapters/sql.ex:932: Ecto.Adapters.SQL.raise_sql_call_error/1
    (ecto_sql 3.8.3) lib/ecto/adapters/sql.ex:847: Ecto.Adapters.SQL.execute/6
    (ecto 3.8.4) lib/ecto/repo/queryable.ex:221: Ecto.Repo.Queryable.execute/4
    (ecto 3.8.4) lib/ecto/repo/queryable.ex:19: Ecto.Repo.Queryable.all/3
    (ecto 3.8.4) lib/ecto/repo/queryable.ex:147: Ecto.Repo.Queryable.one/3
iex(2)> {"level":"error","message":"Jamdb.Oracle (#PID<0.889.0>) disconnected: ** (DBConnection.ConnectionError) {:badmatch, <<253, 249, 243,  173, 123, 177, 72, ...>>}","timestamp":"2023-08-11T03:51:46.563Z"}
{% endhighlight %}

Solution:  Add connection parameter named `:read_timeout` in repo config. In the follow example, I change `:read_timeout` to 5 minutes, **see line 11**.
Besides, I add `:timeout` to `:infinity`, **see line 10**.

{% highlight elixir linenos %}
config :app, App.OracleRepo,
  hostname: "******",
  port: 1521,
  database: "******",
  username: "******",
  password: "******",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  timeout: :infinity,
  parameters: [ read_timeout: :timer.minutes(5)]
{% endhighlight %}
