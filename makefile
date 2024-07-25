SOURCES = main.c
EXE = out

DBG_FLAGS = -std=c11 -I./include/ -g3 -Wall -Wextra -Wpedantic -Werror -fsanitize=address,undefined -fno-strict-aliasing
DBG_CC = gcc

RLS_FLAGS = -std=c11 -I./include/ -Wall -Wextra -Wpedantic -Werror -fno-strict-aliasing -O2
RLS_CC = gcc

RLS_OBJECTS = $(SOURCES:%.c=obj/rls_%.o)
DBG_OBJECTS = $(SOURCES:%.c=obj/dbg_%.o)

obj/dbg_%.o: src/%.c
	$(DBG_CC) $(DBG_FLAGS) -c $< -o $@

debug: $(DBG_OBJECTS)
	$(DBG_CC) $(DBG_FLAGS) $(DBG_OBJECTS) -o bin/$(EXE)

obj/rls_%.o: src/%.c
	$(RLS_CC) $(RLS_FLAGS) -c $< -o $@

release: $(RLS_OBJECTS)
	$(RLS_CC) $(RLS_FLAGS) $(RLS_OBJECTS) -o bin/$(EXE)

clean:
	rm -f bin/* obj/*

run: bin/$(EXE)
	./bin/$(EXE)
