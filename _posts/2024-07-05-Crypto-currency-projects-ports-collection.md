---
layout: post
title: "Crypto currency projects & ports collection"
date: 2024-07-05 08:20:36
update:
location: Saigon
tags:
- Cryptocurrency Node
categories:
- Cryptocurrency Node
seo_description: Cryptocurrency node and ports collection
seo_image: /image/posts/2024-07-05-Crypto-currency-projects-ports-collection/seo.png
comments: true
---

This post is all about crypto currency project and it's default ports. After a while, setup and deploy many project, this is a collection.

|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Name       | Port  | Description                 | NAT port forwarding                | URL                        |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Bitcoin    | 8332  | RPC                         | NO                                 |                            |
|            | 8333  | P2P                         | YES                                |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Monero     | 18080 | P2P                         | YES                                |                            |
|            | 18081 | Restricted RPC              | YES  (With Restricted RPC ONLY)    | monero.hexalink.xyz:18081  |
|            |       | Full RPC                    | NO                                 |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Monero P2P | 3333  | Stratum Server              | YES                                | monero-p2pool.hexalink.xyz |
|            | 37889 | P2P                         | YES                                |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Alephium   | 9973  | P2P                         | YES                                |                            |
|            | 10973 | Mining API                  | YES (If mining)                    |                            |
|            | 11973 | WebSocket API               | NO                                 |                            |
|            | 12973 | JSON API / Swagger          | NO                                 |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Kaspa      | 16110 | gRPC for miner + Go Wallet  | NO                                 | kaspa.hexalink.xyz:16110   |
|            | 16111 | P2P                         | YES                                |                            |
|            | 17110 | wRPC Borsh for Rusty Wallet | Yes if want to allow remote wallet |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Spectre    | 18110 | RPC for miner + Go Wallet   | NO                                 |                            |
|            | 18111 | P2P                         | YES                                |                            |
|            | 19110 | Websocket for Rusty Wallet  | YES if want to allow remote wallet |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Dynex      | 17333 | P2P                         | YES                                |                            |
|            | 17336 | P2P                         | YES                                |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
| Beam       | 10000 | P2P                         | YES                                |                            |
|------------|-------|-----------------------------|------------------------------------|----------------------------|
