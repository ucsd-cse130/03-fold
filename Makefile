test:
	stack test

build:
	stack build

clean:
	stack clean

ghci:
	stack ghci

turnin:
	git commit -a -m "turnin"
	git push origin master

.PHONY: test build clean ghci turnin
