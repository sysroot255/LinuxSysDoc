# Notes

## Rules

* USERNAMES are somegame0, somegame1, ...
* Most LEVELS are stored in /somegame/.
* PASSWORDS for each level are stored in /etc/somegame_pass/.

It is advised to create a working directory with a hard-to-guess name in /tmp/.
You can use the command `mktemp -d` in order to generate a random and hard to guess directory in /tmp/. 
Read-access to both `/tmp/` and `/proc/` is disabled so that users can not snoop on eachother.
For example: `/tmp/lolipopzalondo`

## Passwd

- bandit0 = bandit0
- bandit1 = boJ9jbbUNNfktd78OOpsqOltutMc3MY1
- bandit2 = CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
- bandit3 = UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
- bandit4 = pIwrPrtPN36QITSp3EQaw936yaFoFgAB
- bandit5 = koReBOKuIDDepwhWk7jZC0RTdopnAYKh
- bandit6 = DXjZPULLxYr17uwoI01bNLQbtFemEgo7
- bandit7 = HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs	
- bandit8 = cvX2JJa4CFALtqS87jk27qwqGhBM9plV
- bandit9 = UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
- bandit10 = truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
- bandit11 = IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
- bandit12 = 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
- bandit13 = 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
- bandit14 = 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
- bandit15 = BfMYroe26WYalil77FoDi9qh59eK5xNr
- bandit16 = cluFn7wTiGryunymYOu4RcffSxQluehd
- bandit17 = kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd
- bandit18 = IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
- bandit19 = IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x 
- bandit20 = GbKksEFF4yrVs6il55v6gwY5aVje5f0j
- bandit21 = 

## CMD

### Level 5

```bash
find . -size 1033c
```

### Level 7

```bash
find / -size 33c -type f -group bandit6 -user bandit7 
```

### Level 8

```bash
cat data.txt |  sort | uniq -u
```

### Level 9

```bash
at data.txt | strings | grep ====
```

### Level 10 

```bash
base64 -d data.txt
```

### Level 11

```bash
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'" && cat data.txt | rot13
```

### Level 12

```bash
xxd -r data.txt reverse.tgz
file reverse 
mv reverse reverse.gzip
gzip -d reverse.gz 
tar -xvf data6.tar 
file data8.bin 
mv data8.bin data8.gz
gzip -d data8.gz 
```

### Level 14 

```bash
echo 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e | nc localhost 30000
```

### Level 15 

```bash
openssl s_client -crlf -connect localhost:30001
```

### Level 18 

```bash
ssh  bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```

### Level 19

```bash
./bandit20-do cat /etc/bandit_pass/bandit20  
```

## Questions

- tr function
- nc

