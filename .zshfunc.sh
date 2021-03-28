PROXY_ADDR="127.0.0.1:4097"

lcdh_proxy_enable() {
    export readonly http_proxy="http://${PROXY_ADDR}"
    export readonly https_proxy="http://${PROXY_ADDR}"
    export readonly no_proxy=localhost,127.0.0.1
}

lcdh_proxy_disable() {
    unset http_proxy
    unset https_proxy
    unset no_proxy
}

lcdh_epub2mobi() {
    for book in *.epub
    do
        ebook-convert "$book" "$(basename ${book} .epub).mobi" --output-profile kindle_pw3 --mobi-file-type both --mobi-ignore-margins --mobi-keep-original-images --pretty-print --no-inline-toc;
    done
}

lcdh_pdf2mobi() {
    ebook-convert "$1" "$(basename ${1} .pdf).mobi" --output-profile kindle_pw3 --mobi-file-type both --mobi-ignore-margins --mobi-keep-original-images --pretty-print --no-inline-toc;
}

lcdh_all_repos() {
    find . -name .git -type d -prune
}

lcdh_all_repos_pull() {
    for each in $(lcdh_all_repos)
    do
        echo "\n${each%.git}\n"
        git -C "${each%.git}" pull
    done
}

lcdh_update_pypkgs() {
    pip freeze — local --user | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U --user
}

lcdh_dnsset() {
    case "$1" in
        --cloudflare)
            echo "# Generated by dns_set\nnameserver 1.1.1.1" | sudo tee /etc/resolv.conf
            ;;
        --cd)
            echo "# Generated by dns_set\nnameserver 127.0.0.1" | sudo tee /etc/resolv.conf
            ;;
        --google)
            echo "# Generated by dns_set\nnameserver 8.8.8.8" | sudo tee /etc/resolv.conf
            ;;
        --home)
            echo "# Generated by dns_set\nnameserver 192.168.100.1" | sudo tee /etc/resolv.conf
            ;;
        --school)
            echo "# Generated by dns_set\nnameserver 114.114.114.114" | sudo tee /etc/resolv.conf
            ;;
        *)
            echo "Set dns server"
            echo "--cloudflare\t1.1.1.1"
            echo "--cd        \tcore dns"
            echo "--google    \t8.8.8.8"
            echo "--home      \t192.168.100.1"
            echo "--school    \t114.114.114.114"
            echo ""
            echo "Now dns server:"
            cat /etc/resolv.conf
            ;;
    esac
}

lcdh_disable_internal_keyboard() {
    xinput list | awk '/AT Translated Set 2 keyboard/{print $7}' | sed 's/id=//' | xargs xinput float
}

lcdh_enable_internal_keyboard() {
    xinput list | awk '/AT Translated Set 2 keyboard/{print $7}' | sed 's/id=//' | xargs -I '{}' xinput reattach '{}' 3
}

lcdh_toolset_clang() {
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

lcdh_toolset_gcc() {
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

lcdh_plugin_bench() {
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
        echo "$elapsed: $plugin"
    done
}

lcdh_image_trim() {
    convert $1 -fuzz 1% -trim +repage $1
}

