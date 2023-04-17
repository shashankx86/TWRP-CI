cd /tmp/ci/out/target/product/RMX1801
ls
curl bashupload.com -T recovery.img
ls
sudo apt install pigz
cd /tmp
com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1
curl bashupload.com -T ccache*.gz
