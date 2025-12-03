# scalingo-buildpack-onlyoffice
scalingo-buildpack-onlyoffice


# Get version OnlyOffice available 


```bash
curl -s https://download.onlyoffice.com/repo/debian/dists/squeeze/main/binary-amd64/Packages.gz \
  | gunzip \
  | awk '/Package: onlyoffice-documentserver-ee/{flag=1} flag && /Version:/{print $2; flag=0}'
