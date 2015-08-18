class { '::gerrit::mysql':
  mysql_root_password => 'UNSET',
  database_name       => 'reviewdb',
  database_user       => 'gerrit2',
  database_password   => '12345',
}

class { '::gerrit':
  mysql_host                            => 'localhost',
  mysql_password                        => '12345',
  war                                   => 'http://tarballs.openstack.org/ci/gerrit/gerrit-v2.10.2.23.039a170.war',
  ssh_rsa_key_contents                  => '-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA4TpMJO2s7dMPle1tUccvxszQqfHo5TU8HZcZv+E8rcvMAo8L
qCXOyTKVLyuVxWWhfsWeAukgCpUrYDl3UlC5MB9O6HVFE60Ku2eEacHAkfE1bH0m
NRevl9JiK2WzEBZya3WcqeSs7w966zOoRc94ExGU+/CCGYzdCu7BOM7jGtShFmI/
0pGP9MhhYhjkMM5NOh7r8opeoOqierCk0mlIgXqpky8xmUiuYj6biaME4KrUL2O1
PWdN2nvWbfD7wJbfoLA0hhF9btOjoYoGAHOWGojK+5hinG4Y8w1DsJIFKThncvBP
wW3Mm3/54hBiUvBNA/ohhUdb3WItlSheOeG2aQIDAQABAoIBAQCQhl4yHCmpepQ3
uuE5Zr2rreYAB3FRE3X97uXhEOFlDK9evPfX8FrfFIxSdn9m6a5VsO2SJJIg+FOb
LYT51z7eOFjkJcwrshB+7RA05NVzUPrdIPmRfB97Js9D1cCvhBfsCM583nZx+NcB
cmZ6VYVRhyi4+j4hsxhsWYS3tVpZ7f8VelpPLWlHTfl81njyiAf1PpSiiIfsmHmf
cRjLCGAoWMmUO5U8zWXj2woUteUqKFfu/XEIxjMr4Hst8HoceyaQlpcrAo86WPKn
AOcFx0ZP3GQNVHupCXQj236KO3/qJ4qFEWu4bLKDzmigCEAE0k1HJOcAvNRH0nMM
CHbnVo75AoGBAPfeLKWnrG886ro0L/DvphQX6V03mwC9S5aVCjGyX8RQASMDIMKx
q0Q5CD8GHNyXnp7tXmpD+8AdjG3sa5acA7wrDxesCIxtaQ96UfpyA2omEf964rF7
WFHdF4P/AuIAoA9AtFxtZfacXr15piDTBmjuBs/puyh5/R5QzPSCKCoPAoGBAOid
+FDBmMCbFs8bmWnUyHcYgKotexgrVBvui60EAO0GuSCaw13SNSttvR/4Sv0NXqSp
XUe46RBySyB9QxD8EtiV/sNO7VPV0TTWOPhjmvc06cyAt/mJLEs/Z8BdaBFDgTht
rAoPQKNPS6BGd2FIFxI1FJRaKF+Hu29JcvpLfnAHAoGBAIlV+LbwaIJZ5lS1hbqh
jgukFBEqNh/6wl70xWkzxAwpp/eWTBiUCKkMUJ1a7bLr719vddi7Qkn4FU7yp8oT
N56S3RHop/Pmy0dgJvv1IB84aNB9bg2Yoh75uYXRTe+bGRRabZSoqM4zZerl9D5L
rkmFWRDqGGEc9jpN2sG/PDHRAoGADss9J6WoWVeDs9hFgX2O4kQkqq4JzhezWbNq
Hq7KgEiVLYWqNyVPTFvGU2ovGrjm9AHxdMZFzE34iTBuO35MlIm1kiZK4bIPhBS7
utBa4q3y0Ja/HJekwYRezNUj8TUh2rze3CTsL3azkJXqsb0r+nR1wpmZR7oSKZm6
PkDe4bECgYBg6Qa0ytWvvHg7JED5Vx8QZM7SPAHciaAHzmImJpYgbDO0yvOMNpJT
s/QwR0gUHWRa5LJ66U66r8cAD/8EkSe+x1NC9SBhzjpWdQ1eLBxpu/xEouCSNXU+
j4sAEVqdkfOfD5huZxzp7qz9R2kdpCXu0tXqbyVPkU4QbW2OHAy9WA==
-----END RSA PRIVATE KEY-----',
  ssh_rsa_pubkey_contents               => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhOkwk7azt0w+V7W1Rxy/GzNCp8ejlNTwdlxm/4Tyty8wCjwuoJc7JMpUvK5XFZaF+xZ4C6SAKlStgOXdSULkwH07odUUTrQq7Z4RpwcCR8TVsfSY1F6+X0mIrZbMQFnJrdZyp5KzvD3rrM6hFz3gTEZT78IIZjN0K7sE4zuMa1KEWYj/SkY/0yGFiGOQwzk06Huvyil6g6qJ6sKTSaUiBeqmTLzGZSK5iPpuJowTgqtQvY7U9Z03ae9Zt8PvAlt+gsDSGEX1u06OhigYAc5YaiMr7mGKcbhjzDUOwkgUpOGdy8E/Bbcybf/niEGJS8E0D+iGFR1vdYi2VKF454bZp user@machine',
  ssh_project_rsa_key_contents          => '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAu4Yr4dpNjY3+64ZdmxaApzd9KOQCSwQ5E0j/PyR2f2XnQdvC
LGohu0JNcfGgE+hTMWealwVbvq3sQAOU7E1djRK3blCo5U7xgmC8lD7llsbbEv25
uckYrxyJvur4ZAAHSyjzTFIAbAos/kNR5hxDMgn8IR/mjmYArAOGHgT7STzNH+LU
lTP3v6mjLnk52dIfJYYQNq2qQvDybgPJaMP8Xn8z+zHKqYkZ9vQwhS8fxDhAIw+V
XMUMiSm2oNj7cdAlmWAaXVYVMlEa2TLim5t7o7DXMT+6f/YUusZNE5TFYJk6y+Z2
JtMzz+BMrEuXuI6kQi5SF+VXAPD/Yn3MCo73YQIDAQABAoIBACKImeo0zpVj8e8j
xnc6FKU2tcji/H0eIPipN8BEEcJyXL0nIEIXpXCbzDFQov8niLKPdsubBANAekJr
pnBB6xmAueEJ36CjAhzVfcT7NEKpCk0cBqjtHKua4M8U7HtV+gHgX7XNYCCFWzXT
5fAvgjxj1FexTT8qD7OdzoQWvMQGqpLEyp8L0zie7/FxKfmH/arcncFRZ1+cj3lO
TqiwTpvFuyfr0b0gkpmzhB8L1VYMQxIJk6D+5SgJKrG96IhEaf2Jvxn5Lz0OoKdQ
CmEHpUbJkghA9OIG+U4P6oOYvD+8IGK178sv5Edj0fuk+lETxX+3QGBTJrrAuaOB
89x62vECgYEA6M8NrYCJWVHL5R3RJ137uMPb79Qc6b1d8lH1AjxOGKEU1lAfVLXH
OB+3cP6WHb4sOicNJdN3jhI5JpRwI8OjnVgUWgaQ9nCjJ82F7ad37JKCQoh54yUg
XHllqn8YytytQ44eiDUcBHfckESv+mUaxVsKsP3G48NzontgVZf7WNUCgYEAzjRL
rGs4eY3px04f8zQUhhh6tL0dB4QR0kZQvwHj19FDGuxnVatrg+k42VlrHp56+j+I
ZH6JlSQaOkAcLcYJsp18cGY0r/xU7nGqlnSdmkHtzhUJLzZwbazqF/7KVi5OAI57
v635Hwa7A/ZGv6qAkGkV1wfCikccKgMERudZ6l0CgYEA2Wm7uUMngW18/4vX7m67
jHIEbDVnhvWczZayO5M7z45m2jna+I4F7SjZdEGcyUv3G5uqkJ+qr9fe3WOUUiH7
Iw7FeslVCYBpLdumbimOOjUcRqwTQAhE73dDdXTaH2D0wfjwFH2cm6OgLG6o9SsE
VDhQhLeKzNuTmrKjZWvYg70CgYBPIaaArkzn6Nv0DjkYnb3aj/5W6dQAFGC6bx2B
j3oeUkIMTPiC2dvSrWeRkU0YXP0Yl9UBq8WkpEwkWoH11u/VybX9dFt3xb/aGWi7
gFkS34Yg9dWmdp/Clv7m4nJHjFGGyScYMe1OSMjwBky0NPxNbuZgtKulYRCf1rSH
eTT6SQKBgFLGvHJxfnsZpAure6ZNqU6kwFWhtHFdAuPY+HiBjjZFi/o7TvCSN25l
nZRFEn0DYDpqgloWzjE396R8MnbKWN/+5TU0CwgVqiIX6rFocKwCyTlyR3TmY8nj
Yn6Nur2/p7J5BYETz6Ga7AJkG6PI62u3h6MtKJpGRG+CWQIKnANR
-----END RSA PRIVATE KEY-----',
  ssh_project_rsa_pubkey_contents       => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7hivh2k2Njf7rhl2bFoCnN30o5AJLBDkTSP8/JHZ/ZedB28IsaiG7Qk1x8aAT6FMxZ5qXBVu+rexAA5TsTV2NErduUKjlTvGCYLyUPuWWxtsS/bm5yRivHIm+6vhkAAdLKPNMUgBsCiz+Q1HmHEMyCfwhH+aOZgCsA4YeBPtJPM0f4tSVM/e/qaMueTnZ0h8lhhA2rapC8PJuA8low/xefzP7McqpiRn29DCFLx/EOEAjD5VcxQyJKbag2Ptx0CWZYBpdVhUyURrZMuKbm3ujsNcxP7p/9hS6xk0TlMVgmTrL5nYm0zPP4EysS5e4jqRCLlIX5VcA8P9ifcwKjvdh user@machine',
  ssh_replication_rsa_key_contents      => '-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA0In/tXrRwI6sXZOM9houEnPjzNxSHG0kYOrMUSQtsi5/OeTm
DtfnIyWyXP3rXdXrVZD7W92xfapYwcaWiTFxBq9iFnDFu1sxML+fsWZ/Vg7bmkxl
00oFSeDZhG6o7WXBlvfZISJvkIx4LkIwuyQr+sIkNPNo2xHNNxbLMQtvqDMgkbqQ
hbZG5DSzAxSymOXIgrTKqc12aQizAs6/15xj7RAWXH9wYEbV5/+PapfFQIcEkbSG
nLbwEj4EdDAixIqwsBuNFEfPH9D1qQtfhuVeh2+diEEDxzFVh+yvNAMng8or8aKL
s5AM8Mkf/nGVmlgOiD1TiS5kO8t3fq4JdWUnCwIDAQABAoIBAQDP3h6jmU9nL1Ak
3qUN0z7FaftSAvNeHnS6npEW+IcMK0jqPn4Loa5l3HeUNg7ctBUmb6P+CFeZualL
TlZTXpMZZMzTLYoLnXTE8N2PiWm4MIs5nJmLKSdoYtavKVb9fAaiI1+tpZOrdDl/
cr78a6vjAo3wsgh9BZuXJANaWdnsv20JPqQGUKgnjnr1QJpibl/TTgHFiMFnco6T
EmE76flY7CdYCUc2hsb8+3tyjiI6nIcrjHxGhEcoop+ZnoHAPAZ3M/T/1SVvtyX+
MPJB282Rr+Kpa1ZR4D7IP92Ya7dhFJ+ODrFg8zjduxMzmNEolkEaw0ppEnA0410P
XbpuhWQRAoGBAO5EQh0ck8lK4FY1Qs+T6HMKUdv+/0D1G4SLayHEZ3bxf+WDrNyi
OZa8FXnbyYrdpnqoKz8351FkrIsBp9h7baVpMuYkt2TnL2XbItCx+xT12DTJtQD4
yNLfPwqBggx5PaFtaSmhOeIfejob+bvqcN9WPQ9hmKqvWwEaDg/1sQfPAoGBAOAP
Vc24QreQqp8Mba8vb2THQ84Og3k1Tdm+QszZSDOIilXG7UZkzAoqrJiwVicaUEHG
SLSZZDLiOuQv2XuEwjINfSCHhOuF1k9dtZSQ0Fzf8DlASG+id+agMAfPhZjtBFAh
pkX1ogU5hHDfz6b04luLXS0yY71EKZpRXWMUEAAFAoGAagOlBx74AtB2EOWR3JqL
CuTEl4ZWPKjSnZ8LA/NHtfyuU4jLGUB1L0Rwqc/JVShaMqkw1Ogi3GxW+WK7M+93
UeoE47Hih9r1k/R1ATav6RuaH6LADrajZHBAtIP7QWGQsorkB8nc32fyEnjwHVSq
9DSC5p0eOJPdghf9ucwwALECgYEAkQwcZdLVDfSPH+txzikNGdaNpIVswziorz8m
C2rV/NZ1h1YCIMH7/NDnbukovKOiNRJh2tg6L16Y9UOsrPOiq7hjun1ApR+9Px/Q
/t5IpPcrkkR1IB+zMw+cSFIlkHxPgHhoJX4AZxV3EYMx8EkziEPODAZE3y+TJx1p
MUy5lukCgYEAzc/5oE1UDvqvILgifnRc+tGa5gpe2hq0n4Y7FHi7sxE7AcINpoRy
vWypSTZbg6SH57Pp5rit6+byzOBrJGoE40WqPtoNrDTxwXC09kUS0khtfh/keYCW
RL9mMhVzdWDKti2wghLHn2CtSlc+ehUjvSSmH5WAyfw0xChN4SbBheM=
-----END RSA PRIVATE KEY-----',
  ssh_replication_rsa_pubkey_contents   => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQif+1etHAjqxdk4z2Gi4Sc+PM3FIcbSRg6sxRJC2yLn855OYO1+cjJbJc/etd1etVkPtb3bF9qljBxpaJMXEGr2IWcMW7WzEwv5+xZn9WDtuaTGXTSgVJ4NmEbqjtZcGW99khIm+QjHguQjC7JCv6wiQ082jbEc03FssxC2+oMyCRupCFtkbkNLMDFLKY5ciCtMqpzXZpCLMCzr/XnGPtEBZcf3BgRtXn/49ql8VAhwSRtIactvASPgR0MCLEirCwG40UR88f0PWpC1+G5V6Hb52IQQPHMVWH7K80AyeDyivxoouzkAzwyR/+cZWaWA6IPVOJLmQ7y3d+rgl1ZScL user@machine',
  ssl_cert_file_contents                => '-----BEGIN CERTIFICATE-----
MIIDJjCCAg4CCQCKfBjXgmlfDDANBgkqhkiG9w0BAQUFADBVMQswCQYDVQQGEwJV
UzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDVNhbiBGcmFuY2lzY28xITAfBgNVBAoT
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0xNTA4MTgxODE2MDNaFw0xNjA4
MTcxODE2MDNaMFUxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMN
U2FuIEZyYW5jaXNjbzEhMB8GA1UEChMYSW50ZXJuZXQgV2lkZ2l0cyBQdHkgTHRk
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArzyMOQhRJrzKc+GH1Hym
FCxR8xNYmvN1bEFAPfbX+J6lJ7jx1iz9NCl1Ah8M7jWO76lUTTetv1zQJfqK1BSr
8yPX+jneLTCiY8dIk2vydRzHxc67SajunHO9QasyYgLogcIMYiMsGpIMUebT8XaE
PEU4Ch+1LDJonP4HVr0AnUUcHReJH3fIiS8cRoZooXDit6j1ivgoElDyMKD4/wXJ
r3aQ1xbdxFnCqIWPPvO21tixTYSc7pbj+G9Y/MTCC6L9HXKLqmlK9aJqq8ACWXUC
LD3DYp7EabS52ife1UHHllbRLfWgG3M6oKpIsbSh5jAvHYhzmVE2km5/Vgk79wOv
gQIDAQABMA0GCSqGSIb3DQEBBQUAA4IBAQA96778poIb5E44+uJVGrr8Toh8GTHC
zQoyUGqauMwW5gYock0d8B9LiqPrvpg/g42jshodpNmHNdVKhEppDDY+wRKpCDC9
1i4O4L6uendFjasd+8jieXfPsN9WuPH364ccWLIzh0a6pEHKxqdPSB5a0++rj4/C
U/K3Py8tvVJEATWJnlCAviW59CjJaMyMmzoPyLFv+3Zy4BH0jlHpnjQ73xrswwg9
rQ7mlnT7r6U4aJ/+XHrOMLG+P4gjh53rcb3fjIG1zMNQ33KM8O1+1GUPsEuzzyM/
tX3QqhcZD4jMHcXjXjIyBosK6E/VZlw0F5+3RDxw/fBp5aRSyOgPUDgu
-----END CERTIFICATE-----',
  ssl_key_file_contents                 => '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArzyMOQhRJrzKc+GH1HymFCxR8xNYmvN1bEFAPfbX+J6lJ7jx
1iz9NCl1Ah8M7jWO76lUTTetv1zQJfqK1BSr8yPX+jneLTCiY8dIk2vydRzHxc67
SajunHO9QasyYgLogcIMYiMsGpIMUebT8XaEPEU4Ch+1LDJonP4HVr0AnUUcHReJ
H3fIiS8cRoZooXDit6j1ivgoElDyMKD4/wXJr3aQ1xbdxFnCqIWPPvO21tixTYSc
7pbj+G9Y/MTCC6L9HXKLqmlK9aJqq8ACWXUCLD3DYp7EabS52ife1UHHllbRLfWg
G3M6oKpIsbSh5jAvHYhzmVE2km5/Vgk79wOvgQIDAQABAoIBADasHleg56i9WDDF
WZqK9Unv9fVvwMI/WRBYX1G11PYFkSOOiS04RhtjH9V0mJUtcpYFb37T80p0C6D9
xRicBnXKZhT0vwO8W73jrBoKoM+3FgD6GebGZQO8/HwjjImVvLLXNwPbU2RK0rsu
2EtKncEsG2rVL7JFW+w3OVTvjOSD6hmrVQuCSVwMB70t/K+Yk6r/8GL9t0bL/eh3
r4uBCRuOZ8jALRsKLTldNCgwa4VAOJG9rmkpT9LLppW2ph5JNss09CDSuA+e/l3a
ysBDZf3PNqvm4fUYTHFwKhr+kEwxPsZ9hyG/U9R1Qd7Nr3+1zKTnObrH/sRhGEUo
8hnvjEECgYEA3Bo5pgbdNF6eCsVjy9/t81/glRljGztiMfZzZtYSpAVEKUxAWysI
9g4D0v5J8fybWlEbsiWv0FHPpsadCHrWLOr0xGK+pEhxGAy4AffWo6RtMuR/DiuZ
jSKK4YxSph/nSv1MH4P4PF+FVLCh3X4LALUwV6hAFsc8XxDHmWx4rmkCgYEAy9ER
j7nsD8x/auiK8dK8ZjPEYMHvd64p3/XMQ5S6jFxD0NXFjA+6V0uWNjtShP3AA91x
vfCB5sPDzK/pM4NPySsLg9/Gr2lOvswjs3gdki+oV/ZvkTu2Ku4eVBkJO0t43Vip
CAGohZZ0qjwMhA+JRpAPTxYkf6GHx+zMdJGPBVkCgYAoWuaW+ks0fuSbNPXHO5d1
N+8FZ1I0e/7VCkq+YCGq0QxeRgzGqm1KL+ejl9wW8inJtXVOhHpnx5g7C89e7qa2
NZ4LI8+wb1fNAQf71GUWO9+JpTtmbbgJmHu+PuwoaVEO/sImRRwOdbUMghYrdiCu
UIo8iCy4AG+hPoJaLvkxgQKBgQCHrLKOBGu50J15Izdq5qd3OTqeVjr8ZjmF1m+V
BSpxSPHz0HniVI3skmp5y1+RHAF4ES8oCzPN079BQFBydBTmivrtXEc8eVNr+yRA
0dKNf6AGfguimCcZyMzzmn7ks8bPQbezlrcBxjf/Il4KgvUUvc0TDmBZfcOPOHiZ
mFOmcQKBgCLPw8ZgKWwFquYVq7na3eI6RVQmZAwVwMAtYOZhad9ijX2pw44AnGtm
6ODY3HjBvFPG7kHy3BT+GsI4VtjznIcio1/i/Nz2MHvyIHqObEm7B80J+Pb8FX8u
66ZD7D00PdKjj/BTJdR4Qj45f5rk/Gp7jzBV5kW4zzqmvdmE3mUz
-----END RSA PRIVATE KEY-----'
}

class { '::gerrit::cron': }
