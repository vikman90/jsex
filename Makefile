# Makefile for JSex Test tool
# by Vikman
# April 29, 2017
#
# Syntax: make [ DEBUG=1 [ NODEBUG_LEXER=1 ] [ NODEBUG_PARSER=1 ] [ NODEBUG_RT=1 ]] [ PROFILE=1 ][ all | clean ]

SRC = src
INC = include

CC = gcc
RM = rm -f
CFLAGS = -pipe -Wall -I$(INC)
LIBS = -lm

TARGET = jsex
OBJECTS = main.o jsex.o cJSON.o

ifeq ($(DEBUG), 1)
	CFLAGS += -g -Wextra -DDEBUG
else
	CFLAGS += -O2
endif

ifeq ($(NODEBUG_LEXER), 1)
	CFLAGS += -DNODEBUG_LEXER
endif

ifeq ($(NODEBUG_PARSER), 1)
	CFLAGS += -DNODEBUG_PARSER
endif

ifeq ($(NODEBUG_RT), 1)
	CFLAGS += -DNODEBUG_RT
endif

ifeq ($(PROFILE), 1)
	CFLAGS += -DPROFILE
endif

.PHONY: all clean

%.o: $(SRC)/%.c $(INC)/*.h
	$(CC) $(CFLAGS) -c -o $@ $<

all: $(TARGET)

clean:
	$(RM) $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
