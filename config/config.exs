use Mix.Config

config :excoder, Excoder,
  ip: "127.0.0.1",
  port: 3025,
  pool_size: 8

config :porcelain, goon_warn_if_missing: false
