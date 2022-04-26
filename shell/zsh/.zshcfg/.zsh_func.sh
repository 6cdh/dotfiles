pe() {
    export readonly PROXY_ADDR="127.0.0.1:4096"
	export readonly http_proxy="socks5://${PROXY_ADDR}"
	export readonly https_proxy="socks5://${PROXY_ADDR}"
    export readonly all_proxy="socks5://${PROXY_ADDR}"
	export readonly no_proxy=localhost,127.0.0.1
    export readonly has_proxy="proxy"
}

npe() {
    unset PROXY_ADDR
	unset http_proxy
	unset https_proxy
    unset all_proxy
	unset no_proxy
    unset has_proxy
}

lcepub2mobi() {
	for book in *.epub; do
		ebook-convert "$book" "$(basename ${book} .epub).mobi" --output-profile kindle_pw3 --mobi-file-type both --mobi-ignore-margins --mobi-keep-original-images --pretty-print --no-inline-toc
	done
}

lcpdf2mobi() {
	ebook-convert "$1" "$(basename ${1} .pdf).mobi" --output-profile kindle_pw3 --mobi-file-type both --mobi-ignore-margins --mobi-keep-original-images --pretty-print --no-inline-toc
}

lcrepos() {
	find . -name .git -type d -prune
}

lcrepos_pull() {
	for each in $(lcrepos); do
		printf "\n${each%.git}\n"
		git -C "${each%.git}" pull
	done
}

lcupdate_pypkgs() {
	pip freeze — local --user | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U --user
}

lcdnsset() {
	case "$1" in
		--cloudflare)
			printf "# Generated by dns_set\nnameserver 1.1.1.1" | sudo tee /etc/resolv.conf
			;;
		--cd)
			printf "# Generated by dns_set\nnameserver 127.0.0.1" | sudo tee /etc/resolv.conf
			;;
		--google)
			printf "# Generated by dns_set\nnameserver 8.8.8.8" | sudo tee /etc/resolv.conf
			;;
		--home)
			printf "# Generated by dns_set\nnameserver 192.168.100.1" | sudo tee /etc/resolv.conf
			;;
		--school)
			printf "# Generated by dns_set\nnameserver 114.114.114.114" | sudo tee /etc/resolv.conf
			;;
		*)
			printf "Set dns server"
			printf "--cloudflare\t1.1.1.1"
			printf "--cd        \tcore dns"
			printf "--google    \t8.8.8.8"
			printf "--home      \t192.168.100.1"
			printf "--school    \t114.114.114.114"
			printf ""
			printf "Now dns server:"
			cat /etc/resolv.conf
			;;
	esac
}

lcdisable_internal_keyboard() {
	xinput list | awk '/AT Translated Set 2 keyboard/{print $7}' | sed 's/id=//' | xargs xinput float
}

lcenable_internal_keyboard() {
	xinput list | awk '/AT Translated Set 2 keyboard/{print $7}' | sed 's/id=//' | xargs -I '{}' xinput reattach '{}' 3
}

lctoolset_clang() {
	export CC=clang
	export CXX=clang++
	export LD=ld.lld
	export AR=llvm-ar
	export NM=llvm-nm
	export STRIP=llvm-strip
	export OBJCOPY=llvm-objcopy
	export OBJDUMP=llvm-objdump
	export OBJSIZE=llvm-size
	export READELF=llvm-readelf
	export HOSTAR=llvm-ar
	export HOSTLD=ld.lld
}

lctoolset_gcc() {
	export CC=gcc
	export CXX=g++
	export LD=ld
	export AR=ar
	export NM=nm
	export STRIP=strip
	export OBJCOPY=objcopy
	export OBJDUMP=objdump
	export OBJSIZE=size
	export READELF=readelf
	export HOSTAR=ar
	export HOSTLD=ld
}

lctoolset_intel() {
	source /opt/intel/oneapi/setvars.sh intel64
	export CC="icx -shared-intel"
	export HOSTCC="icx -shared-intel"
	export CXX="icpx -shared-intel"
	export LD=ld
	export AR=ar
	export NM=nm
	export STRIP=strip
	export OBJCOPY=objcopy
	export OBJDUMP=objdump
	export OBJSIZE=size
	export READELF=readelf
	export HOSTAR=ar
	export HOSTLD=ld
}

lcplugin_bench() {
	for plugin in $plugins; do
		N=1000000
		timer=$(($(date +%s%N) / N))
		if [ -f "$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh" ]; then
			source "$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh"
		elif [ -f "$ZSH/plugins/$plugin/$plugin.plugin.zsh" ]; then
			source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
		fi
		now=$(($(date +%s%N) / N))
		elapsed=$((now - timer))
		printf "$elapsed: $plugin"
	done
}

lcimage_trim() {
	convert $1 -fuzz 1% -trim +repage $1
}

lcquality_of_life() {
	for i in $(seq 10000000000); do
		seq 10 | parallel -n0 -j0 "curl -s --connect-timeout 5 $1" &>/dev/null
	done
}

function lcplot {
	text="set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitty +kitten icat --stdin yes'
    plot $@
    set output '/dev/null'"
	printf "$text" | gnuplot
}

function lccl {
	qdbus org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory
}

function arch_mirrors {
    curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -
}
