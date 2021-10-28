all: run_dart run_exe

r.exe: r.dart Makefile
	@echo === Compiling r.dart into r.exe ===
	dart --disable-analytics compile exe --verbosity=all -D --enable-asserts r.dart

run_exe: r.exe
	@echo === Running compiled r.exe ===
	./r.exe

run_dart:
	@echo === Running interpretted r.dart ===
	dart --disable-analytics ./r.dart
