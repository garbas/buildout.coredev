NIX_PATH=~/.nix-defexpr/channels/

all: dev.nix
	nix-channel --update
	NIX_PATH=${NIX_PATH} nix-build --out-link nixenv dev.nix
	./nixenv/bin/virtualenv --distribute --clear .
	echo ../../../nixenv/lib/python2.7/site-packages > lib/python2.7/site-packages/nixenv.pth
	rm -f bin/buildout
	ln -s ../nixenv/bin/buildout-nix bin/buildout

print-python-syspath:
	./bin/python -c 'import sys,pprint;pprint.pprint(sys.path)'

.PHONY: print-syspath
