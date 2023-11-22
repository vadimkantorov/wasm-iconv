URL = https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz

EM_LDFLAGS = -Oz --shell-file shell.html -sSINGLE_FILE -sMINIFY_HTML=0  -sEXIT_RUNTIME=0 -sINVOKE_RUN=0 -sFORCE_FILESYSTEM=1 -sEXPORTED_FUNCTIONS='["_main"]' -sEXPORTED_RUNTIME_METHODS='["callMain","FS","PATH"]'

libiconv:
	curl -L -O $(URL)
	mkdir -p $@
	tar -xf libiconv-*.tar.gz -C $@

iconv.html: libiconv
	ls
	ls libiconv
	cd $<
	emconfigure ./configure --enable-static --disable-shared
	cd ..
	emmake make -C $<
	emcc -o $@ $(EM_LDFLAGS) $</src/iconv.o $</srclib/libicrt.a $</lib/.libs/libiconv.a
