.PHONY: docs clean hugo-mod docs-local docs-drafts netlify

docs: 
	hugo server --disableFastRender

clean:
	rm -rf ./public

hugo-mod:
	hugo mod clean
	hugo mod get

docs-local: clean 
	hugo

docs-drafts:
	hugo server -D --disableFastRender

netlify: clean
	netlify deploy --build -d public --alias $(shell git branch --show-current)-branch 
