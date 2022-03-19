build:
	docker build --build-arg VERSION=${VERSION} -t audeldiaz/teeworlds-srv:${VERSION} . --no-cache