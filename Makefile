# Specify extensions of files to delete when cleaning
CLEANEXTS   = o so

# Specify the source files, the target files, 
# and the install directory 
SOURCES     = cleanmem.cpp
OUTPUTFILE  = libcleanmem.so
INSTALLDIR  = ./

.PHONY: all
all: $(OUTPUTFILE)

$(OUTPUTFILE): $(subst .cpp,.o,$(SOURCES)) 
	$(CXX) -shared -fPIC $(LDFLAGS) -o $@ $^

.PHONY: install
install:
	mkdir -p $(INSTALLDIR)
	cp -p $(OUTPUTFILE) $(INSTALLDIR)

.PHONY: clean 
clean:
	for file in $(CLEANEXTS); do rm -f *.$$file; done

# Generate dependencies of .ccp files on .hpp files
include $(subst .cpp,.d,$(SOURCES))

%.d: %.cpp
	$(CC) -M $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
rm -f $@.$$$$
