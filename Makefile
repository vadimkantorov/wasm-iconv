URL = https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz

EM_LDFLAGS = -Oz --shell-file shell_emscripten.html -sSINGLE_FILE -sMINIFY_HTML=0  -sEXIT_RUNTIME=0 -sINVOKE_RUN=0 -sFORCE_FILESYSTEM=1 -sEXPORTED_FUNCTIONS='["_main"]' -sEXPORTED_RUNTIME_METHODS='["callMain","FS"]'

libiconv:
	curl -L -O $(URL)
	mkdir -p $@
	tar -xf libiconv-*.tar.gz --strip-components=1 -C $@

iconv.html: libiconv
	cd $< && emconfigure ./configure --enable-static --disable-shared
	emmake $(MAKE) -C $<
	emcc -o $@ $(EM_LDFLAGS) $</src/iconv.o $</srclib/libicrt.a $</lib/.libs/libiconv.a

.PHONY: deploy
deploy: 
	git checkout gh-pages || git checkout -b gh-pages
	-git add -f iconv.html
	-git mv -f iconv.html index.html
	-git commit -m deploy index.html && git push
	git checkout -
