pushd "%~dp0"

SET IPADDRESS=192.168.33.11

SET HOSTSFILE=%WINDIR%\system32\drivers\etc\hosts

:: First remove existing Vagrant entries from hosts file

findstr /ve #vagrant %HOSTSFILE% > tempfile.txt
type tempfile.txt > %HOSTSFILE%
del tempfile.txt

:: Add the line to the file.
echo %IPADDRESS% scala.dev #vagrant>> %HOSTSFILE%
