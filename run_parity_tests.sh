#!/bin/bash

# Script to run parity test suite for CDsLoc migration
# Based on _reversa_sdd/migration/parity_specs.md

set -e  # Exit on error

echo "========================================="
echo "Running Parity Test Suite for CDsLoc"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results directory
RESULTS_DIR="app/tests/results"
mkdir -p "$RESULTS_DIR"

# Function to run tests and capture results
run_tests() {
    local marker=$1
    local description=$2
    local output_file="$RESULTS_DIR/${marker}_results.txt"

    echo "Running $description tests..."
    echo "========================================="

    if pytest app/tests/parity/ -v -m "$marker" --tb=short --html="$RESULTS_DIR/${marker}_report.html" > "$output_file" 2>&1; then
        echo -e "${GREEN}✓ $description tests PASSED${NC}"
        echo "Report: $RESULTS_DIR/${marker}_report.html"
        return 0
    else
        echo -e "${RED}✗ $description tests FAILED${NC}"
        echo "Report: $RESULTS_DIR/${marker}_report.html"
        cat "$output_file"
        return 1
    fi
}

# Run test suites in order of priority
FAILED_TESTS=()

echo "Step 1: CRITICAL TESTS (Block cutover if failed)"
echo "==============================================="
run_tests "critical" "Critical" || FAILED_TESTS+=("critical")

echo ""
echo "Step 2: HIGH PRIORITY TESTS"
echo "==============================================="
run_tests "high" "High Priority" || FAILED_TESTS+=("high")

echo ""
echo "Step 3: MEDIUM PRIORITY TESTS"
echo "==============================================="
run_tests "medium" "Medium Priority" || FAILED_TESTS+=("medium")

echo ""
echo "Step 4: LOW PRIORITY TESTS"
echo "==============================================="
run_tests "low" "Low Priority" || FAILED_TESTS+=("low")

echo ""
echo "Step 5: DATA PARITY TESTS"
echo "==============================================="
run_tests "data_parity" "Data Parity" || FAILED_TESTS+=("data_parity")

echo ""
echo "Step 6: INTEGRITY PARITY TESTS"
echo "==============================================="
run_tests "integrity_parity" "Integrity Parity" || FAILED_TESTS+=("integrity_parity")

echo ""
echo "Step 7: CALCULATION PARITY TESTS"
echo "==============================================="
run_tests "calculation_parity" "Calculation Parity" || FAILED_TESTS+=("calculation_parity")

echo ""
echo "Step 8: TRANSACTION PARITY TESTS"
echo "==============================================="
run_tests "transaction_parity" "Transaction Parity" || FAILED_TESTS+=("transaction_parity")

# Generate final summary
echo ""
echo "========================================="
echo "PARITY TEST SUITE SUMMARY"
echo "========================================="
echo ""

if [ ${#FAILED_TESTS[@]} -eq 0 ]; then
    echo -e "${GREEN}ALL TESTS PASSED${NC}"
    echo ""
    echo "The new system is ready for cutover."
    echo "All critical, high, medium, and low priority tests passed."
    exit 0
else
    echo -e "${RED}SOME TESTS FAILED${NC}"
    echo ""
    echo "Failed test suites:"
    for test_suite in "${FAILED_TESTS[@]}"; do
        echo "  - $test_suite"
    done
    echo ""
    echo "Please review the failed tests and fix issues before proceeding with cutover."
    exit 1
fi