#copy paste in device terminal

opkg update
opkg install luci-ssl
#activate https for LuCI web interface
uci set uhttpd.main.redirect_https=1
uci commit uhttpd && service uhttpd reload

#uci set system.@system[0].ttylogin="1"
#uci commit system
#service system restart
