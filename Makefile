# PolyLotto 통합 Makefile

CC = gcc
CXX = g++
FC = gfortran
COBC = cobc
CFLAGS = -I./include -O2
CXXFLAGS = -I./include -O2 -std=c++17
FFLAGS = -O2
COBFLAGS = -free -x

BIN_DIR = bin
SRC_DIR = src

TARGET_C = $(BIN_DIR)/lotto-core
TARGET_CPP = $(BIN_DIR)/lotto-engine
TARGET_FORTRAN = $(BIN_DIR)/lotto-stats
TARGET_COBOL = $(BIN_DIR)/lotto-reporter

all: directories $(TARGET_C) $(TARGET_CPP) $(TARGET_FORTRAN) $(TARGET_COBOL)

directories:
	mkdir -p $(BIN_DIR)

$(TARGET_C): $(SRC_DIR)/core/main.c
	$(CC) $(CFLAGS) $< -o $@

$(TARGET_CPP): $(SRC_DIR)/engine/main.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(TARGET_FORTRAN): $(SRC_DIR)/stats/main.f90
	$(FC) $(FFLAGS) $< -o $@

$(TARGET_COBOL): $(SRC_DIR)/reporter/main.cbl
	$(COBC) $(COBFLAGS) -o $@ $<

clean:
	rm -rf $(BIN_DIR)/*

.PHONY: all clean directories
