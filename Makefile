TARGET = main
CPP = g++
CPPFLAGS = -c -std=c++11 -Wall -Wextra -O3 -MD

SRCPATH = ./src
OBJDIR_RELEASE = obj/Release
OBJ_RELEASE = \
	$(OBJDIR_RELEASE)/main.o \
	$(OBJDIR_RELEASE)/timer.o \
	$(OBJDIR_RELEASE)/von_neumann.o \
	$(OBJDIR_RELEASE)/moore.o \

HEADERS = \
	$(SRCPATH)/trie.h \
	$(SRCPATH)/timer.h \
	$(SRCPATH)/print2file.h \
	$(SRCPATH)/von_neumann.h \
	$(SRCPATH)/moore.h

all: release

clean: clean_release

release: before_release out_release

before_release:
	test -d $(OBJDIR_RELEASE) || mkdir -p $(OBJDIR_RELEASE)

out_release: $(OBJ_RELEASE) $(HEADERS)
	$(CPP) -o $(TARGET) $(OBJDIR_RELEASE)/*.o -fopenmp

$(OBJDIR_RELEASE)/main.o: $(SRCPATH)/main.cpp
	$(CPP) $(CPPFLAGS) $(SRCPATH)/main.cpp -o $(OBJDIR_RELEASE)/main.o
$(OBJDIR_RELEASE)/timer.o: $(SRCPATH)/timer.cpp
	$(CPP) $(CPPFLAGS) $(SRCPATH)/timer.cpp -o $(OBJDIR_RELEASE)/timer.o
$(OBJDIR_RELEASE)/von_neumann.o: $(SRCPATH)/von_neumann.cpp
	$(CPP) $(CPPFLAGS) $(SRCPATH)/von_neumann.cpp -o $(OBJDIR_RELEASE)/von_neumann.o
$(OBJDIR_RELEASE)/moore.o: $(SRCPATH)/moore.cpp
	$(CPP) $(CPPFLAGS) $(SRCPATH)/moore.cpp -o $(OBJDIR_RELEASE)/moore.o

clean_release:
	rm $(OBJDIR_RELEASE)/*.o
	rm $(OBJDIR_RELEASE)/*.d
	rm $(TARGET)

-include $(OBJ_RELEASE:.o=.d)