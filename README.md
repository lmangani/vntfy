<img src="https://ntfy.sh/static/media/ntfy.813163689f875c027536f701421d9b3d.svg" width=100/>

[![vlang-build-pipeline](https://github.com/lmangani/vntfy/actions/workflows/v.yml/badge.svg)](https://github.com/lmangani/vntfy/actions/workflows/v.yml)

# vntfy
Barebone client for [ntfy.sh](https://ntfy.sh/) in [v](https://vlang.io)


### Instructions
Download a [binary release](https://github.com/lmangani/vntfy/releases/latest/download/vntfy) or build from source

### 🔎 Usage
#### Subscribe (WS/S)
```
vntfy subscribe mytopic
```
#### Publish (HTTP/S POST)
```
vntfy publish mytopic hello there!
```
#### Custom NTFY API
```
API=https://my.own.ntfy vntfy publish mytopic hello there!
```


### License
Licensed under MIT, sponsored by [qxip](https://metrico.in)
