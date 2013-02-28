CFLAGS  := `gnustep-config --objc-flags` -fobjc-arc -fobjc-abi-version=3
CLINK   := `gnustep-config --base-libs` -fobjc-abi-version=3 -fobjc-arc

OBJS    := CGIApplication.o CGIRequest.o CGIResponse.o
HEADERS := CGIApplication.h CGIRequest.h CGIResponse.h CGIKit.h

all: libobjcli.so
.PHONY: all install clean

libobjc.so: $(OBJS)
	clang $(OBJS) $(CLINK) -o libobjc.so -shared

CGIApplication.o: CGIApplication.m CGIApplication.h
	clang $(CFLAGS) CGIApplication.m -o CGIApplication.o -c

CGIResponse.o: CGIResponse.m CGIResponse.h
	clang $(CFLAGS) CGIResponse.m -o CGIResponse.o -c

CGIRequest.o: CGIRequest.m CGIRequest.h
	clang $(CFLAGS) CGIResponse.m -o CGIResponse.o -c

clean:
	-rm *.o *.d *.so
