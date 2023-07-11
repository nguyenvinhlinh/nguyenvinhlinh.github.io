---
layout: post
title: "Chia, How to plot on terminal?"
date: 2021-04-26 15:50:34 +0700
tags: Chia
categories:
- Mining Rig
---

This post is all about ploting on terminal. First of all, you need to determine the `--farmer_public_key` and `--pool_public_key` using the following command:
```sh
chia keys show;
```

Finally, run the following command `chia plots create` to plot:
```sh
chia plots create --size 32 --num 1 --num_threads 2 --buckets 128 \
     --farmer_public_key xxxxxx \                            # <--- modify here to your farmer public key
     --pool_public_key yyyyyy \                              # <--- modify here to your pool  public key
     --tmp_dir /home/nguyenvinhlinh/Temporary/Chia/tmp/ \    # <--- modify here to your temporary path
     --final_dir /home/nguyenvinhlinh/Temporary/Chia/plots/; # <--- modify here to your final path
```
For more details, please check command reference with command `chia plots create --help;`
```sh
Usage: chia plots create [OPTIONS]

Options:
  -k, --size INTEGER              Plot size  [default: 32]
  --override-k                    Force size smaller than 32  [default: False]
  -n, --num INTEGER               Number of plots or challenges  [default: 1]
  -b, --buffer INTEGER            Megabytes for sort/plot buffer  [default:
                                  3389]

  -r, --num_threads INTEGER       Number of threads to use  [default: 2]
  -u, --buckets INTEGER           Number of buckets  [default: 128]
  -a, --alt_fingerprint INTEGER   Enter the alternative fingerprint of the key
                                  you want to use

  -c, --pool_contract_address TEXT
                                  Address of where the pool reward will be
                                  sent to. Only used if alt_fingerprint and
                                  pool public key are None

  -f, --farmer_public_key TEXT    Hex farmer public key
  -p, --pool_public_key TEXT      Hex public key of pool
  -t, --tmp_dir PATH              Temporary directory for plotting files
                                  [default: .]

  -2, --tmp2_dir PATH             Second temporary directory for plotting
                                  files

  -d, --final_dir PATH            Final directory for plots (relative or
                                  absolute)  [default: .]

  -i, --plotid TEXT               PlotID in hex for reproducing plots
                                  (debugging only)

  -m, --memo TEXT                 Memo in hex for reproducing plots (debugging
                                  only)

  -e, --nobitfield                Disable bitfield
  -x, --exclude_final_dir         Skips adding [final dir] to harvester for
                                  farming

  -h, --help                      Show this message and exit.
```
